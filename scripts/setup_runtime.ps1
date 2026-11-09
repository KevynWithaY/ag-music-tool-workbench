# Rebuilds the entire local runtime (%LOCALAPPDATA%\VocalStemRegen) from scratch:
# four venvs, third-party clones, Apollo checkpoint. Safe to re-run.
#
# Requires: Python 3.12 (py launcher), git, ffmpeg on PATH, NVIDIA GPU driver.
$ErrorActionPreference = "Stop"
$rt = & (Join-Path $PSScriptRoot 'resolve_runtime.ps1')
$env:AMTW_RUNTIME = $rt
New-Item -ItemType Directory -Force -Path "$rt\venvs", "$rt\third_party", "$rt\models\apollo", "$rt\models\uvr", "$rt\hf_cache", "$rt\logs" | Out-Null

function Venv-Python($name) { "$rt\venvs\$name\Scripts\python.exe" }

# ---- torch build per GPU ------------------------------------------------------
# sm_120 (RTX 50-series "Blackwell") has no kernels in any pre-2.7 torch: the
# cu124 wheels below cap out at sm_90 and model inference fails with "no kernel
# image". cu128 wheels (torch >= 2.7) cover sm_70 through sm_120, so on those
# cards every engine venv takes unpinned torch from the cu128 index instead.
# Checks every GPU so a mixed box still gets the right build.
$needCu128 = $false
try {
    $needCu128 = $null -ne (& nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>$null |
        ForEach-Object { [int]($_.Trim() -split '\.')[0] } |
        Where-Object { $_ -ge 12 } |
        Select-Object -First 1)
} catch { }
if ($needCu128) {
    Write-Host "sm_120+ GPU: engine venvs get torch cu128 -- the pinned cu124 builds have no kernels for this card" -ForegroundColor Yellow
}

# The pinned cu124 versions are the verified engine combos and stay the
# default. On sm_120+ the pins drop with the build, because cu128 wheels only
# exist for torch >= 2.7. Newer-torch-on-engine is expected to work but
# unverified -- doctor plus one real pipeline run is the check.
function Install-EngineTorch($venv, [string[]]$pinned) {
    if ($needCu128) {
        $pkgs = $pinned | ForEach-Object { ($_ -split '==')[0] }
        & (Venv-Python $venv) -m pip install @pkgs --index-url https://download.pytorch.org/whl/cu128
    } else {
        & (Venv-Python $venv) -m pip install @pinned --index-url https://download.pytorch.org/whl/cu124
    }
}

# ---- main venv: orchestrator + audio-separator (UVR models) ----------------
if (-not (Test-Path (Venv-Python "main"))) { py -3.12 -m venv "$rt\venvs\main" }
& (Venv-Python "main") -m pip install -q -U pip
& (Venv-Python "main") -m pip install audio-separator onnxruntime librosa soundfile pyloudnorm matplotlib huggingface_hub mido
# GOTCHA: audio-separator drags in a CPU-only torch from PyPI. The CUDA build
# must be force-reinstalled AFTER it, from the PyTorch index:
& (Venv-Python "main") -m pip install --force-reinstall torch torchaudio --index-url https://download.pytorch.org/whl/cu128

# ---- msst venv: Apollo vocal enhancer host ---------------------------------
if (-not (Test-Path "$rt\third_party\msst\inference.py")) {
    git clone --depth 1 https://github.com/ZFTurbo/Music-Source-Separation-Training "$rt\third_party\msst"
}
if (-not (Test-Path (Venv-Python "msst"))) { py -3.12 -m venv "$rt\venvs\msst" }
& (Venv-Python "msst") -m pip install -q -U pip
Install-EngineTorch msst @("torch==2.6.0", "torchaudio==2.6.0")
& (Venv-Python "msst") -m pip install -e "$rt\third_party\msst[apollo]"   # no requirements.txt anymore; pyproject extras

# ---- seedvc venv: seed-vc voice conversion ---------------------------------
if (-not (Test-Path "$rt\third_party\seed-vc\inference.py")) {
    git clone --depth 1 https://github.com/Plachtaa/seed-vc "$rt\third_party\seed-vc"
}
if (-not (Test-Path (Venv-Python "seedvc"))) { py -3.12 -m venv "$rt\venvs\seedvc" }
& (Venv-Python "seedvc") -m pip install -q -U pip
Install-EngineTorch seedvc @("torch==2.4.0", "torchaudio==2.4.0", "torchvision==0.19.0")
# seed-vc requirements FILTERED for CLI inference on py3.12: drops gradio,
# sounddevice, FreeSimpleGUI (UI), resemblyzer, jiwer (eval; resemblyzer's
# webrtcvad dep has no py3.12 wheels).
& (Venv-Python "seedvc") -m pip install transformers==4.46.3 accelerate modelscope==1.18.1 funasr==1.1.5 `
    librosa==0.10.2 descript-audio-codec==1.0.0 soundfile==0.12.1 pydub==0.25.1 scipy==1.13.1 `
    numpy==1.26.4 einops==0.8.0 "huggingface-hub>=0.28.1" hydra-core==1.3.2 munch==4.0.0 pyyaml python-dotenv

# ---- ymsvc venv: YingMusic-SVC (seed-vc fork, robust singing conversion) ----
if (-not (Test-Path "$rt\third_party\yingmusic\my_inference.py")) {
    git clone --depth 1 https://github.com/GiantAILab/YingMusic-SVC "$rt\third_party\yingmusic"
}
if (-not (Test-Path (Venv-Python "ymsvc"))) { py -3.12 -m venv "$rt\venvs\ymsvc" }
& (Venv-Python "ymsvc") -m pip install -q -U pip
Install-EngineTorch ymsvc @("torch==2.4.0", "torchaudio==2.4.0", "torchvision==0.19.0")
# same filtered set as seedvc + YingMusic extras (ml_collections, loralib, pinned beartype/rotary)
& (Venv-Python "ymsvc") -m pip install transformers==4.46.3 accelerate modelscope==1.18.1 funasr==1.1.5 `
    librosa==0.10.2 descript-audio-codec==1.0.0 soundfile==0.12.1 pydub==0.25.1 scipy==1.13.1 `
    numpy==1.26.4 einops==0.8.0 "huggingface-hub>=0.28.1" hydra-core==1.3.2 munch==4.0.0 pyyaml python-dotenv `
    ml_collections loralib "beartype==0.14.1" "rotary_embedding_torch==0.3.5"

# ---- YingMusic-SVC checkpoint -----------------------------------------------
New-Item -ItemType Directory -Force -Path "$rt\models\yingmusic" | Out-Null
$env:HF_HOME = "$rt\hf_cache"
& (Venv-Python "main") -c @'
from huggingface_hub import hf_hub_download
import shutil, os, pathlib
d = pathlib.Path(os.environ["AMTW_RUNTIME"]) / "models" / "yingmusic"
if not (d / "YingMusic-SVC-full.pt").exists():
    shutil.copy2(hf_hub_download("GiantAILab/YingMusic-SVC", "YingMusic-SVC-full.pt"), d / "YingMusic-SVC-full.pt")
print("yingmusic checkpoint ready")
'@

# ---- Apollo checkpoint (Lew's vocal enhancer, MSST packaging) ---------------
$env:HF_HOME = "$rt\hf_cache"
& (Venv-Python "main") -c @'
from huggingface_hub import hf_hub_download
import shutil, os, pathlib
d = pathlib.Path(os.environ["AMTW_RUNTIME"]) / "models" / "apollo"
for f in ["model_apollo_vocals_ep_54.ckpt", "config_apollo_vocals_ep_54.yaml"]:
    if not (d / f).exists():
        shutil.copy2(hf_hub_download("baicai1145/Apollo-vocal-msst", f), d / f)
print("apollo checkpoint ready")
'@

Write-Host "`nRuntime ready. Verify with: .\amtw.ps1 doctor"
# Note: UVR de-reverb weights and seed-vc checkpoints auto-download on first
# pipeline run (seed-vc's are several GB).
