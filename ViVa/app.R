AppDir <- system.file("shiny-app", package = "r1001genomes")
if (AppDir == "") {
  stop("Could not find example directory. Try re-installing `mypackage`.",
       call. = FALSE)
}

shiny::shinyAppDir(AppDir)
