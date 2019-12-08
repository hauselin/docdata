#' @title Open documentation markdown file in R or RStudio
#' @name doc_open
#'
#' @description Opens a markdown documentation file in R or RStudio. A wrapper function for utils::file.exists()
#' @param x filepath (e.g., md/txt/csv)
#'
#' @author Hause Lin
#' @usage doc_open(x)
#' @examples
#' \dontrun{doc_open("mcars.md")}
#' @export
doc_open <- function(x) {
    x <- generate_md_string(x)
    if (file.exists(x)) {
        utils::file.edit(x)
    } else {
        stop("Doc doesn't exist!")
    }
}
