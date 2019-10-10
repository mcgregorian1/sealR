# sealR
 Repo for common functions from SEAL lab at NCSU

## Adding functions to this package
This how-to comes from https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/


First, it's helpful to be using the sealR.Rproj. Otherwise, you need to setwd("./sealR").

Use this code for an example.Let's say you love dogs so much, you don't want just one picture of a dog to cheer you up. You want 10 of them (if you want more, that's on you). This is real-world example.
```r
devtools::install_github("melissanjohnson/pupR")
```

Create a new .R file containing only the function and save in the "R" folder of this repo.
```r
doggo <- function(num){
    library(pupR)
    
    replicate(num, pupR())
}
```
Then add the documentation lines like this. You don't need to save.
```r
#' A Dog Function
#'
#' This function allows you to express your love of dogs.
#' @param num Do you love dogs? The number corresponds to how many dog pictures you would like to see to cheer you up.
#' @keywords dogs
#' @export
#' @examples
#' doggo()
 
doggo <- function(num){
    library(pupR)
    
    replicate(num, pupR())
}
```

Now in the console, run the following. This will automatically save and add the documentation to the package.
```r
library(dev_tools)
library(roxygen2)
document()
```

That's it! To install the new version of the package, use `install_github("mcgregorian1/sealR")`.
