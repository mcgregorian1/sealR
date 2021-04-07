#' Download Sentinel 2 dataset from google cloud.
#'
#' This function downloads all Sentinel 2 images (L1C or L2A) from Google's repository. These images
#' are the same as if you downloaded these from ESA Copernicus, but faster (i.e. you don't have to 
#' request images and wait for them). Note that Google does not do their own L2A conversion - all L2A images
#' are supplied directly from Copernicus (true as of April 2021).
#'
#' Running this function requires Google Cloud Storage SDK, which you can download and install 
#' from https://cloud.google.com/sdk/docs/install. For your first time attempting to run the function
#' you will need to open a python script and run `gcloud auth login`, which will take you to log in to your
#' google account.
#'
#' NOTE this function can NOT be run in RStudio because RStudio does not recognize `gsutil`. You need to use
#' a different code editor, whether that's R terminal or VSCode.
#' 
#' If you need help figuring out whether your regex is correct, see http://www.goring.org/resources/tutorial.html.
#' Note if you do use something like regex101.com that in R, a double slash = a single slash, even though this isn't true for other languages.
#'
#' If you want to figure out which tiles you need, check out this site for polygon shapefiles of the S2 tiles: https://github.com/justinelliotmeyers/Sentinel-2-Shapefile-Index.
#' Using this you can easily filter to the ones you need using `raster::intersect()` or something.
#'
#' Once the function has started, press ctrl+c in the command line can stop it.
#'
#' If there's any bug, please let me know.
#'
#' Author: Jacory (Xiaojie Gao), description updated by Ian McGregor
#'
#' @param tilename what tile do you want to download
#' @param folder local folder used to store downloaded files
#' @param L2Flag indicate to download L2A product or L1C product (default)
#' @param regExp regular expression, with which you can speicify which files you want. For example,
#' regExp <- "S2\\D_MSIL\\d\\D_201([6]|[8][0][0-9]).*.SAFE/$" means you want data from 2016 and before 2018 before October.
#' @keywords sentinel
#' @export
#' @examples
#' DownloadSentinel2("17SNA", "D:/", L2Flag = TRUE, rexExp = "S2\\D_MSIL\\d\\D_201([6]|[8][0][0-9]).*.SAFE/$")
#'
#' # What if I want all L1C images from 2015 through to 2020-01-31? It will look like this:
#' DownloadSentinel2("17SNA", "D:/",  L2Flag = FALSE, regExp = "S2\\D_MSIL\\d\\D_20([1][5-9]|[2][0][0][1]).*.SAFE/$")
DownloadSentinel2 <- function(tilename, folder, L2Flag = FALSE, regExp = NULL) {
    gcUrl <- ifelse(L2Flag == TRUE, file.path("gs://gcp-public-data-sentinel-2/L2/tiles", substr(tilename, 1, 2),
                                        substr(tilename, 3, 3), substr(tilename, 4, 5)),
                                    file.path("gs://gcp-public-data-sentinel-2/tiles", substr(tilename, 1, 2),
                                        substr(tilename, 3, 3), substr(tilename, 4, 5)))
    com <- paste("gsutil ls", gcUrl)
    fileList <- system(com, intern = TRUE) # View(fileList)
    # create destination folder
    destDir <- folder
    if (dir.exists(file.path(destDir, tilename)) == FALSE) dir.create(file.path(destDir, tilename))

    # regular expression filter
    if (!is.null(regExp)) fileList <- grep(regExp, fileList, value = TRUE)

    # started downloading
    for (i in 1:length(fileList)) {
        temp <- unlist(strsplit(fileList[i], "/"))
        dirname <- temp[length(temp)]
        if (dir.exists(file.path(destDir, tilename, dirname)) == FALSE) {
            system(paste("gsutil -m cp -r", fileList[i], file.path(destDir, tilename, ".")))
        }
    }
}
