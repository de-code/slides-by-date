---
marp: true
theme: slides
html: true
paginate: true
style: |
  section {
    --accent: #2563eb;
    --accent-bg: #eff6ff;
    --accent-dark: #1e3a8a;
    --code-bg: #f4f4f5;
  }
---

<!-- _class: title -->

# SuperClaude:<br>slash commands for Claude Code

Daniel Ecer &nbsp;·&nbsp; 28 Apr 2026

---

# We all use Claude Code.

Every session starts from scratch. Figuring out what to ask and how to ask it takes its own effort.

**SuperClaude adds structure to that.**

---

<!-- _class: wide-first -->

# Pick the command for where you are in the work.

| When | Command |
|---|---|
| Starting something new | `/sc:brainstorm` |
| Designing a system or API | `/sc:design` |
| Writing a new feature | `/sc:implement` |
| Before a PR | `/sc:analyze` |
| Something is broken | `/sc:troubleshoot` |
| Writing tests | `/sc:test` |
| Writing documentation | `/sc:document` |

<p class="note">30 commands in total. You do not need all of them.</p>

---

# Building a new feature.

<div class="flow-labeled">
  <div class="flow-col">
    <div class="flow-box flow-cmd">/sc:brainstorm</div>
    <div class="flow-label">clarify what<br>you are building</div>
  </div>
  <div class="flow-col-arrow">
    <div class="flow-arrow">→</div>
    <div class="flow-spacer"></div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">/sc:design</div>
    <div class="flow-label">structure<br>the approach</div>
  </div>
  <div class="flow-col-arrow">
    <div class="flow-arrow">→</div>
    <div class="flow-spacer"></div>
  </div>
  <div class="flow-col">
    <div class="flow-box flow-cmd">/sc:implement</div>
    <div class="flow-label">write<br>the code</div>
  </div>
</div>

<p class="note">Each command works on its own. Used in sequence, they take an idea to working code.</p>

---

# What brainstorm asks.

> "/sc:brainstorm I want to add a data export feature."

1. What data needs to be exported, and who are the primary users?
2. What formats are required: CSV, JSON, or others?
3. How large can exports get? Does this need to run asynchronously?
4. Should users be able to filter or select a date range?
5. Are there any data privacy or compliance requirements?

<p class="note">Question 3 is the kind of thing you might not think about until it is already a problem.</p>

---

<!-- _class: dark -->

# I used it to prepare this talk.

I typed one sentence:

> "/sc:brainstorm Help me prepare a 7-minute lightning talk about SuperClaude for our tech team."

It asked five questions back. I answered each one. Then it produced a structure.

---

# The questions it asked.

1. What is your primary outcome for this talk?
2. Where is your team currently with AI-assisted dev tools?
3. What do you find most valuable about SuperClaude?
4. What is the one thing you want someone to remember 24 hours later?
5. Do you have a live demo in mind, or is this slides-only?

<p class="note">Some of those questions shaped what you are watching now.</p>

---

<!-- _class: narrow-first -->

# The structure it produced.

| Time | Slide |
|---|---|
| 0:00 | The blank canvas problem |
| 1:00 | What SuperClaude is, with examples |
| 2:30 | A two-way session, not a single prompt |
| 5:00 | The questions it asked |
| 6:30 | How to get started |

---

<!-- _class: title -->

# Try it.

```
pipx install superclaude
superclaude install
```

**github.com/SuperClaude-Org/SuperClaude_Framework**
