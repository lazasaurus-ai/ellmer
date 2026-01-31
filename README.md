
# ellmer (Kimi Coding fork)

## Kimi Coding API (experimental / fork-only)

This fork includes experimental support for the Kimi Coding API (api.kimi.com/coding).

⚠️ Important note

While this API is technically compatible with OpenAI-style chat completions, access is currently restricted to a small set of recognized “coding agents” (e.g. Kimi CLI, Claude Code, Roo Code). In practice, requests are gated based on client identity (User-Agent).

Although it is possible to access the API by presenting as a supported coding agent, this approach relies on client identification spoofing and is therefore not suitable for upstream inclusion in ellmer.

For this reason:

- This functionality is provided for personal / experimental use only
- It is not intended to be merged upstream
- No pull request will be opened until Moonshot/Kimi provides an officially supported SDK or API contract for third-party libraries
- This code exists to document behavior and enable local experimentation, not to bypass provider policy.

Additional notes:

- Sometimes, when using this API, Kimi responds as being Claude — likely because this endpoint is designed to be used by Claude Code / Roo Code and follows an Anthropic-style schema.
- We do not know the exact model behind this API; as of 1/30/2026, it is reasonable to assume it is Kimi 2.5.

## Example

```r
kimi_client <- chat_kimi_code(
  system_prompt = "You are Kimi for Coding (Moonshot AI). Be terse.",
  echo = "none"
)

kimi_client$chat("Hi who are you?")
kimi_client$chat("What is R?")
kimi_client$chat(
  "Which is better for data science: R or Python? Give a balanced answer with 3 bullet points."
)
```

Example output:

```
ℹ Loading ellmer
Using model = "kimi-for-coding".
I'm Kimi, an AI assistant made by Moonshot AI.
R is a programming language and environment for statistical computing and
graphics. Key features:

- **Statistics**: data analysis, modeling, hypothesis testing
- **Visualization**: publication-quality plots (ggplot2, base graphics)
- **Data manipulation**: tidyverse ecosystem (dplyr, tidyr)
- **Open source**: free, with extensive package repository (CRAN)
- **Reproducible research**: R Markdown, Quarto

Common uses: academia, bioinformatics (Bioconductor), finance, data science.
- **R excels at statistics and visualization** — deeper statistical methods,
ggplot2's grammar of graphics, and domain-specific packages (especially
biostatistics/econometrics)

- **Python dominates production and general ML** — better software engineering
tools, broader ML ecosystem (PyTorch, TensorFlow, scikit-learn), and easier
deployment

- **Choice depends on context** — R for research/reproducible analysis; Python
for engineering pipelines; many teams use both (R for exploration, Python for
production)
- **Printing**: tibbles show first 10 rows and fit width; data.frames can flood
console

- **Subsetting**: tibbles never simplify to vectors (`drop = FALSE` by
default); data.frames do

- **Column types**: tibbles enforce stricter rules (no partial matching, no `$`
auto-conversion)

- **Creation**: tibbles don't convert strings to factors by default;
data.frames historically did

- **Class**: tibble is a data.frame subclass — works wherever data.frames do,
with added tidyverse behavior
```
