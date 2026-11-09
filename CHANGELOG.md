# Changelog

All notable changes to this project are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
versioning is [semantic](https://semver.org/spec/v2.0.0.html). Every change
should land with its own entry under `[Unreleased]` — that's how the next
session finds out what moved.

## [Unreleased]

### Added — 2026-11-08
- `README-KEVYN.md`: a plain-English fork-owner's summary of what the
  workbench does, which models it downloads (~49 GB full runtime vs ~100 MB
  harmony-only), and where the runtime root lives.

### Fixed — 2026-11-08
- `setup_runtime.ps1` detects sm_120+ GPUs (RTX 50-series "Blackwell") via
  `nvidia-smi` and installs unpinned torch from the cu128 index in the engine
  venvs — the pinned cu124 builds cap out at sm_90 and fail at inference on
  those cards. Older GPUs keep the verified cu124 pins. Engine-on-newer-torch
  is expected to work but unverified; doctor plus one real run is the check.

### Recovery checkpoint — 2026-09-13
- Saved the complete Monsters Loose scene roughout state: 31 stills across
  15 scenes, reference-image versions and approvals, timeline notes, timing data,
  prompts, review pages, editable Blender rigs and native Bitwig project files.
  SHA-256 manifest and restore instructions exclude audio/video payloads.
- Recorded the next step: scene feedback and small video-generator trials before
  committing to detailed shots and generation start/end images.

### Fixed — 2026-09-13
- Asset catalog list scrolls independently with search and filters retained,
  so browsing references keeps the selected image and review controls in view.

### Added — 2026-09-13
- Recorded the Monsters Loose all-night visual direction: artificially lit
  interiors, readable moonlit/practical-lit exteriors and a remote coastal-swamp
  zoo/laboratory establishing reference.
- Linked asset catalog with stable asset/version and scene IDs, searchable
  references, per-version approval, recoverable feedback drafts, local dictation
  and atomic review history. Shared navigation connects assets and video notes.
- Direct note dictation: browser Record/Stop controls feed local cached Whisper
  turbo, append editable text, pause the song and preserve the note anchor.
  Includes cancellation, retry, a three-minute limit and temporary-file cleanup.
- Lightweight listening notes surface: anchored timeline zoom, phrase stepping,
  approximate point/range notes, active versus addressed views, reopening,
  browser draft recovery, atomic project saves and revision history. Available
  as Video / Listen and mark creative notes. Blender remains the render rig.
- Saved the Monsters Loose production direction: overlapping continuous takes,
  narrative and musical visualizers, cutaway coverage, and the user's provider
  preferences; no shot count or generation commitments imposed.
- Blender VSE lyric animatic builder in the Video workbench, following the
  Rivers of Mars workflow: editable timed words, duration underlines, restrained
  emphasis, DAWproject tempo markers, measured vocal RMS and master audio.
  Includes a separate .blend and optional full-song H.264/AAC preview.
- Performed-word alignment and a vocal timing audition server in the Analysis
  workbench. Independent acoustic word edges, uncertainty flags, source/master
  offsets, word JSON/CSV, phrase VTT, and clean-vocal/master playback.
- [Monsters Loose timing checkpoint](docs/monsters-loose-timing-checkpoint.md):
  reconciled first pass against the lyric worksheet, including provisional
  ad-libs, repeat counts and unresolved backing events. Not listening verified.

### Added — 2026-09-12
- [MonstersUndone stopping point](docs/monsters-undone-checkpoint.md): user saved
  and closed the native project after further setup; stem processing is complete
  for now. Next are overdubs, then a Rivers of Mars-style music visualizer video.
- Delivered six aligned drum tracks into MonstersUndone's Drums group and
  collected verified audio into the native project. Original/ride/crash muted;
  untreated kick/snare/percussion and Apollo hi-hat/shaker active.
- Full-length drum delivery tool with selective Apollo hi-hat/shaker processing,
  stereo-aware activity detection, padded transitions and preserved quiet audio.
  Retains six untreated parts alongside source-rate delivery files.
- Finalized Apollo for combined hi-hat/shaker on future drum import, accepting
  the softer bead texture; retain untreated snare and optional live-shaker augmentation.
- Recorded tentative Apollo preference on hi-hats for reduced artificial
  scratchiness, with lost presence still an unresolved tradeoff.
- Recorded rejection of Apollo on snare: retain untreated separation for its
  preferred presence and brightness; hi-hat/shaker decision remains open.
- Apollo universal refinement auditions for separated snare and hi-hat/shaker,
  with contextual rendering, solo/difference and recombined-kit comparisons.
  Exposed on the Drums workbench using the existing MSST environment.
- Recorded approval of ending hi-hat/percussion separation and near-empty
  ride/crash; the initial drum-separation listening checks are complete.
- Recorded hi-hat approval and shaker-preservation preference; prepared an
  ending audition to check shaker/accents and near-silent ride/crash outputs.
- Recorded usable kick/snare/toms separation, optional bleed retention, and
  checked snare levels with audition matching disabled.
- Recorded positive but modest recombined-drum listening verdict; individual
  isolation and transient improvement remain unconfirmed.
- Drum separation audition on the workbench: six-part MDX23C with contextual
  excerpts, original/recombined/difference files and provenance. Uses existing
  MSST runtime. Prepared three MonstersUndone excerpts for listening.
- Recorded backing-vocal approval, measured stereo retention in both Renaissance
  renders, and outlined a staged drum-separation/cleanup audition.
- Full Renaissance backing-vocal pass placed beneath the original in MonstersUndone,
  with original muted and rendered sample collected into the saved project.
  Recorded the user's full-song lead approval; backing listening verdict pending.
- Full-song Renaissance cleanup tool, following the user's accepted core-vocal
  audition. Contextual overlap rendering retains the source sample rate/count;
  no Apollo, trimming or gain normalization. Saved MonstersUndone with the new
  Raw audio track beneath the original and collected its sample into the project.
- Vocal restoration audition on the Listening workbench: short original/Apollo/
  Renaissance comparisons with a source-minus-Renaissance difference signal,
  surrounding context, exact-length reconstruction and per-channel lag/width
  diagnostics. Renaissance uses the existing main environment; its code, weights
  and rendered audio live in the shared runtime. See `docs/renaissance-audition.md`.
- Current stem-restoration research shortlist, including Smule Renaissance's
  mono preprocessing caveat and MSR/LOUDAR/SonicMaster follow-ups. This is a
  source-linked audit, not a local listening result; see
  `docs/stem-restoration-audit-2026-09-12.md`.
- Canonical runtime pointer and shared launcher/installer resolution, including
  discovery of Claude's packaged-app runtime. Recovered and relocated the
  complete working runtime with compatibility junctions; Doctor now passes.
  Added model hashes, engine revisions, environment inventories, and archived
  listening notes for cross-machine recovery. Code remains in the GitHub repo;
  audio, weights and environments remain outside Git. See `docs/local-layout.md`.
- Live Bitwig project bridge: official JavaScript controller, loopback TCP
  broker, stdio MCP adapter and four workbench tools. Reads up to 64 tracks and
  transport; edits name/mute/solo/volume/pan with stale-state checks and readback.
  Installed the personal `bitwig-live` plugin and verified live reads, a group
  rename/restoration and stale rejection in Bitwig 6.1. Exact notes, tempo ramps
  and audio replacement are not implemented in this bridge yet. See
  `docs/bitwig-live.md` for setup and limits.
- `project-groove` on the workbench: identify unedited Suno MIDI groups by
  exact note fingerprints, consolidate and clean them with the existing MIDI
  rules, measure a shared non-vocal audio offset, and write an embedded-audio
  DAWproject with linear tempo ramps. Drum anchors lead; agreement between
  non-vocal stems fills drumless passages. Source MIDI supplies the prior when
  imported tempo points were not moved with the clips. Notes are inverse-mapped
  through the written lane to preserve their source performance times. Original
  projects are never overwritten; audio archive entries are hash-verified.
- The new workflow removes terminal-only CC7 messages that Bitwig imports as
  track-long volume ramps, but refuses unexpected controllers or edited notes.
  Review WAVs, anchor errors, cleanup counts and timing checks accompany output.
  Thinning is constrained to less than 1 ms of cumulative drift, and the bench
  now recognizes `.dawproject` files as clickable run results.
- Restored the existing NumPy/SciPy/librosa/soundfile/matplotlib analysis
  dependencies in the local main runtime. No new engine dependencies; full
  `doctor` still fails on pre-existing missing Torch, engines and model files.

### Added
- **docs/using-the-ab-tool.md** — how another agent should prepare, launch
  and read back an `amtw ab` listening test: file-preparation rules, the
  keyboard map, the notes JSON schema and its consumers, and the gotchas
  (never POST into a live session; loudness matching is on by default).
  Linked from CLAUDE.md and AGENTS.md.
- **`suno-project` — a Suno Stems folder → a Bitwig starter project.** One
  folder of `<song> (Instrument).wav/.mid` pairs in; one light `.dawproject`
  out (85 KB): the tempo lane bent to the drums (tempo-map's solver, plus
  the downbeat pinned to the measured per-song offset), one cleaned note
  track per stem with notes placed at their *audio* time through the new
  lane, velocities read off each note's own harmonic band in the stem
  (fixed 24 dB range below the stem's loud reference, floor 30 so
  split-softened notes still sound; drums per piece), per-note pitch curves
  on lead vocal and bass as DAWproject `transpose` expression, and an empty
  audio track per stem. Prints the drop position (bar.beat.16th) it derived
  — 2.4.2.00 on RiversOnMars, the same one the user had chosen by hand. No
  per-note gain envelopes, by request. Project XML is written from scratch
  in the shape Bitwig exports (ids, Master channel, Scene/ClipSlots).
- `midi-clean` rules are now callable in-memory (`clean.clean_notes`).
- **`tempo-map` — a performance-following tempo lane for a Bitwig project,
  from the drum stem.** Reads a `.dawproject`, follows the drum audio inside
  it, anchors every 16th it can to a hit (bounded rule: within 40% of a grid
  step of where the existing lane predicts it), solves linear tempo ramps by
  least squares so each anchored 16th lands on its hit while a weak pull
  keeps the lane near the prior (the S-curve the user draws by hand), thins
  the points, and writes `<name>.tempo.dawproject` — every other zip entry
  byte-identical, outer clip durations re-covered, the count-in kept flat.
  Also writes a drums+click mix rendered from the *written* lane for the A/B
  tool and a picture of anchor errors and hit-vs-prior offsets. First run on
  RiversOnMars: 849 hits, 844 anchored, median anchor error 2.9 ms, tempo
  within −2.9%…+3.2% of Suno's lane, 694 points over 71 bars (the user's hand
  maps run ~8 points a bar). DAWproject is the delivery format because its
  `TempoAutomation` holds linear-interpolated points — ramps — which a MIDI
  file cannot.
- Bench file browser gained a `bitwig` root (Bitwig Studio/Projects).
- `tempo-map --light` (on by default) also writes `<name>.tempo.light.dawproject`:
  the same tempo lane and note clips with every audio clip and wav removed,
  audio tracks left empty — 274 KB instead of 289 MB, for opening in Bitwig
  and dropping the stems in by hand to check the lane against the audio.
- **`midi-clean` — instrument-aware cleanup of Suno per-stem MIDI, with
  alignment to the wav.** Select a whole Stems folder: each file is measured
  against the wav of the same name (onset cross-correlation), the per-song
  median offset is applied — Suno's MIDI runs 0.1–0.55 s early, see
  findings — tracks fold to one, same-pitch tail re-detections extend the
  note rather than flicker, stray sub-30 ms notes go, and polyphony is capped
  per instrument by voice stealing (lead 1, bass 2, backing 4, guitar 6,
  keys 12). Drums and FX keep their 1 ms triggers and only lose
  double-triggers inside 15 ms. Reports every count. Ran clean over 474
  exports.
- `write_midi` now substitutes non-latin-1 characters in track names instead
  of letting mido raise — Suno titles with an em-dash were unwritable by
  `midi-merge` too.
- **Universal Apollo as a superres model choice** (`--apollo-model
  vocal|universal`). Lew's universal checkpoint (the model MVSEP runs as
  "Universal Super Resolution") restores any instrument, which opens the
  restore chain to drum/bass/guitar/synth stems. Downloaded from
  `huggingface.co/ASesYusuf1/Apollo_universal_model` into the runtime model
  dir; doctor reports it as optional rather than failing without it. Smoke
  test on a synth clip: sample-exact length, residual -16.2 dB vs source
  (the vocal model barely touches instruments, so this is real new work).
- **`--skip-silence` on the run pipeline** (on by default on the bench).
  Superres finds active spans (50 ms RMS above `--silence-db`, default
  -55 dBFS, padded 1 s, merged across gaps under 3 s) and sends only those
  through Apollo. Quiet stretches stay the *literal original samples* — the
  same untouched-samples guarantee the fry tools make, verified bit-identical
  on a real stem — and sparse files finish in roughly the processed fraction
  of the usual time. Files with under 15% skippable audio process whole, so
  dense material never gains splice seams.

### Documented
- **docs/stem-toolset-roadmap.md** — per-stem-type restoration plan after a
  research pass (Apollo universal ckpt located on HF, karaoke roformers already
  in audio-separator, SonicMaster/AnyEnhance/FlashSR on a watchlist with the
  generative-warble caveat attached). Build order: universal Apollo in
  superres, stem profiles on the bench, wet/dry layer tool, karaoke split.
- **`--deecho` is the harmony-eater, not de-reverb** (docs/findings.md). On a
  mixed solo/stacked lead stem the classic de-reverb pass removed −31.1 dB
  overall and left band balance flat to 0.1 dB, while the optional `--deecho`
  roformer removed −15.0 dB overall and up to −2.0 dB — most of the block —
  in exactly the passages where the backing stack is loudest. Also recorded:
  a chroma-based screen for telling a removed tail from a removed voice, and
  two tail/echo proxies that do not work on continuous singing.

### Added
- **Bitwig bridge — the workbench, reachable from inside the DAW.**
  `bitwig-install` builds and installs a control-surface extension;
  `bitwig-bridge` runs the workbench end. Select a chord clip in Bitwig, press
  **Reduce** in the project panel, and the line lands in a NEW clip on the same
  track and opens in the editor. **Analyse** names the progression in a popup.

  The extension is a transport with no music theory in it — it reads the
  selected clip, writes notes, shows popups. Everything that knows what a chord
  is stays in Python, so there is one implementation rather than a Java twin
  that drifts. The cost is honest: the bridge must be running, and the
  extension degrades quietly when it is not (one console line, no nagging).

  **No JDK and no Maven fetch.** It compiles with the Eclipse batch compiler
  running on Bitwig's own bundled `java.exe`, against the 395 API classes
  already inside `bitwig.jar`. Three constraints found the hard way, all
  documented at their call sites: Bitwig's JRE is jlink-trimmed to 21 modules
  with no `jdk.zipfs`, so ecj cannot read a jar classpath and the API is
  unpacked to a directory first; from a directory ecj loses the `NoteStep$State`
  nested class and erases `Bank` generics to `ObjectProxy`, so the note-start
  test compares the enum's name and slot access is cast; and `--release` needs
  a JDK's `ct.sym`, so it targets `-source/-target 17`.

  Writes always go to a new clip, never in place — rejecting a result should be
  deleting a clip, not unwinding a batch of `setStep` calls through undo.
- **`amtw/tools/bitwig/osc.py`** — just enough OSC (address, type tag, s/i/f/d/b)
  to talk to Bitwig, rather than adding a dependency for one fixed message shape.
- **`harm-reduce --retrigger`** — re-strike on every chord change instead of
  holding a common tone across it. On the reference material `smooth` picks the
  same pitch three bars running, which merges four chords into two notes; held
  is right for a sustained line, retriggered for articulating harmonic rhythm.

- **`harm-read` — harmonic readout for music written as independent lines.**
  New `Harmony` group. Reads a MIDI file whose tracks are voices and reports,
  per bar, the chord those lines make, *every* major key that still contains
  it, and — the part no chord symbol shows — which single voice is narrowing
  that set. It never suggests a next chord; it says what the lines already made
  and what it is still free to become.

  Query flags, which is where the value actually is: `--together F B` (is the
  key-defining tritone ever *held*, or only crossed in passing — duration is
  reported, because a 0.01-beat overlap is a note-boundary artifact),
  `--where B` (where the leading tone actually lives), `--pivots-from N`
  (which single semitone move relocates a bar into another key), `--tonic C`
  (read the fitting collections back as modes), `--bars` / `--voices` to scope
  it, and `--json` for a visualiser to consume.
- **`harm-map`** — the foundation view. Writes a self-contained HTML page: one
  timeline with every defensible reading of each bar, the key-fit ribbon, and
  a roman-numeral row that rewrites itself from readings you pin. The lens
  selector (most complete / rooted on the bass / root must be sounding /
  functional in the tonic) **reorders** readings and never removes one.
- **The map can be heard.** `harm-map` now embeds two kinds of clip as base64
  data URIs, so the page stays one portable file: a **bar clip** (the actual
  notes, sliced with the tempo map intact — the passage as played) and a
  **reading clip** per interpretation (that chord voiced plainly). Clicking ▶
  on `Gm7/C` and then on `C11` plays two different chords built from the same
  sounding notes, which is the argument the whole tool exists to have. The chip
  body still pins; only ▶ auditions, so comparing two readings never requires
  committing to either. One player at a time — a second click stops the first.
  Clips are loudness-matched (`loudnorm -18 LUFS`) because a fixed-velocity
  block chord lands ~20 dB under a played bar, and A/B-ing across a level
  difference measures the level. Needs fluidsynth, a soundfont and ffmpeg;
  without them the page builds silently as before. `--no-audio` skips it.
- **Soundfont rendering, and the bar-slicing bug it exposed.** `write_slice`
  kept every meta message regardless of position, so with 637 tempo events in
  the file an 8-bar span rendered as **170 seconds of mostly silence** instead
  of 30. Tempo, time signature and key are now handled as *state* — whatever
  is in force at the start is emitted once at tick 0, changes inside the window
  are kept, everything after the end is dropped. Notes are paired with their
  releases first, so a note lying wholly outside the window is dropped rather
  than leaving a note-on the synth hangs on, and note-offs sort before note-ons
  at the same tick so a repeated pitch retriggers. `--stack` now renders
  through FluidSynth too; it previously fell back to the built-in synth exactly
  when you were comparing.
- **`harm-render`** — renders a bar range to wav, one file per voice-set, so
  the analysis becomes something you can hear and hand to `ab`. Uses FluidSynth
  and a soundfont from the runtime root when present; otherwise a built-in
  detuned-partial synth, so the tool still makes a sound on a machine with
  nothing installed. Walks the tempo map rather than assuming a constant —
  rendering a rubato passage flat would misrepresent the thing being
  auditioned. `doctor` reports the soundfont as optional and never fails on it.
- **`readings()` replaces single-answer chord naming.** A bar now yields every
  defensible interpretation, each declaring which notes it claims as chord
  tones and which it leaves over — because the leftovers are where colour,
  pedals, anticipation and passing motion live. C-D-F-G-B♭ is C11 *and* Gm7
  with C underneath *and* B♭6 with C as an added 9th; the tool lists all three
  rather than letting a bass tie-break decide. `readings_without_voice()` adds
  the lens the bass usually needs: how the bar reads if that line is *not* a
  chord tone. `interpretive_spread()` counts distinct roots among the
  best-explaining readings — a fork worth looking at, and orthogonal to key
  ambiguity.
- **`texts` field type** — a space-separated list of strings, so a tool can
  take `--together F B`. The vocabulary had `ints` and `floats` but no string
  equivalent.

### Changed
- **A tool is now one folder, discovered automatically.** Each package under
  `amtw/tools/` exports `TOOL` (or `TOOLS`); `amtw/registry.py` walks the
  directory and collects them. Adding a tool no longer means editing a central
  catalog or `cli.py` — drop the folder in and it appears on the bench and in
  `--help`.
- **One declaration drives both the form and the CLI.** `amtw/spec.py` turns a
  tool's `fields` into argparse subparsers as well as workbench widgets, so the
  two can no longer disagree. `cli.py` shrank from 488 lines of hand-written
  argparse to 32; only `workbench` is still declared by hand, because it is the
  bench rather than a tool on it.
- **Package split into `core/`, `bench/` and `tools/`.** `core/` holds the
  shared infrastructure (paths, audio IO, job dirs, config, report), `bench/`
  the server and its page, `tools/` one folder per tool. The restore pipeline's
  `stages/` moved under `tools/run/`, where they are used.
- **Extracted `core/dsp.py`.** The STFT/periodicity primitives were living in
  `defizz.py`, so `harmonic`, `detect` and `remod` were importing private
  helpers out of a sibling tool. They are shared vocabulary, not de-fizz's.

### Added
- **`tests/test_roundtrip.py`** — drives every registered tool through
  form-values → argv → argparse, checks required fields raise `ValueError`
  rather than an argparse trace, and checks tool names are unique. Doubles as
  its own runner, so pytest is not a dependency.

### Fixed
- **Starting the workbench twice no longer breaks it.** `allow_reuse_address`
  is on by default, so on Windows a second instance silently bound the same
  port and the two answered unpredictably. It is now off, and a failed bind is
  handled: if a workbench is already there, the browser opens onto it and the
  second instance exits 0; if something else holds the port, you get the reason
  and a suggested `--port`.
- **`Workbench.cmd` no longer starts minimised.** Any startup failure scrolled
  past inside a hidden window, so a double-click that failed looked identical to
  one that did nothing.
- **`detect --marks` now reaches the workbench.** It existed only in the CLI, so
  the bench never offered it — the exact drift the single declaration prevents.
- **`PROJECT_ROOT` no longer depends on a parent count that a file move can
  break.** Moving `paths.py` into `core/` silently repointed it at `amtw/`, and
  every tool the bench launched died with "No module named amtw". Now anchored
  with `parents[2]` and commented.

## [0.3.0] — 2026-07-26

Renamed the project and set it up to be worked on by more than one person.

### Changed
- **Renamed to AG Music Tool Workbench.** Python package `vsr` → `amtw`,
  launcher `vsr.ps1` → `amtw.ps1`. The project is a workbench with tools under
  it, not a single-purpose vocal pipeline.
- The runtime root stays at `%LOCALAPPDATA%\VocalStemRegen` deliberately: four
  venvs have absolute paths baked into their own scripts, so renaming it would
  mean a full re-setup and several GB of re-downloads. `AMTW_RUNTIME` overrides
  it; `VSR_RUNTIME` still works.

### Added
- `AGENTS.md`, `CONTRIBUTING.md`, `docs/adding-a-tool.md`,
  `docs/architecture.md`, and `docs/findings.md` — the last of these collects
  every settled measurement and dead end so they don't get re-run.
- `data/labels/pockets_fry_segments.json` — the 16 ground-truth listening labels
  the fry detector work rests on, committed as a fixture.
- MIT license.

### Deprecated
- `vsr.ps1` still works and forwards to `amtw.ps1` with a warning.

## [0.2.0] — 2026-07-26

The workbench, and the first tool that isn't about audio.

### Added
- **`amtw workbench`** — a local web UI listing every tool with real widgets,
  running them as subprocesses and streaming output back. Results the tool
  produced become clickable chips. Recent runs are re-openable. Last-used values
  persist per tool. Stdlib `http.server`, one HTML file, no build step.
- **`amtw/tools.py`** — declarative tool catalog. Field declarations become
  widgets and then argv; there is no per-tool UI code, so adding a tool to the
  bench is one entry.
- **`Workbench.cmd`** — double-click launcher, the intended entry point.
- **`amtw midi-merge`** — merges duplicate stem-to-MIDI tracks into one track
  with no same-pitch overlaps. Same-pitch notes starting within `--dup` collapse
  (longest tail wins); a later one beyond `--dup` truncates the held note and
  inherits its tail. Handles the illegal key signatures these exports contain,
  and re-times in seconds when two files' tempo maps disagree.
- **`amtw midi-inspect`** — lists a MIDI file's tracks, note counts and ranges.
  The workbench form uses it to show real track choices instead of asking for
  indices.
- `mido` added to the `main` venv.

## [0.1.0] — 2026-07-25

The vocal stem restoration pipeline, as it stood before the rename. Recorded
from git-less history, so this entry is a summary rather than a full log.

### Added
- Staged pipeline: ffmpeg decode → UVR de-reverb cleanup → Apollo spectral
  restoration → seed-vc re-synthesis → loudness match, with a per-job HTML
  report comparing every stage.
- `amtw ab` — lockstep, loudness-matched, optionally blind A/B listening tool.
  Marks and verdicts save as JSON that other tools consume.
- `amtw harmonic` — fry-scrape repair; the first mechanism to pass a listening
  test. `--adaptive` scales strength with severity; `--from-notes` restricts
  processing to user-marked spans and leaves everything else bit-identical.
- `amtw detect` — plots fry-detector features against your marks.
- `amtw defizz`, `amtw remod` — two further fry mechanisms, both still unproven.
- `amtw doctor` — venv, CUDA, clone and checkpoint checks.
- `scripts/setup_runtime.ps1` — rebuilds all four venvs and downloads
  checkpoints; safe to re-run.

[Unreleased]: https://github.com/ArneGleason/ag-music-tool-workbench/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/ArneGleason/ag-music-tool-workbench/releases/tag/v0.3.0
[0.2.0]: https://github.com/ArneGleason/ag-music-tool-workbench/releases/tag/v0.2.0
[0.1.0]: https://github.com/ArneGleason/ag-music-tool-workbench/releases/tag/v0.1.0
