vv_transformer <- function(text, envir) {
  require(glue)
  regex <- "=$"
  if (!grepl(regex, text)) {
    return(identity_transformer(text, envir))
  }

  text <- sub(regex, "", text)
  res <- identity_transformer(text, envir)
  n <- length(res)
  res <- glue_collapse(res, sep = ", ")
  if (n > 1) {
    res <- c("[", res, "]")
  }
  glue_collapse(c(text, " = ", res))
}
