library(RCurl)
library(jsonlite)
library(magrittr)
library(tidyr)
library(lubridate)

conv.null <- function(df, cols=colnames(df)) {
  for (col in cols) {
    df[sapply(df[[col]], length) == 0, col] <- NA
  }
  df
}

conv.rid <- function(df, cols=colnames(df)) {
  for (col in cols) {
    df <- conv.null(df, cols=col)
    df[[col]] <- sapply(df[[col]], function(x)
      strsplit(x, ":")[[1]][2]) %>%
      as.integer()
  }
  df
}

unwind <- function(df, cols=colnames(df)) {
  for (col in cols) {
    df <- conv.null(df, cols=col)
    df <- unnest_(df, col)
  }
  df
}

conv.date <- function(df, cols=colnames(df), fmt = "ymd") {
  for (col in cols) {
    df <- conv.null(df, cols=col)
    df[[col]] <- parse_date_time(df[[col]], fmt)
  }
  df
}

conv.factor <- function(df, cols=colnames(df)) {
  for (col in cols) {
    df <- conv.null(df, cols=col)
    df[[col]] <- as.factor(df[[col]])
  }
  df
}

auto.clean <- function(df) {
  df["@type"] <-
    df["@version"] <-
    df["@rid"] <-
    df["@fieldTypes"] <-
    df["@class"] <- NULL
  df
}

ft.list <- function(ft) {
  uft <- strsplit(ft[!is.na(ft)], ",") %>%
    unlist %>%
    unique %>%
    sapply(function(x)
      strsplit(x, "=")[[1]][2])
  names(uft) <-
    sapply(names(uft), function(x)
      strsplit(x, "=")[[1]][1])
  uft
}

igsub <- function(x, pattern, replacement, ...) gsub(pattern, replacement, x, ...)

# to Delete all list(null)
rmNullObs <- function(x) {
  x <- Filter(Negate(is.NullOb), x)
  lapply(x, function(x) if (is.list(x)) rmNullObs(x) else x)
}
