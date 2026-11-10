# Proposed FIAFcore Sound Taxonomy & Format Boundaries

## 1. Object Properties (domain: `fiaf:SoundCharacteristic`)

- `fiaf:hasSoundStandard` → `fiaf:SoundStandard`
- `fiaf:hasNoiseReduction` → `fiaf:NoiseReduction`
- `fiaf:hasSoundChannelConfiguration` → `fiaf:SoundChannelConfiguration`

Each of these properties targets its own homogeneous tree: every concept in a tree answers the same question. `SoundCharacteristic` itself answers "is the content intended to have recorded sound?" (`Sound`, `Silent`, with `Mute` for a physical element of sound content that carries none of it). `SoundStandard` answers "what sound system is this soundtrack made for, or does it need in order to be reproduced?": analogue sound by how it is fixed (optical, magnetic, disc), digital sound by system. Its hierarchy expresses specificity (an analogue optical system is a kind of analogue optical sound) rather than mixing orthogonal facets. The encoding of a digital audio stream is a separate question, answered by `hasAudioCodec` on an `AudioStream`. Noise reduction is orthogonal to that question and therefore has its own tree. A `SoundCharacteristic` node describes **one soundtrack**; a carrier with several soundtracks (for example a 35mm quad-track print carrying SDDS, Dolby Digital, Dolby Stereo SR and DTS) carries several `SoundCharacteristic` nodes.

---

## 2. Sound Taxonomy (Tree)

```text
fiaf:SoundCharacteristic
├── fiaf:Sound
│   └── fiaf:Mute
└── fiaf:Silent

fiaf:SoundStandard
├── fiaf:AnalogueOpticalSound              renamed from OpticalSoundProcess
│   ├── fiaf:OpticalVariableArea
│   │   ├── fiaf:DolbyStereo
│   │   └── fiaf:UltraStereo
│   └── fiaf:OpticalVariableDensity
├── fiaf:Magnetic                          analogue magnetic
│   ├── fiaf:FourTrackMagnetic
│   └── fiaf:SixTrackMagnetic
├── fiaf:AnalogueDiscSound                 NEW
└── fiaf:DigitalSoundSystem
    ├── fiaf:Datasat
    ├── fiaf:DolbyAtmos
    ├── fiaf:DolbyDigital
    │   └── fiaf:DolbyDigitalSurroundEX
    ├── fiaf:DTS
    └── fiaf:SDDS

fiaf:AudioCodec                            via hasAudioCodec on AudioStream
├── fiaf:PCM
├── fiaf:DolbyDigitalPlus                  moved from DigitalSoundSystem
├── fiaf:DolbyTrueHD                       moved from DigitalSoundSystem
└── fiaf:DTSHD                             moved from DigitalSoundSystem

fiaf:NoiseReduction
└── fiaf:Dolby
    ├── fiaf:DolbyA
    └── fiaf:DolbySR

fiaf:SoundChannelConfiguration
├── fiaf:Mono
├── fiaf:Stereo
└── fiaf:Surround
```

---

## 3. Sound Taxonomy (Nested List)

- `fiaf:SoundCharacteristic` — whether the content is intended to have recorded sound and, where it is, the characteristics of one soundtrack
  - `fiaf:Sound` — the content is intended to have recorded sound (includes silent works presented with added recorded sound)
    - `fiaf:Mute` — a physical element of such content that carries none of that sound (for example a picture negative of a sound film); not used for digital objects
  - `fiaf:Silent` — the content is made or presented without recorded sound, as in silent cinema; live accompaniment is not recorded sound
- `fiaf:SoundStandard` — the sound system a soundtrack is made for or needs in order to be reproduced
  - `fiaf:AnalogueOpticalSound` — analogue sound recorded photographically on film (fallback when the track type is unknown)
    - `fiaf:OpticalVariableArea` — variable-area optical track (for example RCA Photophone, Academy mono VA, SVA)
      - `fiaf:DolbyStereo` — Dolby Stereo (35mm SVA 4-2-4 matrix optical); Dolby Stereo 70mm magnetic prints are `SixTrackMagnetic` with Dolby noise reduction
      - `fiaf:UltraStereo` — Ultra-Stereo (35mm SVA 4-2-4 matrix optical)
    - `fiaf:OpticalVariableDensity` — variable-density optical track (for example Movietone, Western Electric)
  - `fiaf:Magnetic` — analogue magnetic sound on a stripe, separate magnetic film, or magnetic tape (fallback when the track layout is unknown)
    - `fiaf:FourTrackMagnetic` — four-track magnetic (35mm 4-track magnetic standard)
    - `fiaf:SixTrackMagnetic` — six-track magnetic (70mm 6-track magnetic standard)
  - `fiaf:AnalogueDiscSound` — analogue sound in the grooves of a disc, played with a needle and kept in sync with the projector (for example Vitaphone)
  - `fiaf:DigitalSoundSystem` — a digital sound system, whether printed on film, on disc, or in files
    - `fiaf:DolbyDigital` — Dolby Digital (Dolby SRD on 35mm film; AC-3 on digital and disc media)
      - `fiaf:DolbyDigitalSurroundEX` — Dolby Digital Surround EX
    - `fiaf:DolbyAtmos` — Dolby Atmos
    - `fiaf:DTS` — DTS (digital audio on separate discs synchronised by an optical timecode track on film; digital surround on disc)
    - `fiaf:Datasat` — Datasat
    - `fiaf:SDDS` — Sony Dynamic Digital Sound (digital optical edge tracks on 35mm film)
- `fiaf:AudioCodec` — the encoding of a digital audio stream
  - `fiaf:PCM` — uncompressed pulse-code modulation
  - `fiaf:DolbyDigitalPlus` — Dolby Digital Plus (E-AC-3)
  - `fiaf:DolbyTrueHD` — Dolby TrueHD
  - `fiaf:DTSHD` — DTS-HD (High Resolution Audio / Master Audio)
- `fiaf:NoiseReduction` — analogue companding applied on top of a sound process or system
  - `fiaf:Dolby` — Dolby noise reduction of unspecified type
    - `fiaf:DolbyA` — Dolby A
    - `fiaf:DolbySR` — Dolby SR
- `fiaf:SoundChannelConfiguration` — the intended reproduced spatial channel layout (a matrix-encoded track such as Dolby Stereo is described by the layout it reproduces)
  - `fiaf:Mono` — two channels may carry the same mono signal or two independent mono recordings
  - `fiaf:Stereo`
  - `fiaf:Surround`

---

## 4. Relationship & Boundaries with `fiaf:Format` and `fiaf:Element`

### Companion `fiaf:Format` Structure (codecs are separate stream properties)

```text
fiaf:Format                                (via fiaf:hasFormat on Manifestation | Item | Carrier)
├── fiaf:FilmFormat                        8mmFilm, 9.5mmFilm, 16mmFilm, 17.5mmFilm, 28mmFilm, 35mmFilm, 65mmFilm,
│                                          70mmFilm, Super8mmFilm, Super16mmFilm,
│                                          MagneticFilm (16mmMagneticFilm, 35mmMagneticFilm)
├── fiaf:AudioFormat                       AudioTape (Audiocassette, DAT, DTRS, OpenReelAudiotape → HalfInch,
│                                          OneInch, QuarterInch, TwoInch), AudioDisc (CD)
├── fiaf:VideoFormat                       VideoTape (Betacam, Betamax, D1–D6, DV, HDCAM, HDCAMSR, HDV, Umatic, VHS,
│                                          Video8, width fallbacks, …), VideoDisc (BluRay, DVD, LaserDisc,
│                                          ProfessionalDisc, SVCD, VCD, …)
├── fiaf:DataStorageFormat                 CDR, DVDR, CDROM, DVDROM, FlashMemory, HardDrive, LTO2–LTO6, MagnetoOpticalDisc
└── fiaf:DigitalFormat
    ├── fiaf:ContainerFormat               AVI, MKV, MOV, MP4, MXF, Quicktime, VOB, WAV, WebM
    ├── fiaf:ImageFormat                   Cineon, DPX, OpenEXR, TIFF
    └── fiaf:PackageFormat                 DCDM, DCP, IMF

fiaf:VideoCodec                            via hasVideoCodec on VideoStream
fiaf:AudioCodec                            via hasAudioCodec on AudioStream (PCM)
```

### Boundary Rules Across Classes

| Concern | Question answered | Property & Class | Examples |
|---|---|---|---|
| **Carrier / File / Package Format** | What physical medium, digital file format, or package fixes the object? | `fiaf:hasFormat` → `fiaf:Format` | `35mmFilm`, `35mmMagneticFilm`, `BluRay`, `MXF`, `DPX`, `DCP` |
| **Digital Stream Encoding** | How is an individual video/audio stream encoded? | `fiaf:hasVideoCodec` / `fiaf:hasAudioCodec` on streams linked by `fiaf:hasStream` | `FFV1`, `ProRes`, `PCM` |
| **Element Role** | What is the item's function in the production/preservation workflow (including combined print vs. separate sound follower)? | `fiaf:isElement` → `fiaf:Element` | `ReleasePrint`, `SoundNegative`, `SoundPositive`, `SeparatedMagneticSound` (sepmag) |
| **Intended Sound** | Is the content intended to have recorded sound, and does this physical element carry it? | `fiaf:hasSoundCharacteristic` → `fiaf:SoundCharacteristic` | `Sound`, `Silent`, `Mute` |
| **Sound System** | What analogue fixation process or digital sound system is the soundtrack made for? | `fiaf:hasSoundStandard` → `fiaf:SoundStandard` | `OpticalVariableArea`, `DolbyStereo`, `Magnetic`, `FourTrackMagnetic`, `AnalogueDiscSound`, `DolbyDigital`, `DolbyAtmos`, `SDDS` |
| **Digital Audio Encoding** | How is a digital audio stream encoded? | `fiaf:hasAudioCodec` on an `AudioStream` → `fiaf:AudioCodec` | `PCM`, `DolbyDigitalPlus`, `DolbyTrueHD`, `DTSHD` |
| **Noise Reduction** | What analogue companding noise reduction is applied? | `fiaf:hasNoiseReduction` → `fiaf:NoiseReduction` | `Dolby`, `DolbyA`, `DolbySR` |
| **Sound Channel Layout** | What spatial channel configuration is the soundtrack intended to reproduce? | `fiaf:hasSoundChannelConfiguration` → `fiaf:SoundChannelConfiguration` | `Mono`, `Stereo`, `Surround` |
| **Colour / Pixel Encoding** | What photochemical colour process or digital colour representation is used? | `fiaf:hasColourProcess` → `fiaf:ColourStandard` / `fiaf:hasColourEncoding` → `fiaf:ColourEncoding` | `Eastmancolor`, `Technicolor`, `RGB`, `YUV` |

### Key Disambiguations

1. **File formats, stream codecs, and sound systems:**
   - File containers (`MXF`, `MOV`, `MP4`, `WAV`) and image formats (`DPX`, `TIFF`, `OpenEXR`, `Cineon`) remain under `DigitalFormat` via `hasFormat`. Codecs are independent trees: `hasVideoCodec` on VideoStream and `hasAudioCodec` on AudioStream. Item and Carrier can both use `hasStream`; no Carrier record is required. The AudioStream's `hasSoundCharacteristic` groups sound-system, noise-reduction, and channel-layout information. Ordinary film description is unchanged. See `FORMAT_TAXONOMY.md` for rationale and the unresolved Carrier/storage relationships.
   - Digital sound systems (`DolbyDigital`, `DolbyAtmos`, `DTS`, `Datasat`, `SDDS`) live under `fiaf:DigitalSoundSystem` (`fiaf:hasSoundStandard`). Bitstream encodings used in files and on discs (`DolbyDigitalPlus`, `DolbyTrueHD`, `DTSHD`, `PCM`) are audio codecs (`fiaf:hasAudioCodec` on an `AudioStream`). An AC-3 codec term is added when source data needs one.
2. **Separate Magnetic Sound Follower (`Sepmag`) vs. Combined Magnetic Print (`Commag`):**
   - "Combined" vs. "Separate" is not a magnetic sound process. A separate magnetic sound follower has `fiaf:isElement fiaf:SeparatedMagneticSound` (under `fiaf:FilmElement` → `fiaf:FilmSoundElement`), `fiaf:hasFormat fiaf:35mmMagneticFilm` (or `16mmMagneticFilm`, both under `fiaf:FilmFormat` → `fiaf:MagneticFilm`), and `fiaf:hasSoundStandard fiaf:Magnetic` (or `FourTrackMagnetic` / `SixTrackMagnetic`) plus `fiaf:hasNoiseReduction fiaf:DolbyA` / `fiaf:DolbySR` where known.
   - A striped release print has `fiaf:isElement fiaf:ReleasePrint`, `fiaf:hasFormat fiaf:35mmFilm` (or `70mmFilm`), and `fiaf:hasSoundStandard fiaf:FourTrackMagnetic` / `fiaf:SixTrackMagnetic`.
3. **`fiaf:VideoDisc` (under `fiaf:VideoFormat`) vs. `fiaf:AnalogueOpticalSound` (under `fiaf:SoundStandard`):**
   - `fiaf:VideoDisc` covers video discs played on a video disc player or deck (`DVD`, `BluRay`, `LaserDisc`, `ProfessionalDisc`, `VCD`, `SVCD`), whatever the reading method; it is not defined by optical reading. `fiaf:CD` sits under `fiaf:AudioFormat` → `fiaf:AudioDisc`, while data discs used to store files (`fiaf:CDR`, `fiaf:DVDR`, `fiaf:CDROM`, `fiaf:DVDROM`) sit under `fiaf:DataStorageFormat`.
   - `fiaf:AnalogueOpticalSound` refers to photographic analogue sound-on-film tracks (`OpticalVariableArea`, `OpticalVariableDensity`, `DolbyStereo`, `UltraStereo`).
4. **One `SoundCharacteristic` node per soundtrack:**
   - Each soundtrack on a carrier gets its own `fiaf:SoundCharacteristic` blank node. A 35mm quad-track print therefore carries four nodes: one for the SDDS track, one for the Dolby Digital (SRD) track, one for the analogue variable-area track with Dolby Stereo / Dolby SR, and one for the DTS timecode track.
   - This keeps every property on a node single-valued in normal catalogue data and prevents a noise-reduction value from being attached to the wrong soundtrack.
5. **`DTS` and `SDDS` are digital systems, not optical processes:**
   - `fiaf:SDDS`, `fiaf:DolbyDigital` and `fiaf:DTS` are all peers under `fiaf:DigitalSoundSystem`, whether the digital data is carried optically on film, on disc, or in a file.
   - The BFI values `'DTS (sound)'` and `'DTS Sound (Optical)'` both map to `fiaf:DTS`; the carrier format already states whether the item is film or disc. A separate analogue optical backup track is modelled as its own `SoundCharacteristic` node (for example `fiaf:OpticalVariableArea`).
   - `fiaf:DolbyStereo` and `fiaf:UltraStereo` remain under `fiaf:OpticalVariableArea`, because they are always analogue variable-area optical processes.

---

## 5. Design Rationale

### 5.1 One homogeneous tree per question

The governing rule is that a taxonomy tree should answer exactly one question, so that a second value from the same tree has a predictable meaning. Sound uses three such trees:

| Property | Tree | The one question it answers |
|---|---|---|
| `fiaf:hasSoundCharacteristic` (node type) | `fiaf:SoundCharacteristic` | Is the content intended to have recorded sound (and does this physical element carry it)? |
| `fiaf:hasSoundStandard` | `fiaf:SoundStandard` | What sound system is this soundtrack made for, or does it need in order to be reproduced? |
| `fiaf:hasNoiseReduction` | `fiaf:NoiseReduction` | What analogue companding is applied to this soundtrack? |
| `fiaf:hasSoundChannelConfiguration` | `fiaf:SoundChannelConfiguration` | What spatial channel layout is the soundtrack intended to reproduce? |
| `fiaf:hasAudioCodec` (on `AudioStream`) | `fiaf:AudioCodec` | How is this digital audio stream encoded? |

`SoundStandard` is homogeneous in the sense that every value describes the sound system the soundtrack is made for: analogue sound by how it is fixed (optical, magnetic, disc), digital sound by system. Its hierarchy expresses **specificity**, not orthogonality: `DolbyStereo` is a kind of `OpticalVariableArea`, which is a kind of `AnalogueOpticalSound`. Two unrelated values from that tree on one node therefore mean "two soundtracks", not "two facets of one track"; a more specific value and its ancestor (for example `DolbyStereo` and `OpticalVariableArea`) are merely redundant, not a second track.

### 5.2 Why `NoiseReduction` was split out, but `SoundProcess` / `SoundSystem` were not

Noise reduction is genuinely orthogonal to the fixation/encoding question:

- The same `OpticalVariableArea` or `Magnetic` track can carry Dolby A or Dolby SR, or no noise reduction at all.
- A 35mm Dolby Stereo SR print has both an analogue variable-area track and an SR companding system; those are two statements of different kinds, not two competing processes.
- Stating `hasSoundStandard fiaf:DolbyStereo, fiaf:DolbySR` therefore read as if two sound standards were present. Splitting `NoiseReduction` makes the shape say what it means.

By contrast, a full split into `SoundProcess` (fixation) and `SoundSystem` (playback/encoding) was **not** adopted:

- For analogue sound, the system *is* a specialisation of the fixation process. `DolbyStereo` is always a bilateral variable-area optical track; `FourTrackMagnetic` is always magnetic. Keeping that subsumption preserves useful inference: an archive that records only `Dolby Stereo` still resolves to `OpticalVariableArea` / `AnalogueOpticalSound` without having to state the physical process separately.
- Splitting them would force every `DolbyStereo` record to either duplicate `OpticalVariableArea` or lose the inference that it is an optical track.
- Digital systems do not map cleanly onto a "fixation vs. playback" split either. `DolbyDigital`, `DTS` and `SDDS` are all digital systems, but each can be carried optically on film, on disc, or in a file. Their physical carrier is already stated by `hasFormat` (`35mmFilm`, `DVD`, `MKV`, …), so a separate `hasSoundProcess` would either duplicate that or introduce a second, ambiguous carrier statement.
- Keeping `SoundStandard` also preserves the existing property and all class IRIs, so current `hasSoundStandard` consumers keep working; only the orthogonal noise-reduction branch moved.

The accepted trade-off is that `DolbyStereo` and `SDDS` sit in different branches of the same tree even though both can be printed optically on 35mm film. That is intentional: `DolbyStereo` is an analogue optical process, while `SDDS` is a digital system whose data happens to be printed optically.

### 5.3 Why `SDDS` moved under `DigitalSoundSystem`

`SDDS` was previously under `OpticalSoundProcess` (now `AnalogueOpticalSound`), while its digital peers `DolbyDigital` and `DTS` were under `DigitalSoundSystem`. That split was based on the carrier (optical printing) rather than on the kind of system, with two bad consequences:

- A query for `DigitalSoundSystem` missed one of the three major 1990s digital cinema systems.
- A 35mm print with SDDS and a 35mm print with Dolby Digital were described with values from different branches even though both are digital systems carried on the same kind of carrier.

`SDDS` is now a peer of `DolbyDigital` and `DTS` under `DigitalSoundSystem`. The fact that SDDS data is printed on the film edge is a carrier detail, not an analogue optical sound process. The same reasoning applies to Dolby Digital SRD between the perforations and to DTS's optical timecode track.

### 5.4 Why one `SoundCharacteristic` node per soundtrack

The grouping node is what binds a sound standard, its noise reduction, and its channel layout to **one specific track**. This matters because multi-soundtrack carriers are normal:

- A 1990s 35mm quad-track print carries SDDS, Dolby Digital, a Dolby Stereo SR analogue variable-area track, and a DTS timecode track.
- If all values sat on one node, `DolbySR` and `Stereo` could not be tied to the analogue track rather than to SDDS or DTS, and consumers would see an undifferentiated set of standards.
- With one node per soundtrack, each property is normally single-valued inside its node. The node count describes the number of soundtracks, not the number of independent sound statements.

This is the same pattern as `ColourCharacteristic`: the blank node is the grouping device, and each property on it points to a separate homogeneous tree. `hasSoundCharacteristic` remains the only property needed on `Manifestation`/`Item`.

### 5.5 Why `DolbyA` and `DolbySR` are subclasses of `Dolby`

`Dolby` is the useful unspecified level: an archive may know that a track has Dolby noise reduction without knowing whether it is A-type or SR. Making `DolbyA` and `DolbySR` subclasses of `Dolby` means:

- `hasNoiseReduction fiaf:Dolby` states "Dolby, specific type unknown".
- `hasNoiseReduction fiaf:DolbyA` or `fiaf:DolbySR` states the specific system.
- A query for `Dolby` (with `rdfs:subClassOf*`) finds all three, while a query for `DolbySR` stays precise.

This mirrors how `AnalogueOpticalSound` and `Magnetic` provide unspecified levels in `SoundStandard`.

### 5.6 Consequences for mappings

- An archive value that names only a noise-reduction system (`'Dolby'`, `'Dolby SR'`, `'Dolby A'`) maps to `hasNoiseReduction`, not `hasSoundStandard`.
- An archive value that names a combined system (`'Dolby Stereo SR'`) maps to `hasSoundStandard fiaf:DolbyStereo` plus `hasNoiseReduction fiaf:DolbySR`.
- An archive value that combines a digital system with an analogue backup (`'Dolby SRD, Variable area'`, `'DTS, Variable area'`) produces two `SoundCharacteristic` nodes, one for each soundtrack.
- An archive value that names only an analogue fixation process (`'Variable Area'`, `'Magnetic'`) maps to the appropriate `SoundStandard` value; no noise-reduction statement is invented.
- `Mono` and `Stereo` are channel configurations, not sound standards, and map to `hasSoundChannelConfiguration`.

### 5.7 Why `Mute` is a kind of `Sound` (Phase 1, decision 1.1)

`Sound`, `Silent`, and `Mute` previously mixed three questions: whether recorded sound is present on the object, whether the production was made without sound, and how the film image is laid out. `SoundCharacteristic` now answers one question at Manifestation level — **is the content intended to have recorded sound?** — and its Items inherit the answer:

- `Silent` is used almost exclusively for silent cinema: content made or presented without recorded sound. A sonorized re-release of a silent film is `Sound`.
- `Mute` is an Item state: a **physical element** whose content is meant to have sound but which carries none of it, such as a picture negative of a sound film or a print with a blank soundtrack area. It is therefore a kind of `Sound`, not a sibling of it.
- Digital objects without audio are not described as `Mute`; nothing is recorded, and the absence of an `AudioStream` shows that no sound is carried.
- Image layout (a masked soundtrack area, a full silent aperture) is not a sound characteristic. It belongs with projection characteristics, which are reviewed with technical measurements. Bundesarchiv `Stumm… mit Tonkasch` values (silent films printed on sound stock, with a masked soundtrack area) are `Silent`.

### 5.8 Why `AnalogueOpticalSound`, `AnalogueDiscSound`, and the codec boundary (decisions 1.2–1.3)

- Not all optical sound is analogue: Dolby Digital (SRD) and SDDS are printed optically, and DTS uses an optical timecode track. "Analogue" in the branch names keeps visible that the top level of `SoundStandard` sorts analogue sound by fixation (optical, magnetic, disc) and digital sound by system. Digital systems are not split by fixation, because the same system appears on several carriers; the carrier is given by Format.
- `AnalogueDiscSound` covers grooved discs played with a needle (Vitaphone). It is not named "disc sound", because DTS is also sound on separate discs; DTS is a digital sound system.
- `SoundStandard` describes the system a soundtrack is made for or needs; `AudioCodec` describes how a digital audio stream is encoded. `DolbyDigitalPlus`, `DolbyTrueHD`, and `DTSHD` are bitstream encodings, so they moved to `AudioCodec`. `DolbyDigital` and `DTS` remain systems, because they are used on film.

### 5.9 Why channel configuration records the reproduced layout (decision 1.4)

`hasSoundChannelConfiguration` records the configuration the soundtrack is intended to reproduce, consistent with Format's playback logic. A Dolby Stereo optical track records four channels (left, centre, right, surround) matrixed into two optical tracks, and is therefore `Surround`. Two recorded channels may carry stereo or two independent mono recordings; channel count alone does not establish the configuration.

### 5.10 What this model deliberately does not do

- It does not add `SoundProcess` / `SoundSystem` properties; `SoundStandard` remains the single fixation/encoding property.
- It does not enforce cardinality with OWL. A `SoundCharacteristic` node could still carry two `hasSoundStandard` values; the convention is one value per property per soundtrack. Genuine incompatibilities (`OpticalVariableArea` vs. `OpticalVariableDensity`, `Mono` vs. `Stereo` vs. `Surround`) are candidates for later `owl:AllDisjointClasses` or SHACL constraints rather than a blanket `maxCardinality 1`.
- It does not model the DTS CD-ROM or SDDS data track as separate physical carriers; those remain part of the soundtrack/system description. Carrier-level modelling belongs with `fiaf:Carrier` / `fiaf:Item` part relationships.
