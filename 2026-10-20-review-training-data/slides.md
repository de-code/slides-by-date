---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# Generated GROBID training data:<br>reviewing it on the page it came from

Daniel Ecer &nbsp;·&nbsp; 20 October 2026

<!--
Lightning talk: 7 minutes + 3 minutes Q&A.

Why: We generate our GROBID training data from PDF and JATS pairs rather than annotating it by
hand, which produces a corpus too large to check as files. This is how we made it reviewable,
and anyone generating data with a machine will hit the same problem.

The body is this corpus and these three models, each finer than the last and each needing more
of the page to be reviewable. Keep the general claim for the last slide: everything before it
is what we actually did here, and the takeaway says only that reading was worth the time, not
that generating your data always turns the work into review.
-->

---

# Nobody annotated this corpus

<div class="flow-labeled">
  <div class="flow-col">
    <div class="flow-box">PDF</div>
    <div class="flow-box">JATS XML</div>
    <div class="flow-label">CC-BY pairs we<br>already have</div>
  </div>
  <div class="flow-col-arrow">
    <div class="flow-arrow">→</div>
    <div class="flow-spacer"></div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">sciencebeam-parser</div>
    <div class="flow-label">align the PDF text<br>with the JATS structure</div>
  </div>
  <div class="flow-col-arrow">
    <div class="flow-arrow">→</div>
    <div class="flow-spacer"></div>
  </div>
  <div class="flow-col">
    <div class="flow-box">labelled TEI XML</div>
    <div class="flow-box">label positions</div>
    <div class="flow-label">one set per model,<br>plus where each label sits</div>
  </div>
</div>

- **GROBID** finds the structure in a PDF, and learns it from labelled examples. Annotating this many by hand was never going to happen
- we already have CC-BY **PDF and JATS pairs**: the JATS says **what** each piece of text is, the PDF says **where** it sits
- so the labels are derived instead, and the corpus regenerates whenever the parser changes

<p class="note">Sources today are Open Research Europe and SciELO Preprints, from the benchmarking dataset we already use.</p>

<!--
Keep this under a minute. The point is only that the labels came from a machine, not a person.
The record of label positions on the right is what the whole rest of the talk depends on, so say
it here even though it does nothing yet.
-->

---

# Enough that nobody is going to read it all

- **89 papers**, **1,947 pages**, roughly **100,000 lines** of text
- segmentation marks **5,369 regions** across them: body, references, page headers and the rest
- citation goes finer again: **3,278 references**, cut into **45,955 fields**

<p class="note">The alignment that derives the labels is a heuristic, so the mistakes scale with the data. Generated is not the same as correct.</p>

<!--
Say the numbers, do not let the room read them. The escalation is the point: pages, then regions,
then fields, each one finer than the last.
Lines are there to be relatable, as the amount of text on the pages. Do not say that each line
carries a label: segmentation does work that way, but that is how the model trains rather than
anything visible in the TEI. Regions and references are what the file marks, and what the review
page draws a band per.
The line figure is segmentation's 100,794 over its 86 documents, so it understates the 89
slightly, which is why it is given as roughly.
-->

---

# Reviewing it as XML does not work

```xml
First published: 28 Sep 2021, 1:114 https://doi.org/...<lb/></front>
<note place="headnote">Open Research Europe<lb/></note>
<page>Page 3 of 29<lb/></page>
<body>Plain language summary<lb/>
"Living Evidence to inform health decisions" is a research<lb/>
```

- one document is **1,812 lines** inside **108 regions**, and a label is only where one tag closes and the next opens
- whether a boundary belongs there depends on **where the text sits on the page**, which the file does not say

<!--
Real, 1-114_v2, the front matter giving way to the body on page 3.
Every label in this excerpt is correct. That is the point: a version with the boundary two
lines out would look exactly as plausible, so the file cannot answer the question being asked
of it. Sets up the next three slides, each a different way of asking the page instead.
-->

---

# The same page, with the labels on it

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · 1-114_v2 · segmentation · page 3</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-controls">
    <span class="on">page image</span>
    <span class="on">bands</span>
    <span class="off">hide text</span>
    <span>zoom 100%</span>
  </div>
  <div class="rv-body">
    <div class="rv-row lb-headnote runstart runend centred"><span class="rv-name">&lt;headnote&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w40"></span></span></div>
    <div class="rv-row lb-body runstart spaced"><span class="rv-name">&lt;body&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w40"></span></span></div>
    <div class="rv-row lb-body"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w95"></span></span></div>
    <div class="rv-row lb-body"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-body runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w70"></span></span></div>
    <div class="rv-row lb-page runstart runend spaced right"><span class="rv-name">&lt;page&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w40"></span></span></div>
  </div>
</div>

- the generator records the **page and the box** every labelled piece of text sits in
- drawn back over the page, a running head at the top and a page number at the foot are **plainly** those things

<!--
The same excerpt as the slide before, on the page it came from: the headnote, the body
beginning at "Plain language summary", and the page number at the foot.
Nothing is wrong here, which is the point. The file could not tell you that and the page can,
at a glance, without reading a word of it.
Replace the mock with a real screenshot, page image on.
-->

---

# segmentation: bands make a stray label obvious

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · PPR459643 · segmentation · page 23</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-body">
    <div class="rv-row lb-refs runstart"><span class="rv-name">&lt;references&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w70"></span></span></div>
    <div class="rv-row lb-refs runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w95"></span></span></div>
    <div class="rv-row lb-body runstart runend"><span class="rv-name">&lt;body&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w80"></span><span class="rv-flag">← one line labelled body, inside the reference list</span></span></div>
    <div class="rv-row lb-refs runstart"><span class="rv-name">&lt;references&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w65"></span></span></div>
    <div class="rv-row lb-refs runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w55"></span></span></div>
  </div>
</div>

- a label in the wrong place **breaks the band**, with nothing to read to find it
- nothing has to be read: the **shape of the page** is what is being judged

<!--
Lead with this model because it is the one where looking pays off most, and the one where
reviewing a change pays off most: a moved boundary is visible without reading a word.
The real page has the scan underneath, which toggles on and off.
The pill is the real one: previous, a count of changes, next. Do not explain that it counts
runs of changed lines rather than lines. That is a third unit on top of regions and references,
and it buys nothing the audience needs.
-->

---

# After the fix: the change is marked

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · PPR459643 · segmentation · page 23</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-body">
    <div class="rv-row lb-refs runstart"><span class="rv-name">&lt;references&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w70"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w95"></span></span></div>
    <div class="rv-row lb-refs changed"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w80"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-refs"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w65"></span></span></div>
    <div class="rv-row lb-refs runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w55"></span></span></div>
  </div>
  <div class="rv-foot"><span class="rv-navpill">◀ &nbsp;2 / 5&nbsp; ▶</span></div>
</div>

- the band runs unbroken again, and the line that moved is **outlined**
- the bar steps through **what moved**, one change at a time

<!--
Same page as the slide before, after the fix. Two things changed and both are worth pointing at:
the band is whole, which is the defect gone, and the line that moved carries an outline, which
is the review tool saying this is what is different from the last commit. You are shown where
to look rather than reading the document again.
Replace the mock with a real screenshot, page image on, taken from demo-lightning-talk.
-->

---

# reference-segmenter: where one ends and the next begins

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · 5-107_v2 · reference-segmenter</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-body">
    <div class="rv-row lb-ref runstart"><span class="rv-name">&lt;reference&gt;</span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w95"></span></span></div>
    <div class="rv-row lb-ref runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w70"></span></span></div>
    <div class="rv-row lb-ref alt runstart"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-ref alt runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w55"></span></span></div>
    <div class="rv-row lb-ref runstart runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w95"></span></span></div>
    <div class="rv-row lb-ref alt runstart runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w60"></span><span class="rv-flag">← one reference, read as two</span></span></div>
    <div class="rv-row lb-ref runstart"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w90"></span></span></div>
    <div class="rv-row lb-ref runend"><span class="rv-name"></span><span class="rv-band"></span><span class="rv-cell"><span class="rv-ov"></span><span class="rv-line w65"></span></span></div>
  </div>
</div>

- every line carries the **same label**, so the shade alternates instead of the colour
- read as **51 references** before a fix to where the cuts go, and **48** after

<!--
Still judged by looking, but the question has narrowed from what a region is to where one thing
ends and the next begins.
51 and 48 are the counts before and after the fix, both checked in the record. Do not claim how
many the printed page holds, that has not been counted.
-->

---

# citation: see every field of one label at once

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · 1-114_v2 · citation · page 14, reference 33</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-body">
    <div class="rv-cite">
      <div class="rv-cite-row"><span class="rv-tok lb-note faded"><span class="t">30</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span><span class="rv-tok lb-author peer"><span class="t">Siemieniuk RA, Bartoszko JJ, Ge L, et al.</span></span><span class="rv-tok lb-other faded"><span class="t">:</span></span><span class="rv-tok lb-title faded"><span class="t">Drug treatments for covid-19</span></span><span class="rv-tok lb-journal faded"><span class="t">BMJ.</span></span><span class="rv-tok lb-date faded"><span class="t">2020</span></span><span class="rv-tok lb-other faded"><span class="t">;</span></span><span class="rv-tok lb-volume faded"><span class="t">370</span></span><span class="rv-tok lb-other faded"><span class="t">:</span></span><span class="rv-tok lb-pages faded"><span class="t">m2980</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span></div>
      <div class="rv-cite-row"><span class="rv-tok lb-note faded"><span class="t">31</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span><span class="rv-tok lb-author peer"><span class="t">Reese HW</span></span><span class="rv-tok lb-other faded"><span class="t">:</span></span><span class="rv-tok lb-title faded"><span class="t">The Learning-by-Doing Principle.</span></span><span class="rv-tok lb-journal faded"><span class="t">Behav Dev Bull.</span></span><span class="rv-tok lb-date faded"><span class="t">2011</span></span><span class="rv-tok lb-other faded"><span class="t">;</span></span><span class="rv-tok lb-volume faded"><span class="t">17</span></span><span class="rv-tok lb-other faded"><span class="t">(</span></span><span class="rv-tok lb-issue faded"><span class="t">1</span></span><span class="rv-tok lb-other faded"><span class="t">):</span></span><span class="rv-tok lb-pages faded"><span class="t">1-19</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span></div>
      <div class="rv-cite-row"><span class="rv-tok lb-note faded"><span class="t">32</span></span><span class="rv-tok lb-other faded"><span class="t">. Nvivo:</span></span><span class="rv-tok lb-title faded"><span class="t">Qualitative Data Analysis</span></span><span class="rv-tok lb-other faded"><span class="t">. Cited: February 10th</span></span><span class="rv-tok lb-date faded"><span class="t">2021</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span></div>
      <div class="rv-cite-row"><span class="rv-tok lb-note faded"><span class="t">33</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span><span class="rv-tok lb-author peer"><span class="t">Rojas-</span></span><span class="rv-tok lb-other faded"><span class="t">Reyes</span></span><span class="rv-tok lb-author hovered"><span class="t">MX, Rispau AA, Santafe AK, et al.</span><span class="rv-cursor"></span><span class="rv-readout"><span class="sw"></span>&lt;author&gt; &nbsp;·&nbsp; "MX, Rispau AA, Santafe AK, et al."</span></span><span class="rv-tok lb-other faded"><span class="t">:</span></span><span class="rv-tok lb-title faded"><span class="t">Living evidence to inform health decisions</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span><span class="rv-tok lb-date faded"><span class="t">2021</span></span><span class="rv-tok lb-other faded"><span class="t">.</span></span></div>
    </div>
  </div>
</div>

- a reference becomes **14 boxes**, 8 of them labelled; a preprint's list, **541**
- hovering one marks **every field of that label**, so a gap in the pattern shows

<!--
One author name labelled as two, with Reyes carrying nothing. One field among 45,955.
The file above and the page below are the same reference, which is the argument of the talk in
one slide: it is a word in a diff, and it is obvious as a page.
Give the room a few seconds of silence here. Zoom is the other tool worth naming if there is time:
it scales the page rather than the window, and the boxes stay sharp because they are drawn.
Replace the mock with a real screenshot, zoomed, mid-hover if that can be caught.
-->

---

# Say what is wrong, where the data lives

<div class="rv">
  <div class="rv-bar">
    <span class="term-dot r"></span><span class="term-dot y"></span><span class="term-dot g"></span>
    <span class="term-title">localhost:8000 · 1-114_v2 · citation</span>
    <span class="mock-tag">illustrative mock</span>
  </div>
  <div class="rv-panel">
    <div class="rv-prow"><strong>Review</strong><span class="rv-pill">never reviewed</span><span class="rv-grow"></span><span class="rv-btn">Accept</span><span class="rv-btn">Reject</span><span class="rv-btn">Stage</span></div>
    <div class="rv-prow"><span class="rv-select">&lt;author&gt; &#9662;</span><span class="rv-input">Reyes is part of the author name, not separate from it</span><span class="rv-btn">Comment</span></div>
    <div class="rv-prow rv-about">about <strong>page 14, line 123</strong><q>33. Rojas-Reyes MX, Rispau AA, Santafe AK, et al.</q></div>
  </div>
</div>

- accept, reject, or just say what is wrong: a comment needs **no verdict under it**
- it can **suggest the label** the line should have had, recorded beside the comment
- all of it is **committed with the data**, so reviewing a corpus is reviewing a pull request
- a comment **survives the fix it asked for**, and a verdict lapses when the document is regenerated

<!--
Writing down what is wrong is often the first thing a reader does, and the record then says
"commented, not judged", which to anything reading verdicts is the same as unreviewed.
A comment that has been dealt with is resolved rather than deleted: it says a defect was seen
and seen to, which is worth more than its absence.
Nothing reads a suggested label yet. It is recorded so a regeneration can one day be checked
against it.
-->

---

<!-- _class: dark -->

# Takeaway

- **Reading it was worth the time**: 78 comments on segmentation, and all **86 documents accepted**
- Review it in the **medium it came from**: on the page a bad label is something you see, not something you have to find
- The finer the labels get, the **more the page has to do**: a band, then a shade, then a hover
- Built with **coding agents**, which made it cheap to keep refining the tool and tailor it to what the review needed

<!--
The first bullet is deliberately modest: what reading was worth here, not a claim that
generating your data always turns the work into review. It does not, and the slides should not
say it does.
Segmentation is the finished one and that is why it is the example: 86 documents, 78 comments
written along the way, 86 accepted and none rejected. The aim is every model in that state.
The others are still being worked through, so give their numbers only if asked: reference
segmenter 77 of 88 accepted, citation and header still mostly commented rather than judged.
205 documents carry a verdict in all, with 167 comments. The three fixes the demo worktrees
are built around are three of those, not the total.
Q&A only, do not put it on a slide: the corpus already carries a quality record that counts what
the generation grounded in the JATS, per label and for the reference alignment, so reading is
not the only check. Nor does it replace counting. If pressed on why counts are not enough,
<headnote> is grounded 0 of 47 lines and <page> 0 of 29, and both are correct, because running
heads and page numbers are not in the JATS at all.
-->
