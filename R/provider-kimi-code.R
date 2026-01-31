#' @include provider-claude.R
NULL

#' Chat with Kimi Coding (Kimi Code)
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' This is an **experimental, fork-only** provider for the Kimi Coding API
#' (`https://api.kimi.com/coding`).
#'
#' The implementation uses an Anthropic-style Messages API and is built by
#' reusing the existing Anthropic provider implementation.
#'
#' @inheritParams chat_anthropic
#' @param api_key `r lifecycle::badge("deprecated")` Use `credentials` instead.
#' @param credentials `r api_key_param("KIMI_CODING_API_KEY")`
#' @param base_url Base URL for the Kimi Coding API.
#' @param model Model name. Defaults to `"kimi-for-coding"`.
#' @family chatbots
#' @export
chat_kimi_code <- function(
  system_prompt = NULL,
  params = NULL,
  model = NULL,
  api_args = list(),
  base_url = Sys.getenv(
    "KIMI_CODING_BASE_URL",
    "https://api.kimi.com/coding/v1"
  ),
  api_key = NULL,
  credentials = NULL,
  api_headers = character(),
  echo = NULL
) {
  echo <- check_echo(echo)
  model <- set_default(model, "kimi-for-coding")

  credentials <- as_credentials(
    "chat_kimi_code",
    function() key_get("KIMI_CODING_API_KEY"),
    credentials = credentials,
    api_key = api_key
  )

  # Reuse the Anthropic provider implementation.
  # Kimi Coding speaks an Anthropic-like Messages API at /v1/messages.
  provider <- ProviderAnthropic(
    name = "Kimi Coding",
    model = model,
    params = params %||% params(),
    extra_args = api_args,
    extra_headers = api_headers,
    base_url = base_url,
    beta_headers = character(),
    credentials = credentials,
    cache = "none"
  )

  Chat$new(provider = provider, system_prompt = system_prompt, echo = echo)
}

#' @rdname chat_kimi_code
#' @export
chat_kimi_coding <- chat_kimi_code
