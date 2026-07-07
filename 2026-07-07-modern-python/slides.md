---
marp: true
theme: slides
html: true
paginate: true
---

<!-- _class: title -->

# Modern Python

Daniel Ecer &nbsp;·&nbsp; 7 July 2026

---

# Python circa 2010

```python
import requests

class Paper(object):
    def __init__(self, doi, title):
        self.doi = doi
        self.title = title

def fetch(doi):
    url = 'https://api.crossref.org/works/' + doi
    response = requests.get(url)
    return Paper(doi, response.json()['message']['title'][0])
```

---

# Python today

```python
from dataclasses import dataclass
import httpx

@dataclass(frozen=True)
class Paper:
    doi: str
    title: str

async def fetch(doi: str) -> Paper:
    async with httpx.AsyncClient() as client:
        response = await client.get(f"https://api.crossref.org/works/{doi}")
    return Paper(doi, response.json()["message"]["title"][0])
```

<!-- The rest of the talk is about what each of those differences means. -->

---

<!-- _class: title -->

# Type system

Type annotations, dataclasses, Protocol, and gradual typing

---

# Python has had type hints since 3.5

Types are checked by tools such as mypy or pyright. They are not enforced at runtime.

```python
# without types
def parse_doi(text):
    return text.strip().lower()

# with types
def parse_doi(text: str) -> str:
    return text.strip().lower()
```

mypy and pyright check types without executing the code. Existing untyped code continues to run, and types can be added one file at a time.

---

# Dataclasses generate the boilerplate

`@dataclass` generates `__init__`, `__repr__`, and `__eq__` automatically. Available since Python 3.7.

```python
from dataclasses import dataclass, field

@dataclass(frozen=True)
class Paper:
    doi: str
    title: str
    year: int
    authors: list[str] = field(default_factory=list)
```

---

# Union types and TypedDict

```python
def find(doi: str) -> Paper | None:
    return papers.get(doi)
```

```python
from typing import TypedDict
class CrossrefMessage(TypedDict):
    title: list[str]
    DOI: str
```

`Paper | None` union syntax was added in Python 3.10. `Optional[Paper]` is the equivalent for earlier versions.

---

# Pydantic validates types at runtime

```python
from pydantic import BaseModel

class Paper(BaseModel):
    doi: str
    title: str
    year: int

paper = Paper.model_validate(api_response)
# raises ValidationError if fields are missing or the wrong type
```

Pydantic enforces standard type annotations at runtime and supports additional validation rules such as value ranges and string patterns via `Field()`.

---

# Protocol: structural typing

```python
from typing import Protocol

class Fetchable(Protocol):
    async def fetch(self, doi: str) -> Paper: ...
```

```python
class CrossrefFetcher:
    async def fetch(self, doi: str) -> Paper:
        return ...
```

Any class with a matching `fetch` method satisfies `Fetchable`. No explicit declaration needed.

<!--
CrossrefFetcher does not declare that it implements Fetchable. mypy verifies the match
structurally at check time. Useful for dependency injection and testing: any object with
the right method signature satisfies the Protocol, with no shared base class required.
-->

---

<!-- _class: title -->

# Language features

f-strings, comprehensions, generators, pattern matching, and async/await

---

# f-strings

```python
url   = f"https://api.crossref.org/works/{doi}"
msg   = f"Found {len(papers)} papers"
price = f"{ratio:.1%}"
```

Any Python expression works inside `{}`. Format specs follow `str.format()` syntax: `:.2f`, `:.1%`, `:>10`. Available since Python 3.6.

---

# List comprehensions

```python
dois   = list(map(lambda p: p.doi, papers))
recent = list(filter(lambda p: p.year >= 2020, papers))
```

```python
dois         = [p.doi for p in papers]
recent       = [p for p in papers if p.year >= 2020]
unique_years = {p.year for p in papers}
```

`map()` and `filter()` also exist. `{}` creates a set; `{p.doi: p for p in papers}` creates a dict.

---

# Generators produce values on demand

```python
# list: stored in memory
titles = [p.title for p in papers]

# generator expression: one value at a time
titles = (p.title for p in papers)
```

```python
import itertools
all_papers = itertools.chain(arxiv_papers, pubmed_papers)
first_ten  = list(itertools.islice(generate_papers(), 10))
```

`itertools` provides composable functions for working with any iterable.

---

# Generator functions

```python
def read_papers(path):
    with open(path) as fp:
        for line in fp:
            yield json.loads(line)
```

```python
def all_papers():
    yield from read_papers("arxiv.jsonl")
    yield from read_papers("pubmed.jsonl")
```

`yield` suspends the function and returns one value. `yield from` delegates to another iterable. Neither reads any data until you iterate.

<!--
Calling read_papers() does not execute the function body — it returns a generator object.
The body runs up to the first yield when you iterate. Local variables are preserved between
yields. yield from is equivalent to a for loop with yield, but more efficient and composable.
-->

---

# Structural pattern matching, added in Python 3.10

Matches on the shape of a value, not just its identity.

```python
match event:
    case {"type": "article", "doi": doi}:
        process_article(doi)
    case {"type": "book", "isbn": isbn, "chapter": n}:
        process_chapter(isbn, n)
    case {"type": str(t)}:
        LOGGER.warning("unknown type: %s", t)
    case _:
        pass
```

<!--
This is not a switch statement on a value — it matches on the shape of the data.
The first case checks that event has a "type" key equal to "article" AND a "doi" key,
and binds the doi value to a local variable, all in one expression. This is called
structural pattern matching or destructuring.
-->

---

# async/await

```python
async def fetch_data(url: str) -> dict:
    async with httpx.AsyncClient() as c:
        return (await c.get(url)).json()
```

```python
results = await asyncio.gather(
    fetch_data(url1),
    fetch_data(url2),
)
```

`asyncio.gather()` runs coroutines concurrently, switching between them when each is waiting on I/O.

<!--
Python's async uses cooperative multitasking. The event loop runs one coroutine at a time,
switching when one awaits. There is no parallelism, but also no race conditions on shared
state. asyncio.gather() schedules multiple coroutines and interleaves their execution.
-->

---

# Threading and multiprocessing

```python
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor

# I/O-bound: threads release the GIL while waiting on I/O
with ThreadPoolExecutor() as pool:
    results = list(pool.map(fetch, urls))

# CPU-bound: separate processes bypass the GIL entirely
with ProcessPoolExecutor() as pool:
    results = list(pool.map(process, items))
```

The GIL prevents CPU parallelism in threads. Python 3.13 ships an experimental free-threaded build with the GIL disabled (PEP 703).

<!--
ThreadPoolExecutor uses threads; the GIL releases during I/O so threads improve throughput for network and file work.
ProcessPoolExecutor spawns separate processes, each with their own GIL, so CPU-bound work genuinely runs in parallel.
Python 3.13 (October 2024) ships a free-threaded build where the GIL can be disabled; this is experimental and opt-in.
-->

---

# Putting it together: FastAPI

```python
from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()

class Paper(BaseModel):
    doi: str
    title: str

@app.get("/papers/{doi}", response_model=Paper)
async def get_paper(doi: str) -> Paper:
    return await fetch(doi)
```

<p class="note">FastAPI generates OpenAPI documentation automatically from the type annotations.</p>

---

<!-- _class: title -->

# Tooling

uv, ruff, mypy, pylint, and pyproject.toml

---

# Python toolchain

| Tool | Role |
|---|---|
| **uv** | Package and project manager |
| **ruff** | Linter and formatter |
| **mypy** | Type checker |
| **pylint** | Static analysis |

ruff covers linting and formatting only, not type checking or static analysis. pyright is an alternative to mypy with stronger VS Code integration.

```bash
uv add httpx       # install a package
uv run script.py   # run without activating a venv
```

---

# pyproject.toml

Project metadata, dependencies, and tool configuration in one file.

```toml
[project]
name = "my-tool"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = ["httpx>=0.27", "pydantic>=2.0"]

[dependency-groups]
dev = ["mypy", "ruff", "pytest"]

[tool.ruff]
line-length = 100
```

---

# The Python ecosystem

- **Scientific computing and ML**: NumPy, pandas, scikit-learn, PyTorch
- **Data pipelines and orchestration**: Airflow, Prefect, dbt
- **HTTP APIs**: Django, FastAPI
- **Infrastructure and automation**: Ansible, many CLI tools

---

<!-- _class: dark -->

# Summary

- Type hints since 3.5; mypy or pyright check them without any effect at runtime
- `@dataclass`, `Protocol`, `TypedDict`, union types, and `match`/`case` have been added since 3.7
- Pydantic enforces the same annotations at runtime
- uv and ruff replace pip, venv, flake8, and black
- `async`/`await`, list comprehensions, and generators are part of the standard language
- The scientific computing ecosystem has no equivalent elsewhere
