# FIAFcore Element Taxonomy & Format/Status Boundaries

Branch: `unified-taxonomy`. This document replaces the earlier
`element-tree.txt`.

## 1. Object Property (domain: `fiaf:Item`)

- `fiaf:isElement` → `fiaf:Element`

Element answers one question: **what was this object made for** in the production,
duplication, preservation, or access workflow in which it was made? For film,
photochemical polarity is part of that answer. Element is fixed when the object is
made; an institution's later use or designation of it does not change its Element.

- The institution's **current designation** (preservation, access, and so on) is
  recorded with `fiaf:hasStatus`, not with Element. A release print retained for
  preservation remains a `ReleasePrint` with `hasStatus fiaf:Preservation`.
- **Storage media have no Element.** An LTO tape or hard drive has no intended
  function as content; the digital objects stored on it do. Where only a storage
  medium is catalogued and its contents are unknown, no Element is recorded, and
  none is guessed from the medium.
- Do not infer Element solely from format, technical quality, storage location,
  or current use. Where the specific function is unknown, use a fallback term.

---

## 2. Element Taxonomy (Tree)

```text
fiaf:Element
├── fiaf:FilmElement
│   ├── fiaf:Negative                          fallback: picture negative, generation or function unknown
│   │   ├── fiaf:OriginalNegative              fallback: camera negative, cut or uncut
│   │   │   └── fiaf:OriginalCutNegative
│   │   ├── fiaf:DuplicateNegative
│   │   │   └── fiaf:ColourReversalIntermediate
│   │   ├── fiaf:FilmOutNegative
│   │   └── fiaf:ColourSeparationNegative      generation-neutral
│   ├── fiaf:Positive                          fallback: picture positive, generation or function unknown
│   │   ├── fiaf:AnswerPrint
│   │   ├── fiaf:WorkPrint
│   │   ├── fiaf:ReleasePrint
│   │   ├── fiaf:DuplicatePositive
│   │   ├── fiaf:ColourSeparationPositive      generation-neutral
│   │   ├── fiaf:DyeTransferMatrix
│   │   └── fiaf:ReversalPositive              fallback: reversal positive, generation unknown
│   │       └── fiaf:OriginalReversalPositive
│   └── fiaf:FilmSoundElement
│       ├── fiaf:SoundNegative
│       ├── fiaf:SoundPositive
│       └── fiaf:SeparatedMagneticSound        sepmag
├── fiaf:AudioElement
│   ├── fiaf:OriginalSoundRecording
│   └── fiaf:AudioMaster
├── fiaf:VideoElement
│   ├── fiaf:OriginalVideoRecording
│   ├── fiaf:VideoMaster
│   ├── fiaf:VideoAccessCopy
│   └── fiaf:HomeVideoRelease
└── fiaf:DigitalElement
    ├── fiaf:OriginalDigitalRecording
    ├── fiaf:DigitalMaster
    ├── fiaf:DigitalMezzanine
    ├── fiaf:DigitalAccessCopy
    └── fiaf:DigitalRelease
```

---

## 3. Element Taxonomy (Nested List)

- `fiaf:Element` — the intended function of an Item in the workflow in which it was made, including photochemical polarity where it forms part of that role
  - `fiaf:FilmElement` — an Element on motion-picture film, picture or sound, photochemical or magnetic
    - `fiaf:Negative` — a negative picture film Element; use when its generation or function is unknown
      - `fiaf:OriginalNegative` — the negative exposed in the camera during production, cut or uncut
        - `fiaf:OriginalCutNegative` — the original camera negative cut and assembled to match the final edit, including A/B rolls, from which printing proceeds
      - `fiaf:DuplicateNegative` — a negative made from film as an intermediate for further printing, such as an internegative
        - `fiaf:ColourReversalIntermediate` — a duplicate negative produced directly from a negative by reversal processing
      - `fiaf:FilmOutNegative` — a negative recorded from digital image data with a film recorder, made for printing (alternative labels: "Recorded Negative", "Digital Negative")
      - `fiaf:ColourSeparationNegative` — a black-and-white negative recording a single colour channel, whatever its generation
    - `fiaf:Positive` — a positive picture film Element; use when its generation or function is unknown
      - `fiaf:AnswerPrint` — a trial print for approving grading, timing, and synchronisation before release printing
      - `fiaf:WorkPrint` — a print used for editing and assembly work, not for release
      - `fiaf:ReleasePrint` — a print made for exhibition, distribution, or viewing access
      - `fiaf:DuplicatePositive` — a positive made as an intermediate for making duplicate negatives, such as an interpositive or fine-grain master; not made for projection
      - `fiaf:ColourSeparationPositive` — a black-and-white positive (such as a separation or protection master) recording a single colour channel, whatever its generation
      - `fiaf:DyeTransferMatrix` — a gelatin-relief film recording a single colour channel, used in dye-transfer printing
      - `fiaf:ReversalPositive` — a positive produced by reversal processing; use when its generation is unknown
        - `fiaf:OriginalReversalPositive` — reversal film exposed in the camera during production
    - `fiaf:FilmSoundElement` — a sound-only Element on film, optical or magnetic
      - `fiaf:SoundNegative` — an optical sound negative carrying sound separately from the image
      - `fiaf:SoundPositive` — an optical sound positive carrying sound separately from the image
      - `fiaf:SeparatedMagneticSound` — sound on perforated magnetic film, fullcoat or stripe, kept in sync with the image by its perforations (sepmag)
  - `fiaf:AudioElement` — an Element of a sound-only physical carrier other than film
    - `fiaf:OriginalSoundRecording` — a physical sound recording made in production, as captured and before editing or mixing
    - `fiaf:AudioMaster` — a physical sound recording made as the complete source for further copies, whether a production's finished mix or a master copy made in duplication or preservation
  - `fiaf:VideoElement` — an Element of a physical video carrier
    - `fiaf:OriginalVideoRecording` — a physical video recording made in production, as captured and before editing or mastering
    - `fiaf:VideoMaster` — a physical video recording made as the complete source for further copies
    - `fiaf:VideoAccessCopy` — a physical video copy made for viewing or reference
    - `fiaf:HomeVideoRelease` — a commercially released physical home video copy, such as a VHS, DVD, or Blu-ray release
  - `fiaf:DigitalElement` — an Element of a digital object (one file or several related files), including digital audio recordings
    - `fiaf:OriginalDigitalRecording` — digital material made in production, as captured or created and before editing or mastering, such as camera-original files or rendered frames
    - `fiaf:DigitalMaster` — a digital object made as the complete source for further copies
    - `fiaf:DigitalMezzanine` — a digital object made as an intermediate source for producing distribution or access copies, normally derived from a master
    - `fiaf:DigitalAccessCopy` — a digital copy made for viewing or reference
    - `fiaf:DigitalRelease` — a digital object made for exhibition or public distribution, such as a DCP or a distributor's delivery file

---

## 4. Relationship & Boundaries with `fiaf:Format` and `fiaf:Status`

### Element branches follow Format branches

| Element branch | Format branch | Scope |
|---|---|---|
| `FilmElement` | `FilmFormat` | Anything on film, picture or sound, photochemical or magnetic |
| `AudioElement` | `AudioFormat` | Sound-only physical carriers other than film |
| `VideoElement` | `VideoFormat` | Physical video tape and disc |
| `DigitalElement` | `DigitalFormat` | Digital objects, including digital audio recordings |
| — | `DataStorageFormat` | Storage media have no Element |

Film, Audio, and Video are physical; Digital covers digital objects. A digital
final mix is a `DigitalMaster`; its formats and streams show that it is
sound-only.

### Boundary Rules Across Classes

| Concern | Question answered | Property & Class | Examples |
|---|---|---|---|
| **Element** | What was the object made for? | `fiaf:isElement` → `fiaf:Element` | `OriginalNegative`, `ReleasePrint`, `SeparatedMagneticSound`, `DigitalRelease` |
| **Status** | How does the institution currently designate it? | `fiaf:hasStatus` → `fiaf:Status` | `Preservation`, `Access` |
| **Format** | What is needed to read, decode, or play it back? | `fiaf:hasFormat` → `fiaf:Format` | `35mmFilm`, `35mmMagneticFilm`, `VHS`, `DCP` |
| **Sound** | Is sound present, and how is it fixed? | `fiaf:hasSoundCharacteristic` → `fiaf:SoundCharacteristic` | `Sound` + `OpticalVariableArea` |
| **Colour** | What does the image look like, and how is colour produced or encoded? | `fiaf:hasColourCharacteristic` → `fiaf:ColourCharacteristic` | `BlackAndWhite`, `hasColourProcess fiaf:Technicolor` |

### Key Disambiguations

1. **Element vs. Status:**
   - A theatrical DCP has `isElement fiaf:DigitalRelease` (made for exhibition)
     even when the archive uses it for access (`hasStatus fiaf:Access`).
   - A digital master and a production's finished master share one term per
     branch (`DigitalMaster`, `VideoMaster`, `AudioMaster`). Manifestation type and
     preservation or manufacture Events record which workflow produced the object.
2. **Picture chain vs. film sound:**
   - `Negative` and `Positive` are the picture generational chain. Sound on film
     sits under `FilmSoundElement`, so generic polarity values (such as
     Bundesarchiv `Bildnegativ`) keep a clean meaning.
   - A query for all negatives including sound names `SoundNegative` as well as
     `Negative`; a query for all sound-only film elements uses `FilmSoundElement`.
3. **Duplicates vs. release prints:**
   - `DuplicateNegative` and `DuplicatePositive` are defined by their
     intermediate function, not their generation. A release print is also a
     duplicate by generation, but it is made for exhibition, so it is a
     `ReleasePrint`.
4. **Originals:**
   - "Original" means material made in production (camera exposure, production
     recording, digital capture or rendering). It does not mean material
     acquired from outside the archive or the oldest surviving copy. Provenance
     is recorded through acquisition and preservation Events.
   - A film-out negative is not an `OriginalNegative` (not exposed in a camera)
     and not a `DuplicateNegative` (not made from film): it is a
     `FilmOutNegative`.
5. **Colour separations:**
   - `ColourSeparationNegative` and `ColourSeparationPositive` are
     generation-neutral by design: a three-strip camera negative is an original,
     while a separation protection master is a duplicate. They are an accepted
     exception to the generation axis.
6. **Separate sound follower vs. combined print:**
   - A sepmag has `isElement fiaf:SeparatedMagneticSound`, `hasFormat
     fiaf:35mmMagneticFilm` (under `MagneticFilm`), and `hasSoundStandard
     fiaf:Magnetic`. A mag-striped or optical combined print is a picture element
     (such as `ReleasePrint`) on `35mmFilm` with its sound described by
     `SoundCharacteristic`.
   - The film branch has no master term: "master" is a different axis from
     polarity, and asserting it would prevent stating that a sound element is a
     negative or a positive.

---

## 5. Design Rationale

### 5.1 Polarity is part of film function

In photochemical duplication, polarity is function: camera originals are negative
(except reversal originals), protection masters are positive, printing masters
are negative, and editorial, grading, and exhibition prints are positive. An
interpositive and an internegative share the same function and differ only in
polarity, so polarity cannot be factored out of `FilmElement` (§2.7). `FilmFormat`
records the medium, never the polarity.

### 5.2 Why sound on film is a `FilmElement`

Optical and magnetic sound elements belong to the same film production chain: an
optical sound negative may be struck from a mag, and sound followers are made and
used in film production. Placing them under `AudioElement` mixed a technology
axis (film, video, digital) with a content axis (sound-only). Grouping them under
`FilmSoundElement` gives each element one parent and keeps the picture chain
clean.

### 5.3 Why `AudioElement` is physical and digital audio is digital

Element follows Format: `AudioElement` covers physical sound carriers other than
film (tape, discs), and digital audio recordings are `DigitalElement`. This keeps
the physical branches (Film, Audio, Video) separate from Digital and avoids two
correct answers for a WAV file.

### 5.4 Why names keep their qualifiers

Names must be true of every intended member, wherever the term sits. "Original"
alone is ambiguous in archives, so terms keep a qualifier (`OriginalNegative`,
`OriginalVideoRecording`, `OriginalDigitalRecording`). Medium prefixes
(`VideoAccessCopy`, `DigitalAccessCopy`) are true of their members and are kept.
`HomeViewingCopy` was renamed `HomeVideoRelease` before release, because its name
did not state that it covers commercial physical home video releases.

### 5.5 Consequences for mappings (Phase 2, pending)

- BFI `Original Reversal …` values map to `OriginalReversalPositive`; plain
  `Reversal …` values to `ReversalPositive`. The same applies to Bundesarchiv
  `Original_Reversal_Positive`.
- BFI `Master Magnetic Recording` maps to `SeparatedMagneticSound`; its "master"
  information is not carried until a separate attribute is decided.
- NB `A-/B-rull negativ` maps to `OriginalCutNegative`; `Kameranegativ` stays
  `OriginalNegative`; `Bildenegativ` and `Negativ` map to `Negative`;
  `Digitalt negativ (fra filmrecorder)` maps to `FilmOutNegative`; the NB
  status value `Mezzanin` maps to `DigitalMaster` (NB uses "mezzanine" for
  master objects), with `hasStatus fiaf:Preservation`.
- BFI `Master Yellow Separation`, `Master Magenta Separation`, and `Master Magenta`
  map to `ColourSeparationPositive`.

### 5.6 What this model deliberately does not do (deferred)

- **No master term in the film branch**, and no attribute for the function of a
  sound follower (final mix, print master, dialogue or music-and-effects mix).
  Deferred.
- **No note property** on Items.
- **No generation terms for film sound** (such as a duplicate sound negative)
  until a source confirms the need; BFI `Re-recorded Internegative` remains
  `SoundNegative`.
- **No screener terms** until they appear in source data.
- **No fullcoat or stripe terms** on Format until source data needs them.
- **No Element as `rdf:type` subclasses of `Item`** (§4.7, deferred).
- Carried over from the earlier `element-tree.txt` and not yet reviewed: a
  source-link property (such as `isDerivedFrom`) for scans and transfers; further
  audio terms (audio mixes, audio access copy); and lavender prints (currently
  `DuplicatePositive`).
