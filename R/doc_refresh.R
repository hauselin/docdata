#' @title Refreshes and updates existing documentation for a dataset
#' @name doc_refresh
#'
#' @description Update/refresh existing documentation that is outdated (maybe because dataset has been updated) or if you need to tidy up your existing documentation.
#' @param file path/directory to dataset (e.g., csv/txt file)
#'
#' @author Hause Lin
#' @usage doc_refresh(file)
#' @examples
#' \donttest{
#' doc_refresh("mtcars.csv")
#' }
#' @export
doc_refresh <- function(file) {
    message("Refreshing and updating docs...")
    doc_data(file, overwrite = TRUE)
}
