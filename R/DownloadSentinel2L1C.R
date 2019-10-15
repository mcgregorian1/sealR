#' Download Sentinel 2 L1C dataset from google cloud.
#'
#' This function requires Google Cloud Storage SDK, you can download and install this SDK
#' from google cloud website.
#' Use this carefully, cause once it started, it's not easy to stop.
#'
#' @param tilename what tile do you want to download
#' @keywords sentinel
#' @export
#' @examples
#' DownloadSentinel2L1C("17SNA")
DownloadSentinel2L1C <- function(tilename, folder=folder) {
  tileNum <- substr(tilename, 1, 2)
  I <- substr(tilename, 3, 3)
  J <- substr(tilename, 4, 5)
  command <- paste("gsutil -m cp -r ", "gs://gcp-public-data-sentinel-2/tiles/",
                   tileNum, "/", I, "/", J, " ", folder, "/.", sep = "")
  system(command)
}
