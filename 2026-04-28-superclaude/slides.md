---
marp: true
theme: default
html: true
paginate: true
style: |
  section {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    font-size: 2.1rem;
    padding: 60px 72px;
    color: #1a1a1a;
    background: #ffffff;
  }

  h1 {
    font-size: 3.2rem;
    font-weight: 700;
    color: #111;
    margin-bottom: 0.5em;
    border-bottom: 3px solid #2563eb;
    padding-bottom: 0.2em;
  }

  strong {
    color: #2563eb;
  }

  section.title {
    background: #18181b;
    color: #ffffff;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  section.title h1 {
    font-size: 3.6rem;
    color: #ffffff;
    border-bottom: 3px solid #2563eb;
    padding-bottom: 0.3em;
  }

  section.title p {
    color: #a1a1aa;
    font-size: 1.55rem;
    margin-top: 0.6em;
  }

  section.dark {
    background: #18181b;
    color: #ffffff;
  }

  section.dark h1 {
    color: #ffffff;
    border-bottom-color: #2563eb;
  }

  section.dark blockquote {
    background: #27272a;
    border-left-color: #2563eb;
    color: #e4e4e7;
  }

  section.dark p {
    color: #d4d4d8;
  }

  table {
    font-size: 1.65rem;
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
    margin-top: 0.5em;
  }

  th {
    font-weight: 600;
    text-align: left;
    padding: 0.55em 0.8em;
    border-bottom: 2px solid #d4d4d8;
    background: #f4f4f5;
  }

  td {
    padding: 0.55em 0.8em;
    border-bottom: 1px solid #e4e4e7;
    vertical-align: top;
  }

  section.wide-first td:first-child,
  section.wide-first th:first-child {
    width: 62%;
  }

  section.narrow-first td:first-child,
  section.narrow-first th:first-child {
    width: 18%;
  }

  code {
    background: #f4f4f5;
    color: #2563eb;
    padding: 0.15em 0.45em;
    border-radius: 4px;
    font-size: 1.35rem;
  }

  pre {
    background: #1e1e2e;
    color: #cdd6f4;
    padding: 1em 1.3em;
    border-radius: 8px;
    font-size: 1.55rem;
  }

  pre code {
    background: transparent;
    color: inherit;
    padding: 0;
  }

  blockquote {
    border-left: 4px solid #2563eb;
    background: #eff6ff;
    padding: 0.6em 1em;
    margin: 0.4em 0;
    color: #1e3a8a;
    font-style: normal;
    font-size: 1.7rem;
  }

  ol {
    padding-left: 1.4em;
    margin-top: 0.3em;
  }

  ol li {
    margin-bottom: 0.4em;
  }

  .note {
    font-size: 1.2rem;
    color: #71717a;
    margin-top: 1em;
  }

  .flow {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.6em;
    margin-top: 2em;
  }

  .flow-box {
    background: #eff6ff;
    border: 2px solid #2563eb;
    border-radius: 8px;
    padding: 0.45em 0.9em;
    text-align: center;
    font-size: 1.4rem;
    font-weight: 600;
    color: #1e3a8a;
  }

  .flow-cmd {
    background: #1e1e2e;
    color: #93c5fd;
    border-color: #3b82f6;
    font-family: monospace;
  }

  .flow-arrow {
    color: #2563eb;
    font-size: 2rem;
    font-weight: bold;
    line-height: 1;
  }

  .flow-labeled {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    gap: 0.6em;
    margin-top: 1.8em;
  }

  .flow-col {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.4em;
  }

  .flow-col-arrow {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.4em;
    padding-top: 0.35em;
  }

  .flow-label {
    height: 3em;
    font-size: 1.15rem;
    color: #555;
    text-align: center;
    line-height: 1.3;
    display: flex;
    align-items: flex-start;
    justify-content: center;
  }

  .flow-spacer {
    height: 3em;
  }

  section[data-marpit-pagination]::after {
    color: #a1a1aa;
    font-size: 0.9rem;
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
