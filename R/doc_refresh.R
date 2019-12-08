#' @title Refreshes and updates existing documentation for a dataset
#' @name doc_refresh
#'
#' @description Update/refresh existing documentation that is outdated (maybe because dataset has been updated) or if you need to tidy up your existing documentation.
#' @param x path/directory to documentation or dataset (e.g., md/csv/txt file)
#'
#' @author Hause Lin
#' @usage doc_refresh(x)
#' @examples
#' \dontrun{doc_refresh("mcars.csv")}
#' @export
doc_refresh <- function(x) {
    message("Refreshing and updating docs...")
    # if x is a md file, change it to the extension of the original dataset (e.g., abc.md to abc.csv)
    x <- gsub(pattern = ".md", replacement = get_datasource_extension(x), x = x)
    doc_data(x, overwrite = TRUE)
}
