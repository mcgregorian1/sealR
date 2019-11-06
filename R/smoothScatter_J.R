#' do smoothScatter with a linear equation legend
#' Usage is the same with basic smoothScatter
smoothScatter_J <- function(x, y, nbin = 300, nrpoints = 0, ...) {
    require(RColorBrewer)
    pal <- colorRampPalette(c("white", "#f9f9fd", "#a3a6e1", rev(brewer.pal(11, "Spectral"))))
    smoothScatter(x, y, colramp = pal, nbin = nbin, nrpoints = nrpoints, ...)
    fit <- lm(y ~ x)
    abline(fit, col = "red")
    # === draw a 1:1 line ===
    sim <- data.frame(matrix(c(1:10, 1:10), ncol = 2, byrow = FALSE))
    names(sim) <- c("a", "b")
    abline(lm(a ~ b, data = sim), col = "black", lty = 2)
    cf <- round(coef(fit), 2)
    eq <- paste("y=", ifelse(sign(cf[2]) == 1, "", "-"), abs(cf[2]), "x",
                ifelse(sign(cf[1]) == 1, "+", "-"), abs(cf[1]), ", ", sep = "")
    val <- round(summary(fit)$r.squared, 2)
    legendLabel <- bquote(.(eq) ~ R ^ 2 == .(val))
    legend("bottomright", legend = legendLabel)
}
