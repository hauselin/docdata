disp_doc <- function(x) {
    if (!is.character(x)) { # if non-char provided, ask to specify path
        cat("You've provided a variable in your workspace.")
        x <- readline("Specify location of this dataset: ")
        x <- gsub(pattern = "'", replacement = "", x = x)  # remove ' if user provided them
        x <- gsub(pattern = "\"", replacement = "", x = x)  # remove " if user provided them
    }

    if (!file.exists(x)) { # if file doesn't exist, run doc_data() to generate file
        stop("File doesn't exist. Respecify path.")
    }

    markdown <- generate_md_string(x)

    if (!file.exists(markdown)) { # if markdown doc doesn't exist, run doc_data() to generate file
        doc_data(x)
    }

    display_doc_md(markdown)
}
