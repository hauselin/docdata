# refresh (but not update columns)
# add new columns, remove non-existing ones, rearrange them

doc_refresh <- function(file) {
    message("Refreshing and updating docs...")
    doc_data(file, overwrite = TRUE)
}