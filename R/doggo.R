#' A Dog Function
#'
#' This function allows you to express your love of dogs. This is a wrapper for the pupR package from https://github.com/melissanjohnson/pupR
#' @param num Do you love dogs? The number corresponds to how many dog pictures you would like to see to cheer you up.
#' @keywords dogs
#' @export
#' @examples
#' doggo(10) #this gives you 10 dog pictures from pupR

doggo <- function(num){
  if(!require(pupR)){devtools::install_github("melissanjohnson/pupR"); library(pupR)}

  replicate(num, pupR())
}
