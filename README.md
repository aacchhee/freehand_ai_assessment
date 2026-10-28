# Freehand AI assessment

Students solve physics problems from *Prøveeksamen V2025* on paper, photograph
their working, upload it and get AI feedback in four steps: assessment,
explanation, method and worked solution. Each subtask also has an automatically
checked answer field. A feedback-language menu on each subtask switches the
language of the AI's answer (English, Norwegian, Swedish, Spanish, Russian,
German).

- **English:** `pages/handwriting-ai.qmd` (exam) and
  `pages/handwriting-ai-prompts.qmd` (guide for teachers).
- **Bokmål:** `pages/handskrift-ki.qmd` and `pages/handskrift-ki-prompter.qmd`.

The prompts are YAML files that teachers can edit:

| File | Controls |
|---|---|
| `feedback/handwriting/tutor.yml`, `feedback/handskrift/veileder.yml` | How the AI answers: tone, structure, length, the four-level hint ladder |
| `feedback/handwriting/tasks.yml`, `feedback/handskrift/oppgaver.yml` | What the AI knows about each subtask: reference solution and typical mistakes |

The guide pages explain how to edit them, and the prompt sandbox at the bottom
of each exam page tries changes in the browser without rebuilding the site.
The buttons **Fill in student 1 / 2** load real, anonymised student answers
(`assets/handskrift/student1/`, `student2/`; published with the students'
consent).

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
