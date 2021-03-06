#' Create a map
#'
#' Map a set of languages and color them by feature or two sets of features.
#'
#' @param languages character vector of languages (can be written in lower case)
#' @param latitude numeric vector of latitudes
#' @param longitude numeric vector of longitudes
#' @param features character vector of features
#' @param stroke.features additional independent stroke features
#' @param density.estimation additional independent features, used for density estimation
#' @param popup character vector of strings that will appear in pop-up window
#' @param label character vector of strings that will appear near points
#' @param minimap logical. If TRUE, function shows mini map. By default is FALSE.
#' @param tile a character verctor with a map tiles, popularized by Google Maps. See \href{https://leaflet-extras.github.io/leaflet-providers/preview/index.html}{here} for the complete set.
#' @param glottolog.source A character vector that define which glottolog database is used: "original" or "modified" (by default)
#' @param color vector of colors or palette. The color argument can be (1) a character vector of RGM or named colors; (2) the name of an RColorBrewer palette; (3) the full name of a viridis palette; (4) a function that receives a single value between 0 and 1 and returns a color. For more examples see \code{\link{colorNumeric}}
#' @param control logical. If TRUE, function show layer control buttons. By default is TRUE.
#' @param density.estimation.color vector of density polygons' colors
#' @param density.estimation.opacity a numeric vector of density polygons opacity.
#' @param density.latitude.width bandwidths for latitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param density.legend logical. If TRUE, function show legend for density features. By default is FALSE.
#' @param density.legend.opacity a numeric vector of density-legend opacity.
#' @param density.legend.position the position of the legend: "topright", "bottomright", "bottomleft","topleft"
#' @param density.longitude.width bandwidths for longitude values. Defaults to normal reference bandwidth (see \link{bandwidth.nrd}).
#' @param density.points logical. If FALSE, it doesn't show points in polygones.
#' @param density.title title of a density-feature legend
#' @param image.height numeric vector of image heights
#' @param image.url character vector of URLs with an images
#' @param image.width numeric vector of image widths
#' @param image.X.shift numeric vector of image's X axis shift relative to the latitude-longitude point
#' @param image.Y.shift numeric vector of image's Y axis shift relative to the latitude-longitude point
#' @param label.fsize numeric value of the label font size. By default is 14.
#' @param label.hide logical. If FALSE, labels are displayed allways. If TRUE, labels are displayed on mouse over. By default is TRUE.
#' @param label.position the position of labels: "left", "right", "top", "bottom"
#' @param legend logical. If TRUE, function show legend. By default is FALSE.
#' @param legend.opacity a numeric vector of legend opacity.
#' @param legend.position the position of the legend: "topright", "bottomright", "bottomleft","topleft"
#' @param map.orientation a character verctor with values "Pacific" and "Atlantic". It distinguishes Pacific-centered and Atlantic-centered maps. By default is "Pacific".
#' @param minimap.height The height of the minimap in pixels.
#' @param minimap.position the position of the minimap: "topright", "bottomright", "bottomleft","topleft"
#' @param minimap.width The width of the minimap in pixels.
#' @param opacity a numeric vector of marker opacity.
#' @param radius a numeric vector of radii for the circles.
#' @param scale.bar logical. If TRUE, function shows scale-bar. By default is TRUE.
#' @param scale.bar.position the position of the scale-bar: "topright", "bottomright", "bottomleft","topleft"
#' @param stroke.color vector of stroke colors
#' @param stroke.legend logical. If TRUE, function show stroke.legend. By default is FALSE.
#' @param stroke.legend.opacity a numeric vector of stroke.legend opacity.
#' @param stroke.legend.position the position of the stroke.legend: "topright", "bottomright", "bottomleft","topleft"
#' @param stroke.opacity a numeric vector of stroke opacity.
#' @param stroke.radius a numeric vector of stroke radii for the circles.
#' @param stroke.title title of a stroke-feature legend
#' @param tile.name a character verctor with a user's map tiles' names
#' @param title title of a legend
#' @param zoom.control logical. If TRUE, function shows zoom controls. By default is FALSE.
#' #' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' map.feature(c("Adyghe", "Russian"))
#'
#' ## Map all Slavic languages
#' map.feature(lang.aff(c("Slavic")))
#'
#' ## Color languages by feature
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
#' map.feature(df$lang, df$feature)
#' ## ... or add a control buttons for features
#' map.feature(df$lang, df$feature, control = TRUE)
#'
#' ## Adding pop-up
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup)
#'
#' ## Adding labels
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, label = df$lang)
#'
#' ## Add your own coordinates
#' map.feature("Adyghe", latitude = 43, longitude = 57)
#'
#' ## Change map tile
#' map.feature("Adyghe", tile = "Thunderforest.OpenCycleMap")
#'
#' ## Add you own colors
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup, color = c("green", "navy"))
#'
#' ## Map two sets of features
#' df <- data.frame(lang = c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
#' feature = c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
#' popup = c("Circassian", "Circassian", "Slavic", "Slavic", "Slavic"))
#' map.feature(df$lang, df$feature, df$popup,
#' stroke.features = df$popup)
#'
#' ## Add a pictures to plot
#' df <- data.frame(lang = c("Russian", "Russian"),
#' lat  = c(55.75, 59.95),
#' long = c(37.616667, 30.3),
#' urls = c("https://goo.gl/5OUv1E", "https://goo.gl/UWmvDw"))
#' map.feature(languages = df$lang,
#' latitude = df$lat,
#' longitude = df$long,
#' image.url = df$urls)
#'
#' ## Add a minimap to plot
#' map.feature(c("Adyghe", "Russian"), minimap = TRUE)
#'
#' ## Remove scale bar
#' map.feature(c("Adyghe", "Russian"), scale.bar = FALSE)
#'
#'
#' @export
#' @importFrom leaflet colorNumeric
#' @importFrom leaflet colorFactor
#' @importFrom leaflet leaflet
#' @importFrom leaflet addTiles
#' @importFrom leaflet addProviderTiles
#' @importFrom leaflet addPolygons
#' @importFrom leaflet addCircleMarkers
#' @importFrom leaflet addMarkers
#' @importFrom leaflet addLayersControl
#' @importFrom leaflet addScaleBar
#' @importFrom leaflet addLegend
#' @importFrom leaflet addMiniMap
#' @importFrom leaflet leafletOptions
#' @importFrom leaflet labelOptions
#' @importFrom leaflet layersControlOptions
#' @importFrom leaflet icons
#' @importFrom stats complete.cases
#' @importFrom grDevices gray
#' @importFrom grDevices topo.colors
#' @importFrom rowr cbind.fill
#' @importFrom magrittr %>%
#'

map.feature <- function(languages,
                        features = "",
                        popup = "",
                        label = "",
                        latitude = NULL,
                        longitude = NULL,
                        label.hide = TRUE,
                        label.fsize = 14,
                        label.position = "right",
                        stroke.features = NULL,
                        density.estimation = NULL,
                        density.estimation.color = NULL,
                        density.estimation.opacity = 0.6,
                        density.points = TRUE,
                        density.longitude.width = NULL,
                        density.latitude.width = NULL,
                        density.legend = TRUE,
                        density.legend.opacity = 1,
                        density.legend.position = "bottomleft",
                        density.title = "",
                        color = NULL,
                        stroke.color = NULL,
                        image.url = NULL,
                        image.width = 100,
                        image.height = 100,
                        image.X.shift = 0,
                        image.Y.shift = 0,
                        title = NULL,
                        stroke.title = NULL,
                        control = FALSE,
                        legend = TRUE,
                        legend.opacity = 1,
                        legend.position = "topright",
                        stroke.legend = TRUE,
                        stroke.legend.opacity = 1,
                        stroke.legend.position = "bottomleft",
                        radius = 5,
                        stroke.radius = 9.5,
                        opacity = 1,
                        stroke.opacity = 1,
                        scale.bar = TRUE,
                        scale.bar.position = "bottomleft",
                        minimap = FALSE,
                        minimap.position = "bottomright",
                        minimap.width = 150,
                        minimap.height = 150,
                        tile = "OpenStreetMap.Mapnik",
                        tile.name = NULL,
                        zoom.control = FALSE,
                        map.orientation = "Pacific",
                        glottolog.source = "modified"){

  ifelse(grepl(glottolog.source, "original"),
         glottolog <- lingtypology::glottolog.original,
         glottolog <- lingtypology::glottolog.modified)
  if(typeof(languages) == "list"){languages <- unlist(languages)}
  if(sum(is.glottolog(languages,
                      response = TRUE,
                      glottolog.source = glottolog.source)) == 0){
    stop("There is no data to map")
  }

  # create dataframe ---------------------------------------------------------
  mapfeat.df <- data.frame(languages, features,
                           popup = popup)
  if(sum(label == "") != length(label)){
    mapfeat.df$label <- as.character(label)
  }

  if(!is.null(density.estimation)){
    mapfeat.df$density.estimation <- density.estimation
  }

  # if there are no latitude and longitude

  if (is.null(latitude) & is.null(longitude)) {
    mapfeat.df$long <- long.lang(languages,
                                 map.orientation = map.orientation,
                                 glottolog.source = glottolog.source)
    mapfeat.df$lat <- lat.lang(languages, glottolog.source = glottolog.source)
  } else {   # if there are latitude and longitude
    mapfeat.df$long <- longitude
    mapfeat.df$lat <- latitude
  }

  # if there are no coordinates... ------------------------------------------
  if(sum(is.na(mapfeat.df$long&mapfeat.df$lat))> 0){
    warning(paste("There is no coordinates for languages",
                  paste(
                    mapfeat.df$languages[is.na(mapfeat.df$long&mapfeat.df$lat)],
                    collapse = ", ")),
            call. = FALSE)
  }

  # remove any rows with NAs ------------------------------------------------
  mapfeat.df <- mapfeat.df[stats::complete.cases(mapfeat.df),]

  # create link --------------------------------------------------------------
  mapfeat.df$link <- url.lang(as.character(mapfeat.df$languages),
                              popup = mapfeat.df$popup,
                              glottolog.source = glottolog.source)

  # add images --------------------------------------------------------------
  if(!is.null(image.url)){
    mapfeat.image <- rowr::cbind.fill(mapfeat.df[,-2], data.frame(image.url))
    mapfeat.image <- mapfeat.image[stats::complete.cases(mapfeat.image),]
  }

  # create a stroke dataframe -----------------------------------------------
  if(!is.null(stroke.features)){
    mapfeat.stroke <- rowr::cbind.fill(mapfeat.df[,-2],
                                       data.frame(stroke.features))
    mapfeat.stroke <- mapfeat.stroke[stats::complete.cases(mapfeat.stroke),]
  }

  # change feature names ----------------------------------------------------
  # levels(mapfeat.df$features) <- paste(names(table(mapfeat.df$features)), " (", table(mapfeat.df$features), ")", sep = "")

  # create a palette ---------------------------------------------------------
  my_colors <- grDevices::colors()[!grepl("ivory|azure|white|gray|grey|black|pink|1", grDevices::colors())]
  if (is.null(color)) {
    if(is.numeric(mapfeat.df$features)){
      pal <- leaflet::colorNumeric(palette = "BuPu", domain=mapfeat.df$features)
    } else {set.seed(45)
      pal <- leaflet::colorFactor(
      sample(my_colors, length(unique(mapfeat.df$features))),
      domain = mapfeat.df$features)
    }} else {
      if(is.numeric(mapfeat.df$features)){
        pal <- leaflet::colorNumeric(palette = color,domain=mapfeat.df$features)
      }else {
        if(length(mapfeat.df$features) == length(color)){
           df <- unique(data.frame(feature = mapfeat.df$features, color))
           color <- as.character(df[order(df$feature),]$color)
           }
        pal <- leaflet::colorFactor(color, domain = mapfeat.df$features)
      }
    }

    if (is.null(density.estimation.color)) {
    if(is.numeric(mapfeat.df$density.estimation)){
      density.estimation.pal <- leaflet::colorNumeric(palette = "BuPu", domain=mapfeat.df$density.estimation)
    } else {
      set.seed(45)
      density.estimation.pal <- leaflet::colorFactor(
      sample(my_colors, length(unique(mapfeat.df$density.estimation)),
             length(unique(mapfeat.df$density.estimation))),
      domain = mapfeat.df$density.estimation)
    }} else {
        if(length(mapfeat.df$density.estimation) == length(density.estimation.color)){
          df <- unique(data.frame(feature = mapfeat.df$density.estimation, color = density.estimation.color))
          density.estimation.color <- as.character(df[order(df$feature),]$color)
          }
        density.estimation.pal <- leaflet::colorFactor(unique(density.estimation.color), domain = mapfeat.df$density.estimation)
    }

  if(!is.null(stroke.features)){
    if (is.null(stroke.color)) {
      lev <- nlevels(as.factor(
        stroke.features[stats::complete.cases(stroke.features)]))
      strokecolors <- grDevices::gray(lev :0 / lev)
      stroke.pal <- leaflet::colorFactor(strokecolors,
                                        domain = mapfeat.stroke$stroke.features)
      rev.stroke.pal <- leaflet::colorFactor(rev(strokecolors),
                                        domain = mapfeat.stroke$stroke.features)
    } else {
      stroke.pal <- leaflet::colorFactor(stroke.color,
                                        domain = mapfeat.stroke$stroke.features)
      rev.stroke.pal <- leaflet::colorFactor(rev(stroke.color),
                                        domain = mapfeat.stroke$stroke.features)
    }
  }

  # change tile names if needed ---------------------------------------------
  ifelse(is.null(tile.name), tile.name <- tile, NA)
  if(length(tile.name) != length(tile)){
    tile.name <- tile
    ifelse(length(tile.name) > length(tile),
           warning('number of tiles (tile argument) is less than number of tile names (tile.name argument)', call. = FALSE),
           warning('number of tile names (tile.name argument) is less than number of tiles (tile argument)', call. = FALSE))
  }

  # create a density polygones --------------------------------------------
  if(!is.null(density.estimation)){
    my_poly_names <- names(which(table(mapfeat.df$density.estimation) > 1))
    my_poly <- lapply(my_poly_names, function(feature){
      polygon.points(mapfeat.df[mapfeat.df$density.estimation == feature, 'lat'],
                     mapfeat.df[mapfeat.df$density.estimation == feature, 'long'],
                     latitude_width = density.latitude.width,
                     longitude_width = density.longitude.width)
  })
  }

  ### create a map ------------------------------------------------------------
  m <- leaflet::leaflet(mapfeat.df, option=leaflet::leafletOptions(
    zoomControl = zoom.control)) %>%
    leaflet::addTiles(tile[1]) %>%
    leaflet::addProviderTiles(tile[1], group = tile.name[1])
  if(length(tile) > 1){
    mapply(function(other.tiles, other.tile.names){
      m <<- m %>% leaflet::addProviderTiles(other.tiles,
                                            group = other.tile.names)
    }, tile[-1], tile.name[-1])
  }

  # if there is density estimation ------------------------------------------
  if(!is.null(density.estimation)){
    lapply(seq_along(my_poly), function(x){
      m <<- m %>% leaflet::addPolygons(data = my_poly[[x]],
                                       color = density.estimation.pal(my_poly_names[x]),
                                       opacity = 0.2,
                                       fillOpacity=density.estimation.opacity)})
  }

    # map: if there are stroke features ---------------------------------------
  if(!is.null(stroke.features)){
    m <- m %>% leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                                         lat=mapfeat.stroke$lat,
                                         popup= mapfeat.stroke$link,
                                         stroke = FALSE,
                                         radius = stroke.radius*1.15,
                                         fillOpacity = stroke.opacity,
                                         color = "black") %>%
leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                  lat=mapfeat.stroke$lat,
                  popup= mapfeat.stroke$link,
                  stroke = FALSE,
                  radius = stroke.radius,
                  fillOpacity = stroke.opacity,
                  color=stroke.pal(mapfeat.stroke$stroke.features),
                  group = mapfeat.stroke$stroke.features) %>%
leaflet::addCircleMarkers(lng=mapfeat.stroke$long,
                    lat=mapfeat.stroke$lat,
                    popup= mapfeat.df$link,
                    label= mapfeat.df$label,
                    labelOptions = leaflet::labelOptions(noHide = !(label.hide),
                        direction = label.position,
                        textOnly = TRUE,
                        style = list("font-size" = paste0(label.fsize, "px"))),
                    stroke = FALSE,
                    radius = 1.15*radius,
                    fillOpacity = opacity,
                    color = rev.stroke.pal(mapfeat.stroke$stroke.features),
                    group = mapfeat.stroke$stroke.features)}

    # map: add points ----------------------------------------
    if(density.points != FALSE){
      m <- m %>% leaflet::addCircleMarkers(lng=mapfeat.df$long,
                                         lat=mapfeat.df$lat,
                                         popup= mapfeat.df$link,
                                         stroke = FALSE,
                                         radius = radius*1.1,
                                         fillOpacity = opacity,
                                         color = "black") %>%
      leaflet::addCircleMarkers(lng=mapfeat.df$long,
  lat=mapfeat.df$lat,
  popup= mapfeat.df$link,
  label= mapfeat.df$label,
  labelOptions = leaflet::labelOptions(noHide = !(label.hide),
                         direction = label.position,
                         textOnly = TRUE,
                         style = list("font-size" = paste0(label.fsize, "px"))),
  stroke = FALSE,
  radius = radius,
  fillOpacity = opacity,
  color = pal(mapfeat.df$features),
  group = mapfeat.df$features)
  }

  # map: images -------------------------------------------------------------
  if (!is.null(image.url)) {
    m <- m %>% leaflet::addMarkers(lng=mapfeat.image$long,
                             lat=mapfeat.image$lat,
                             popup= mapfeat.image$link,
                             icon = leaflet::icons(
                               iconUrl = as.character(mapfeat.image$image.url),
                               iconWidth = image.width,
                               iconHeight = image.height,
                               iconAnchorX = - image.X.shift,
                               iconAnchorY = image.Y.shift))
  }

  # map: tile and control interaction --------------------------------------
  if(length(tile) > 1){
    if (control == TRUE) {
      m <- m %>% leaflet::addLayersControl(
        baseGroups = tile.name,
        overlayGroups = mapfeat.df$features,
        options = leaflet::layersControlOptions(collapsed = FALSE))
    } else {
      m <- m %>% leaflet::addLayersControl(
        baseGroups = tile.name,
        options = leaflet::layersControlOptions(collapsed = FALSE))
    }
  } else {
    if (control == TRUE) {
      m <- m %>% leaflet::addLayersControl(overlayGroups = mapfeat.df$features,
                     options = leaflet::layersControlOptions(collapsed = FALSE))
    }
  }

  # map: ScaleBar -----------------------------------------------------------
  if (scale.bar == TRUE) {
    m <- m %>% leaflet::addScaleBar(
      position = scale.bar.position)
  }


  # map: legend -------------------------------------------------------------
  if (sum(mapfeat.df$features == "") < length(mapfeat.df$features) &
      legend == TRUE) {
    m <- m %>% leaflet::addLegend(title = title,
                                  position = legend.position,
                                  pal = pal,
                                  values = mapfeat.df$features,
                                  opacity = legend.opacity)
  }

  # map: stroke.legend ------------------------------------------------------
  if (!is.null(stroke.features) & stroke.legend == TRUE) {
    m <- m %>% leaflet::addLegend(title = stroke.title,
                                  position = stroke.legend.position,
                                  pal = stroke.pal,
                                  values = mapfeat.stroke$stroke.features,
                                  opacity = stroke.legend.opacity)
  }

  # map: density.legend ------------------------------------------------------
  if (!is.null(density.estimation) & density.legend == TRUE) {
    m <- m %>% leaflet::addLegend(title = density.title,
                                  position = density.legend.position,
                                  pal = density.estimation.pal,
                                  values = mapfeat.df$density.estimation,
                                  opacity = density.legend.opacity)
  }

  # map: MiniMap ------------------------------------------------------------
  if (minimap == TRUE) {
    m <- m %>% leaflet::addMiniMap(
      position = minimap.position,
      width = minimap.width,
      height = minimap.height,
      toggleDisplay = TRUE
    )
  }
  m
}
