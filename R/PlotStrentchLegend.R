#' plot raster images with a nice stretch and legend
PlotStretchLegend <- function(r, pal, digits = 0, ...) {
  qs <- quantile(r, c(0, 0.02, 0.98, 1))
  r_breaks <- c(qs[1], seq(qs[2], qs[3], len = 255), qs[4])
  plot(r, col = pal(length(r_breaks) - 1), breaks = r_breaks, xaxt = "n", yaxt = "n", legend = F, ...)
  # add a reasonable legend
  legend_at <- round(seq(r_breaks[2], r_breaks[length(r_breaks) - 1], len = 7), digits)
  legend_labels <- c(paste("<", legend_at[1]),
                     as.character(legend_at[2:(length(legend_at) - 1)]),
                     paste(">", legend_at[length(legend_at)]))
  plot(raster(matrix(legend_at)), legend.only = T, col = pal(length(r_breaks) - 1),
       axis.args = list(at = legend_at, labels = legend_labels))
}
