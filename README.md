
<!-- README.md is generated from README.Rmd. Please edit that file -->

# docdata

docdata is an R package that generates documentation for datasets
semi-automatically. It streamlines the process of documenting
when/where/who etc. a dataset is from. It also standardizes
documentation. Ultimately, every dataset (e.g., csv/txt file) with
tabular data should have a corresponding documentation file that
describes the rows and columns of that dataset and other information
about the dataset. Ultimately, docdata aims to make data docmentation
and sharing easier.

## Installation

To install the package, type the following commands into the R console:

``` r
# install.packages("devtools")
devtools::install_github("hauselin/docdata") # you might have to install devtools first (see above)
```

## How to use docdata?

**Step 1: use `doc_data()` to generate a documentation (markdown file)**

  - Example: `doc_data(mtcars.csv)` (assuming `mtcars.csv` is a dataset
    in your working directory.)

**Step 2: use `disp_doc()` to print the doc in your console**

  - Example: `disp_doc(mtcars.csv)` or `disp_doc(mtcars.md)`

**Step 3: use `doc_open()` to open the doc to edit it**

  - Example: `doc_open(mtcars.csv)` or `doc_open(mtcars.md)`

**Step 4: use `doc_refresh()` to refresh/update your documentation**

  - Example: `doc_refresh(mtcars.csv)` or `doc_refresh(mtcars.md)`

**Step 5: share your dataset and documentation file with others or your
future self(\!)**

### Step 1: `doc_data()`

`doc_data()` generates a markdown file that looks like the one shown
below. If you dataset is `mtcars.csv`, the markdown file will be named
`mtcars.md` and will be located in the same directory as `mtcars.csv`.

Example usage: `doc_data(mtcars.csv)` (assuming `mtcars.csv` is a
dataset in your working directory.)

    A GitHub flavored Markdown textfile documenting a dataset.
    
    Generated using docdata package on 2019-12-08 12:50:50.
    To cite this package, type citations("docdata") in console.
    
    ## Data source
    
    mtcars.csv
    
    ## About this file
    
    * What (is the data): 
    * Who (generated this documentation): 
    * Who (collected the data):
    * When (was the data collected): 
    * Where (was the data collected):
    * How (was the data collected):
    * Why (was the data collected): 
    
    ## Additional information
    
    * Contact: XXX@XXX.com
    * Registration: https://osf.io
    
    ## Columns
    
    * Rows: 32
    * Columns: 11
    
    | Column  | Type     | Description |
    | ------- | -------- | ----------- |
    | mpg     | numeric  |             |
    | cyl     | numeric  |             |
    | disp    | numeric  |             |
    | hp      | numeric  |             |
    
    End of documentation.

### Step 2: `disp_doc()`

`disp_doc()` prints the documentation in your console. An example
(truncated) output is shown below.

Example usage: `disp_doc(mtcars.csv)` or `disp_doc(mtcars.md)`

    --- DOCUMENTATION BEGIN ---
        1     A GitHub flavored Markdown textfile documenting a dataset.
        2     
        3     Generated using docdata package on 2019-12-08 12:50:50.
        4     To cite this package, type citations("docdata") in console.
        5     
        6     ## Data source
        7     
        8     mtcars.csv
        9     
       10     ## About this file
       ...
    --- DOCUMENTATION END ---

### Step 3: `doc_open()`

`doc_open()` opens the documentation in R or RStudio so you can edit it
and fill in the details.

Example usage: `doc_open(mtcars.csv)` or `doc_open(mtcars.md)`

### Step 4: `doc_refresh()`

If your documentation looks messy after you’ve edited it (especially if
the description column isn’t aligned), run `doc_refresh()` to clean it
up. Or if the columns/rows of your dataset have changed since the last
time the documentation was generated, run this function again to update
your documentation, which merges your previous documentation with a
refreshed/updated one.

Example usage: `doc_refresh(mtcars.csv)` or `doc_refresh(mtcars.md)`

### Step 5: Share your dataset + documentation
