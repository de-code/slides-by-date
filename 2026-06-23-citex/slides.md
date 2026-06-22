---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# CiteX 2026:<br>notes from the workshop

Daniel Ecer &nbsp;·&nbsp; 23 June 2026

---

# What is CiteX?

![bg right:45% contain](images/2026-06-22-dipf-cartoon-based-on-photo-generic-van.png)

**Citation extraction:** pulling references out of documents, structuring them, and linking them to the papers they point to.

**28-29 May 2026, Frankfurt am Main.** Researchers, developers, and practitioners from bibliometrics, NLP, and open infrastructure.

<p class="note"><a href="https://sites.google.com/view/workshop-on-citation-extractio">sites.google.com/view/workshop-on-citation-extractio</a> &nbsp;·&nbsp; <a href="https://doi.org/10.5281/zenodo.20382199">doi.org/10.5281/zenodo.20382199</a></p>

<!-- The full name is "Workshop on Citation Extraction and Parsing". Funded by the German Research Foundation. -->

---

# Citation data is becoming open

Most citation data was proprietary until around 2017.

- **2017:** around 1% of citation data was openly available
- **June 2022:** Crossref committed to treating all deposited references as CC0

The **[Barcelona Declaration on Open Research Information](https://barcelona-declaration.org/)** calls on institutions to treat research information as a public good. Supporters include OpenCitations, Crossref, OpenAlex, and eLife.

<!-- Bianca Kramer keynote. Caveats on the Crossref figure: not all papers have reference lists deposited (~50% of journal articles); OJS journal coverage is low. AI licensing is creating new pressure — publishers are restricting database access for AI training, and open databases are affected. -->

---

# Most tools were built for one kind of document

GROBID and similar tools were trained primarily on English-language journal articles in standard formats: structured, with a reference list at the end.

Many documents do not look like that:

- **SSH, law, humanities:** citations in footnotes, not reference lists; multilingual
- **Grey literature:** patents, trade publications, government reports
- **Older or scanned texts:** inconsistent layouts, character encoding issues

<!-- Off-the-shelf GROBID performance drops significantly on these formats. Paul Donner's "bibliometric hinterlands" talk: F1 on segmentation reached only ~50 with 80 domain-specific training documents; half the corpus had no reference list at all. Harald Hammarström's talk on linguistic literature: fell back to regular expressions after GROBID underperformed. -->

---

# Several new datasets

Several talks presented new datasets.

| Dataset | What it covers |
|---|---|
| **[FOSSIL](https://doi.org/10.48550/arXiv.2606.01109)** | Footnote-based SSH and humanities references, multilingual |
| **[RenoBench](https://huggingface.co/datasets/cometadata/renobench-clean)** | ~160k citation pairs from PKP, SciELO, Redalyc, and ORE |
| **[OpenSSCI](https://zenodo.org/records/18172742)** | 63k social sciences full texts from SSOAR |

<!-- Christian Boulanger (FOSSIL), Parth Sarin (RenoBench), Philipp Mayr (OpenSSCI) -->

---

# GROBID and LLMs

**GROBID:** best on its training domain; still the standard starting point.

**LLMs** (DeepSeek V3.1, Mistral Small 3.2 24B): consistently better on SSH and multilingual text.

One proposed direction: **route by document type**
- GROBID for STEM journal articles in English
- LLM for SSH, multilingual, and grey literature

One talk showed a staged pipeline for scanned references: preprocessing, OCR, then LLM-structured extraction. Error rate went from 22% to 1%.

<!-- GRAPHIA talk: GROBID leads on CEX data (its training distribution); DeepSeek V3 and Mistral Small 3.2 24B better on EXCITE and LinkedBooks. LoRA fine-tuning improved performance on SSH by up to 21%. Anele Schmidt talk: teacher-student strategy; Qwen 2.5 72B as teacher, 4B as student. -->

---

# Linking is still the hard part

> "Linking is the real challenge."

<p class="note">Philipp Mayr, GESIS</p>

Matching a reference string to an actual paper runs into:

- No DOI for large parts of SSH and humanities literature
- Book chapters under-indexed in major databases
- Publications without persistent identifiers

**OpenSSCI:** 63k full-text documents from SSOAR, being contributed to OpenCitations.

<!-- Philipp Mayr's talk. GESIS uses DOI where available; generates its own persistent ID otherwise (required for OpenCitations). The GRAPHIA talk also noted there is no existing benchmark dataset for citation linking in SSH. -->

---

<!-- _class: dark -->

# Summary

- Open citation data is expanding; the Barcelona Declaration marks a shift in what institutions are expected to make open
- Hybrid approaches are being tested: GROBID for STEM, LLMs for SSH and multilingual text
- Linking extracted references to papers remains the main unsolved problem
- Several new open datasets were released, particularly for SSH and humanities
