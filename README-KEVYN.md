# README-KEVYN — the newcomer's version

A plain-English summary of what this thing is, what it downloads, and how much
disk it eats. Sources: `docs/architecture.md`, `docs/local-layout.md`,
`docs/runtime-resources.json`, `scripts/setup_runtime.ps1`.

## Quick start
1. Create a folder "amtw" on your target drive.
2. Clone to the repo to a folder under that, e.g. `amtw\ag-music-tool-workbench`.
3. Create a "runtime" folder under "amtw", e.g. `amtw\runtime`.
4. Install Python 3.12, git, and ffmpeg on PATH
5. Run `.\setup_runtime.ps1` to download models and set up engines
6. Double-click `Workbench.cmd` to open the web UI
7. Use the web UI or CLI (`.\amtw.ps1 <tool>`) to process audio

## What it does

It's a **local web "workbench"** for music-production tools. Double-click
`Workbench.cmd`, a browser opens at `http://127.0.0.1:8730`, and every tool
shows up as a form with real widgets (file pickers, sliders, checkboxes). The
page just builds a command line and runs it — everything also works from the
CLI via `.\amtw.ps1 <tool>`.

The tools mostly serve people working with **AI-generated music** (Suno stems):

- **Vocal stem restoration** (`run`): takes a rough AI vocal stem, strips
  baked-in reverb, then regenerates the damaged high-frequency detail. The
  shipped recipe is `--stages cleanup,superres`.
- **Fry "scrape" repair** (`harmonic`, `detect`, `ab`): fixes a scratchy
  artifact AI stems bake into vocal fry. You mark the scratchy spots in the
  A/B listening tool, the repair only touches those regions.
- **MIDI repair** (`midi-merge`, `midi-inspect`): fixes Suno's stem-to-MIDI
  exports, which split one instrument across two tracks and double-trigger
  notes.
- **Drum cleanup, harmony analysis, tempo maps, Bitwig integration**: assorted
  smaller tools on the same bench.

## What models it uses

| Model | Size | Used by | Where it comes from |
|---|---|---|---|
| Apollo vocal enhancer (Lew, ep54) | ~194 MB | `run` superres stage — the star of the show | HuggingFace `baicai1145/Apollo-vocal-msst`, fetched by `setup_runtime.ps1` |
| UVR de-reverb models (DeEcho-DeReverb + Mel-Band Roformer checkpoints) | ~224 MB–913 MB each | `run` cleanup stage | auto-download on first pipeline run |
| Apollo universal (optional) | ~147 MB | superres on drums/bass/guitar/synth | HuggingFace `ASesYusuf1/Apollo_universal_model` |
| seed-vc f0-conditioned singing model | several GB | `run` resynth stage (**disabled by default** — three engines warbled on sustained notes) | auto-downloads from HuggingFace only if you run resynth |
| YingMusic-SVC | ~732 MB | resynth stage, same caveat | HuggingFace `GiantAILab/YingMusic-SVC`, fetched by setup |
| Soundfont (.sf2) + FluidSynth (optional) | varies | `harm-render` — otherwise a built-in synth is used | you supply them |

Everything above is PyTorch/CUDA — you need an **NVIDIA GPU**, Python 3.12,
git, and ffmpeg on PATH. Windows-only today.

**RTX 50-series (Blackwell) note:** the engine venvs' pinned torch builds
(cu124) predate Blackwell — no sm_120 kernels, inference fails. The setup
script detects sm_120+ via `nvidia-smi` and installs a cu128 torch
(≥2.7) in `msst`/`seedvc`/`ymsvc` automatically; older GPUs keep the
verified pins. The `main` venv is always cu128.

## How much disk

The author's full runtime measured **~49 GB**:

- ~27 GB — four Python virtualenvs (each carries its own CUDA torch build,
  because the engines' dependencies genuinely conflict)
- ~16 GB — third-party source trees (MSST, seed-vc, YingMusic-SVC, Amphion)
- ~5 GB — model checkpoints + HuggingFace cache
- plus soundfonts and tools

You can opt out of most of that: `scripts/setup_harmony.ps1` builds a
**~100 MB** runtime (Python + mido, ~30 MB more with audio support) that runs
the MIDI, harmony, and Bitwig tools — no models, no GPU. The full
`setup_runtime.ps1` tops it up later if you want the audio pipeline.

Also note `output/` inside the repo grows to several GB of job renders (it's
gitignored).

## Where it all downloads to

**Nothing heavy goes in the project folder.** The repo is code only; weights,
venvs, clones and the HF cache live in a separate "runtime root" — deliberately
outside cloud-synced folders, because a sync client will corrupt a venv
mid-install. (This repo sits in OneDrive; do NOT point the runtime anywhere
under OneDrive.)

Runtime root resolution order:

1. `AMTW_RUNTIME` env var (legacy `VSR_RUNTIME` also works)
2. A pointer file: `%USERPROFILE%\.config\amtw\runtime.json` containing
   `{"runtime_root": "D:\\AudioTools\\runtime"}` — pick your own path
3. Fallback: `%LOCALAPPDATA%\VocalStemRegen` (the legacy folder name)

Inside the runtime root:

```
runtime/
  venvs/         main, msst, seedvc, ymsvc   (~27 GB)
  third_party/   msst, seed-vc, yingmusic, amphion clones
  models/        apollo/, uvr/, yingmusic/
  hf_cache/      HF_HOME -- HuggingFace downloads land here
  logs/
```

The author's machine keeps it at `C:\audio\shared\amtw-runtime`. For your
fork, pick a fresh path on a non-synced drive, write the `runtime.json`
pointer, run `.\scripts\setup_runtime.ps1` (or `setup_harmony.ps1` for the
lightweight version), then `.\amtw.ps1 doctor` to verify.

Exact model hashes and pinned package versions are recorded in
`docs/runtime-resources.json` and `docs/runtime-environments/`.
