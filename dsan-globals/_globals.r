# For slides
library(ggplot2)
cbPalette <- c(
  "#E69F00", "#56B4E9", "#009E73", "#F0E442",
  "#0072B2", "#D55E00", "#CC79A7"
)
cb_palette <- cbPalette
options(ggplot2.discrete.colour = cbPalette)
options(ggplot2.discrete.fill = cbPalette)
get_base_size <- function(plot_type) {
  if (plot_type == "full") {
    custom_base_size <- 16
  } else if (plot_type == "half") {
    custom_base_size <- 22
  } else if (plot_type == "quarter") {
    custom_base_size <- 28
  } else {
    # plot_type == "col" # nolint: commented_code_linter.
    custom_base_size <- 22
  }
  return(custom_base_size)
}
# Theme generator, for given sizes
dsan_theme_settings <- theme(
  plot.title = element_text(hjust = 0.5),
  plot.subtitle = element_text(hjust = 0.5),
  legend.title = element_text(hjust = 0.5),
  legend.box.background = element_rect(colour = "black")
)
dsan_theme <- function(plot_type = "full", base_size = NA) {
  if (is.na(base_size)) {
    base_size <- get_base_size(plot_type)
  }
  custom_theme <- theme_classic(
    base_size = base_size
  ) + dsan_theme_settings
  return(custom_theme)
}
theme_dsan <- dsan_theme

# Minimal version
theme_dsan_min <- function(base_size = 22) {
  custom_theme_min <- theme_minimal(
    base_size = base_size
  ) + dsan_theme_settings + theme(
    panel.grid = element_blank()
  )
  return(custom_theme_min)
}

knitr::opts_chunk$set(fig.align = "center")
g_pointsize <- 5
g_linesize <- 1
# Technically it should always be linewidth
g_linewidth <- 1
g_textsize <- 14

remove_legend_title <- function() {
    return(theme(
        legend.title = element_blank(),
        legend.spacing.y = unit(0, "mm")
    ))
}

remove_legend <- function() {
  return(
    theme(
      legend.position = "none"
    )
  )
}

# Global functions
get_rss <- function(model) {
  return(sum(summary(model)$residuals^2))
}

fmt_decimal <- function(value) {
  return(sprintf("%0.10f", value))
}

# https://www.pmassicotte.com/posts/2022-08-15-removing-whitespace-around-figures-quarto/
knitr::knit_hooks$set(crop = knitr::hook_pdfcrop)