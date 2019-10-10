#' Mass download .shp files from URL
#'
#' The function allows you to download shapefile zip files into a temporary folder and directory, which are then unzipped and ready to use in R. Temp folders are automatically unlinked (deleted) and the working directory is set back to original within every iteration of the function. This means no shapefiles are stored to the drive.
#'
#' Source of function: Kay Cichini (https://www.r-bloggers.com/batch-downloading-zipped-shapefiles-with-r/)

#' @param URL URL containing download links of different .shp files
#' @keywords shapefile
#' @export
#' @examples
#' url_shp_to_spdf()

url_shp_to_spdf <- function(URL) {
  require(rgdal)
  wd <- getwd()
  td <- tempdir()
  setwd(td)
  temp <- tempfile(fileext = ".zip")
  download.file(URL, temp)
  unzip(temp)
  shp <- dir(tempdir(), "*.shp$")
  lyr <- sub(".shp$", "", shp)
  y <- lapply(X = lyr, FUN = function(x) readOGR(dsn=shp, layer=lyr))
  names(y) <- lyr
  unlink(dir(td))
  setwd(wd)
  return(y)
}
