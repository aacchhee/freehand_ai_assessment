# Freehand AI assessment

Students solve problems on paper, photograph their working, upload it and get
AI feedback in four steps: assessment, explanation, method and worked solution.
Each subtask also has an automatically checked answer field. A feedback-language menu on each subtask switches the
language of the AI's answer (English, Norwegian, Swedish, Spanish, Russian,
German).

| Page | English | Bokmål |
|---|---|---|
| Physics, *Prøveeksamen V2025* | `pages/handwriting-ai.qmd` | `pages/handskrift-ki.qmd` |
| Mathematics, logarithms from exam V24 (1b, 3b, 3c) | `pages/logarithms-ai.qmd` | `pages/logaritmer-ki.qmd` |
| Guide for teachers | `pages/handwriting-ai-prompts.qmd` | `pages/handskrift-ki-prompter.qmd` |

Each exam page has its own prompts, YAML files that teachers can edit:

| Page | How the AI answers (tone, hint ladder) | What it knows about each subtask |
|---|---|---|
| Physics | `feedback/handwriting/tutor.yml`, `feedback/handskrift/veileder.yml` | `feedback/handwriting/tasks.yml`, `feedback/handskrift/oppgaver.yml` |
| Logarithms | `feedback/logarithms/tutor.yml`, `feedback/logaritmer/veileder.yml` | `feedback/logarithms/tasks.yml`, `feedback/logaritmer/oppgaver.yml` |

The answer fields of the logarithms page use Python checkers (in
`_includes/logarithms/problems.md` and `_includes/logaritmer/oppgaver.md`) with
tests in `_includes/logaritmer/tests/` that `quarto render` runs.

The guide pages explain how to edit them, and the prompt sandbox at the bottom
of each exam page tries changes in the browser without rebuilding the site.
The buttons **Fill in student 1 / 2** (physics) and **Load student 1–9**
(logarithms) load real, anonymised student answers (`assets/handskrift/`,
`assets/logaritmer/`; published with the students' consent).

## Run locally

Install Git, Python 3.12 and [Quarto 1.8.27](https://quarto.org/docs/download/).

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
python -m pip install -r requirements.txt
python scripts/setup.py
quarto preview
```

`scripts/setup.py` installs [CTM Assessment](https://github.com/Erasmus-CTM/ctm-assessment)
(the Quarto extensions for the answer fields and the AI feedback) at the exact
commit in `quarto-extensions.yml`. Run it again after changing that commit. For
a static build, run `quarto render`; the site is written to `_site/`.

To use the AI feedback, open the gear ⚙ next to a Feedback button and enter an
OpenAI-compatible API address, your own API key and a model that can read
images. Keys are stored only in the browser, never in the repository.

## Publishing

`.github/workflows/build.yml` builds every pull request. Pushes to `main` are
built and published to the `gh-pages` branch. After the first successful run,
select **Settings → Pages → Deploy from a branch → gh-pages / (root)**.

Expected URL: <https://aacchhee.github.io/freehand_ai_assessment/>.
