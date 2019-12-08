#' @title Open documentation markdown file in R or RStudio
#' @name doc_open
#'
#' @description Opens a markdown documentation file in R or RStudio. A wrapper function for utils::file.exists()
#' @param md_file markdown document filepath
#'
#' @author Hause Lin
#' @usage doc_open(md_file)
#' @examples
#' \dontrun{doc_open("mcars.md")}
#' @export
doc_open <- function(md_file) {
    md_file <- generate_md_string(md_file)
    if (file.exists(md_file)) {
        utils::file.edit(md_file)
    } else {
        stop("Doc doesn't exist!")
    }
}
