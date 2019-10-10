# sealR
 Repo for common functions from SEAL lab at NCSU

# How to add functions to this package
This how-to comes from https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/


First, it's helpful to be using the sealR.Rproj. Otherwise, you need to setwd().

```r
library(devtools)
library(roxygen2)
```

Create a new .R file like this and save in the "R" folder of this repo. The comment lines are the documentation, while the function is presented below.
```r
cat_function <- function(love=TRUE){
    if(love==TRUE){
        print("I love cats!")
    }
    else {
        print("I am not a cool person.")
    }
}
```
After saving, add the documentation lines like this.
```r
#' A Cat Function
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @examples
#' cat_function()
 
cat_function <- function(love=TRUE){
    if(love==TRUE){
        print("I love cats!")
    }
    else {
        print("I am not a cool person.")
    }
}
```

Then in the console, run the following. This will automatically save the documentation to the package

```r
library(dev_tools)
library(roxygen2)
document()
```

That's it! To install the new version of the package, use `install_github("mcgregorian1/sealR")
