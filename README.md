
# FIAFcore

The FIAFcore ontology was developed to enable the federation of filmographic data from disparate sources. It is heavily based on the language and structures of the [FIAF Cataloguing Manual](https://www.fiafnet.org/pages/e-resources/cataloguing-manual.html).

### Ontology

**Work**

A moving image Work comprises both the intellectual or artistic content and the process of realisation in a cinematographic medium.
| Property | Range | Description |
| --- | --- | --- |
| fiafcore:hasCountry | fiafcore:Country | Where known and applicable, record the geographic origin of the Moving Image Work. This should be the country or countries where the principal offices or production facilities of the production company or companies are located. |
| fiafcore:hasEvent | fiafcore:Event | An Event characterises occurrences in the lifecycle of a Moving Image Work, Variant, Manifestation or Item. |
| fiafcore:hasForm | fiafcore:Form | Form describes the format and/or purpose of a Work. |
| fiafcore:hasGenre | fiafcore:Genre | Genre describes categories of Works, characterized by similar plots, themes, settings, situations, and characters. |
| fiafcore:hasIdentifier | fiafcore:Identifier | An Identifier refers to a specific Work and provides clear disambiguation between Works when there is confusion. |
| fiafcore:hasLanguageUsage | fiafcore:LanguageUsage | Record the usage type of a language (e.g. spoken, intertitles, subtitles, etc). |
| fiafcore:hasManifestation | fiafcore:Manifestation | Express the relationship between a Moving Image Work and a Moving Image Manifestation. |
| fiafcore:hasSubject | fiafcore:Subject | Provide access to the Work by means of subjects (or subject identifiers) that describe the content of the Work. |
| fiafcore:hasTitle | fiafcore:Title | Record at least one title, identifying phrase, or name for the Moving Image Work. |
| fiafcore:hasVariant | fiafcore:Variant | Express the relationship between a Moving Image Work and a Moving Image Variant. |
| fiafcore:hasWork | fiafcore:Work | Express the relationship between a Moving Image Work and another Moving Image Work. |

**Variant**

A moving image Variant is an entity that may be used to indicate any change to content-related characteristics that do not significantly change the overall content of a Work as a whole.
| Property | Range | Description |
| --- | --- | --- |
| fiafcore:hasEvent | fiafcore:Event | An Event characterises occurrences in the lifecycle of a Moving Image Work, Variant, Manifestation or Item. |
| fiafcore:hasIdentifier | fiafcore:Identifier | An Identifier refers to a specific Work and provides clear disambiguation between Works when there is confusion. |
| fiafcore:hasLanguageUsage | fiafcore:LanguageUsage | Record the usage type of a language (e.g. spoken, intertitles, subtitles, etc). |
| fiafcore:hasManifestation | fiafcore:Manifestation | Express the relationship between a Moving Image Work and a Moving Image Manifestation. |
| fiafcore:hasTitle | fiafcore:Title | Record at least one title, identifying phrase, or name for the Moving Image Work. |

**Manifestation**

A moving image Manifestation is the embodiment of a moving image Work/Variant. Manifestations usually include all analogue, digital and online media associated with a particular embodiment of a Work/Variant.
| Property | Range | Description |
| --- | --- | --- |
| fiafcore:hasEvent | fiafcore:Event | An Event characterises occurrences in the lifecycle of a Moving Image Work, Variant, Manifestation or Item. |
| fiafcore:hasIdentifier | fiafcore:Identifier | An Identifier refers to a specific Work and provides clear disambiguation between Works when there is confusion. |
| fiafcore:hasLanguageUsage | fiafcore:LanguageUsage | Record the usage type of a language (e.g. spoken, intertitles, subtitles, etc). |
| fiafcore:hasTitle | fiafcore:Title | Record at least one title, identifying phrase, or name for the Moving Image Work. |

**Item**

A moving image Item is the physical or digital product of a Manifestation of a Work or Variant, i.e. the actual copy of a Work or Variant. Whereas the Manifestation record describes the “ideal” of a particular format or publication, the Item record represents the actual holding in a repository’s collection.
| Property | Range | Description |
| --- | --- | --- |
| fiafcore:hasEvent | fiafcore:Event | An Event characterises occurrences in the lifecycle of a Moving Image Work, Variant, Manifestation or Item. |
| fiafcore:hasIdentifier | fiafcore:Identifier | An Identifier refers to a specific Work and provides clear disambiguation between Works when there is confusion. |
| fiafcore:hasTitle | fiafcore:Title | Record at least one title, identifying phrase, or name for the Moving Image Work. |

**Carrier**

A moving image carrier is the discrete physical unit on which the moving image is retained. It can either contain the entire artistic work or a portion, for example in the case of individual film reels.
| Property | Range | Description |
| --- | --- | --- |
| fiafcore:hasEvent | fiafcore:Event | An Event characterises occurrences in the lifecycle of a Moving Image Work, Variant, Manifestation or Item. |
| fiafcore:hasIdentifier | fiafcore:Identifier | An Identifier refers to a specific Work and provides clear disambiguation between Works when there is confusion. |

**Event**

An Event characterises occurrences in the lifecycle of a moving image Work, Variant, Manifestation or Item. Instances of any Event can have Activity (and Agent) relationships.
| Property | Range | Description |
| --- | --- | --- |

**Activity**

This describes the activity or role of the Agent in relation to the moving image Work/Variant, or to make explicit the relationship(s) between the Agent and the Manifestation or Item.
| Property | Range | Description |
| --- | --- | --- |

**Agent**

Agents, whether for works/variants, manifestations, or items in moving images, are entities involved in their creation, exploitation, or preservation, with typical distinctions including person, corporate body, family, and person group, encompassing responsibilities such as release, distribution, acquisition, or preservation.
| Property | Range | Description |
| --- | --- | --- |

### Resources

Further information and resources can be found at [fiafcore.org](fiafcore.org).

### Licence
The FIAFcore ontology is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.en).
