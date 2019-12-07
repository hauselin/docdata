#' @title doc_data function
#' @name doc_data
#'
#' @description Generates documentation for a dataset
#' @param x path/directory to dataset
#' @param overwrite whether to overwrite documentation (defaults to FALSE)
#'
#' @author Hause Lin
#' @usage doc_data(x, overwrite = FALSE)
#'
#' @import data.table
#' @import stringi
#' @examples
#' \donttest{
#' doc_data("mtcars.csv")
#' }
#' @export
#'
doc_data <- function(x, overwrite = FALSE) {

    # generate doc md outpule file
    outfile <- generate_md_string(x)

    if (!overwrite) {
        if (file.exists(outfile)) {
            stop("Doc already exists! Use doc_open instead.")
        }
    }

    # read template md doc
    # template_doc <- read_doc_md("./inst/extdata/template.md")
    if (overwrite) {
        existing_doc <- read_doc_md(outfile)
    }

    # get filename
    idx <- gregexpr(pattern = .Platform$file.sep, text = x, fixed = TRUE)[[1]]
    if (idx[1] != -1) {
        idx <- idx[[length(idx)]]
        filename <- substring(text = x, first = idx + 1)
    }

    # read data
    temp_dat <- data.table::fread(x)
    c <- ncol(temp_dat)
    r <- nrow(temp_dat)

    # overwrite template doc with dataset info
    for (i in 1:length(template_doc)) {
        template_doc[i] <- gsub(pattern = "@time@", replacement = Sys.time(), x = template_doc[i])
        template_doc[i] <- gsub(pattern = "@filename@", replacement = filename, x = template_doc[i])
        template_doc[i] <- gsub(pattern = "@rows@", replacement = r, x = template_doc[i])
        template_doc[i] <- gsub(pattern = "@columns@", replacement = c, x = template_doc[i])
    }

    if (overwrite) {
        idx_start <- grep(pattern = "## Data source", x = template_doc, fixed = TRUE) # beginning of table
        idx_end <- grep(pattern = "## Columns", x = template_doc, fixed = TRUE) # beginning of table
        part1 <- template_doc[1:(idx_start-1)]
        part2 <- template_doc[idx_end:(length(template_doc))]

        idx_start <- grep(pattern = "## Data source", x = existing_doc, fixed = TRUE) # beginning of table
        idx_end <- grep(pattern = "## Columns", x = existing_doc, fixed = TRUE) # beginning of table
        existing <- existing_doc[idx_start:(idx_end-1)]
        template_doc <- c(part1, existing, part2)
    }

    # convert data desc to md table
    col_types <- data.table::data.table(Column = names(temp_dat), Type = apply(temp_dat, 2, class), Description = "")
    md_table <- dat2string(col_types)
    if (overwrite) {
        idx <- grep(pattern = "| ", x = existing_doc, fixed = TRUE) # beginning of table
        c1 <- data.frame(string2dat(existing_doc[idx]))
        c2 <- col_types
        i <- 1
        for (i in 1:nrow(c2)) {  # replace empty descriptions with existing descriptions
            temp_c1 <- gsub(" ", "", c1$Column[i])
            if (temp_c1 %in% gsub(" ", "", c2$Column)) {
                temp_c2_idx <- which(gsub(" ", "", c2$Column) == temp_c1)
                c2[temp_c2_idx, "Description"] <- c1[i, "Description"]
            }
        }
        md_table <- dat2string(c2)
    }

    idx <- grep(pattern = "| Column", x = template_doc, fixed = TRUE) # beginning of table
    mdpart1 <- template_doc[1:(idx-1)]
    mdpart2 <- template_doc[(idx+2):length(template_doc)]
    new_doc <- c(mdpart1, md_table, mdpart2) # insert md table

    # save md doc
    f <- file(outfile)
    writeLines(new_doc, f)
    close(f)

    # open md doc in R console
    doc_open(outfile)
}
