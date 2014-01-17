################ Getting US states, including Alaska and Hawaii, for the Choropleth
###  The procedure for this is laid out by Kristopher Kapphahn: http://loloflargenumbers.com/blog/#.Up5D6sSkpS4. The code is completely from his site. 
library(maptools)
library(mapproj)
centerState <- function(.df) {
  .df$x <- .df$x - (diff(range(.df$x, na.rm = T))/2 + min(.df$x, na.rm = T))
  .df$y <- .df$y - (diff(range(.df$y, na.rm = T))/2 + min(.df$y, na.rm = T))
  return(.df)
}
scaleState <- function(.df, scale_matrix, scale_factor, x_shift, y_shift) {
  .df <- centerState(.df)
  coords <- t(cbind(.df$x, .df$y))
  scaled_coord <- t(scale_factor*scale_matrix %*% coords)
  .df$x <- scaled_coord[,1] + x_shift
  .df$y <- scaled_coord[,2] + y_shift
  return(.df)
}
us50_shp <- readShapePoly("states.shp")
us50_df <- as.data.frame(us50_shp)

us50_points <- sp2tmap(us50_shp)
names(us50_points) <- c("id", "x", "y")
us50 <- merge(x = us50_df, y = us50_points, by.x = "DRAWSEQ", by.y = "id")

cont_us <- us50[us50$STATE_ABBR != "HI" & us50$STATE_ABBR != "AK", ]
ak <- us50[us50$STATE_ABBR == "AK", ]
hi <- us50[us50$STATE_ABBR == "HI", ]

scale_mat <- matrix(c(1,0,0,1.25), ncol = 2, byrow = T)
ak_scale <- scaleState(ak, scale_mat, 0.4, x_shift = -120, y_shift = 25)
hi_scale <- scaleState(hi, scale_mat, 1.5, x_shift = -107, y_shift = 25)

all_us <- rbind(cont_us, ak_scale, hi_scale)
proj_type <- "azequalarea"
projected <- mapproject(x = all_us$x, y = all_us$y, projection=proj_type)
all_us$x_proj <- projected[["x"]]
all_us$y_proj <- projected[["y"]]
save(all_us,file="all_us.rda")
################################################################################################