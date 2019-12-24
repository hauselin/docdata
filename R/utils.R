#' @keywords internal
generate_md_string <- function(x) {
    # convert x to .md file type
    idx <- gregexpr(pattern = ".", text = x, fixed = TRUE)[[1]]
    idx <- idx[[length(idx)]]
    str2replace <- substring(text = x, first = idx)
    markdown <- gsub(pattern = str2replace, replacement = ".md", x = x, fixed = TRUE)
    return(markdown)
}

#' @keywords internal
display_doc_md <- function(x) {
    conn <- file(x, open = "r")
    linn <- readLines(conn)
    message("--- DOCUMENTATION BEGIN ---")
    for (i in 1:length(linn)) {
        cat(sprintf("%5.d     ", i), sep = "") # print line number
        cat(linn[i], sep = "\n") # print line
    }
    close(conn)
    message("--- DOCUMENTATION END ---")
}


#' @keywords internal
read_doc_md <- function(x) {
    conn <- file(x, open = "r")
    linn <- readLines(conn)
    close(conn)
    return(linn)
}

#' @keywords internal
get_datasource_extension <- function(x) {

  # get md filename
  idx <- gregexpr(pattern = ".", text = x, fixed = TRUE)[[1]]
  if (idx[1] != -1) {
    idx <- idx[[length(idx)]]
    x <- paste0(substring(text = x, first = 1, last = idx), "md")
  } else {
    x <- paste0(x, "md")
  }

  md <- read_doc_md(x)
  idx <- grep(pattern = "## Data source", x = md, fixed = TRUE) + 2
  datasource <- md[idx]
  idx <- gregexpr(pattern = ".", text = datasource, fixed = TRUE)[[1]]
  idx <- idx[[length(idx)]]
  extension <- substring(text = datasource, first = idx)
  extension
}

#' @import data.table
#' @import stringi
#' @keywords internal
mdtable2dat <- function(x) {
    doc <- read_doc_md(x)
    idx <- grep(pattern = "| ", x = doc, fixed = TRUE) # beginning of table
    rows <- doc[idx]
    rows <- rows[-c(1, 2)]
    temp_dat <- data.frame()
    for (r in 1:length(rows)) {
        idx <- gregexpr(pattern = "|", text = rows[r], fixed = TRUE)[[1]]
        temp_dat[r, "Column"] <- substr(x = rows[r], start = idx[1]+2, stop = idx[c(1+1)]-1)
        temp_dat[r, "Type"] <- substr(x = rows[r], start = idx[2]+2, stop = idx[c(2+1)]-1)
        temp_dat[r, "Description"] <- substr(x = rows[r], start = idx[3]+2, stop = idx[c(3+1)]-1)
    }
    data.table::data.table(temp_dat)
}

#' @import data.table
#' @import stringi
#' @keywords internal
string2dat <- function(x) {
    x <- x[-c(1, 2)]
    temp_dat <- data.frame()
    for (r in 1:length(x)) {
        idx <- gregexpr(pattern = "|", text = x[r], fixed = TRUE)[[1]]
        temp_dat[r, "Column"] <- substr(x = x[r], start = idx[1]+2, stop = idx[c(1+1)]-1)
        temp_dat[r, "Type"] <- substr(x = x[r], start = idx[2]+2, stop = idx[c(2+1)]-1)
        temp_dat[r, "Description"] <- substr(x = x[r], start = idx[3]+2, stop = idx[c(3+1)]-1)
    }
    data.table::data.table(temp_dat)
}

#' @import data.table
#' @import stringi
#' @keywords internal
dat2string <- function(datainfo) {

    # trim whitespace before/after
    datainfo$Column <- trimws(datainfo$Column)
    datainfo$Type <- trimws(datainfo$Type)
    datainfo$Description <- trimws(datainfo$Description)

    # remove extra spaces
    datainfo$Column <- gsub(pattern = "  ", replacement = " ", datainfo$Column)
    datainfo$Type <- gsub(pattern = "  ", replacement = " ", datainfo$Type)
    datainfo$Description <- gsub(pattern = "  ", replacement = " ", datainfo$Description)

    cpad <- max(sapply(datainfo$Column, nchar))
    columns <- stringi::stri_pad(datainfo$Column, max(c(cpad + 1), 7), "right")

    tpad <- max(sapply(datainfo$Type, nchar))
    types <- stringi::stri_pad(datainfo$Type, max(c(tpad + 1), 4), "right")

    dpad <- max(sapply(datainfo$Description, nchar))
    descriptions <- stringi::stri_pad(datainfo$Description, max(c(dpad + 1), 11), "right")

    c_header <- stringi::stri_pad("Column", max(c(cpad + 1), 7), "right")
    t_header <- stringi::stri_pad("Type", max(c(tpad + 1), 4), "right")
    d_header <- stringi::stri_pad("Description", max(c(dpad + 1), 11), "right")

    c_header2 <- strrep("-", max(c(cpad + 1), 7))
    t_header2 <- strrep("-", max(c(tpad + 1), 4))
    d_header2 <- strrep("-", max(c(dpad + 1), 11))

    c(paste0("| ", c_header, " | ", t_header, " | ", d_header, " |"),
      paste0("| ", c_header2, " | ", t_header2, " | ", d_header2, " |"),
      paste0("| ", columns, " | ", types, " | ", descriptions, " |"))
}
