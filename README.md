# docdata

docdata is an R package that generates documentation for datasets semi-automatically. It streamlines the process of documenting when/where/who etc. a dataset is from. It also standardizes documentation. Ultimately, every dataset (e.g., csv/txt file) with tabular data should have a corresponding documentation file that describes the rows and columns of that dataset and other information about the dataset. Ultimately, docdata aims to make data docmentation and sharing easier.


## Installation

To install the package, type the following commands into the R console:

```
# install.packages("devtools")
devtools::install_github("hauselin/docdata") # you might have to install devtools first (see above)
```

## How to use docdata?

Step 1: use `doc_data()` to generate a documentation (markdown file)

Step 2: use `disp_doc()` to view the doc

Step 3: use `doc_open()` to open the doc to edit it

Step 4: use `doc_refresh()` to refresh/update your documentation


