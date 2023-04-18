#' Create a directory structure for pooled or unpooled data
#'
#' This function creates a directory structure for pooled or unpooled data
#' and optionally copies the contents from Hobbes Original into the equated subdirectory.
#'
#' @param pooled logical; if TRUE, create a pooled directory with subdirectories for data, keys, item analysis, unequated and equated. If FALSE, create an unpooled directory with subdirectories for item analysis, unequated and equated.
#' @param copy_hobbes logical; if TRUE, copy the files from Hobbes Original into the equated subdirectory of the pooled or unpooled directory. If FALSE, do not copy the files.
#' @return (as side effect) a list of directory paths (paths_list) assigned to global environment
#' @export
#'
#' @examples
#' path_struc(pooled = TRUE, copy_hobbes = TRUE)# creates a pooled folder structure and copies files from Hobbes Original
#' path_struc(pooled = FALSE, copy_hobbes = FALSE) # creates an unpooled folder structure and does not copy files from Hobbes Original
#'
#'
#' @importFrom fs path_wd dir_create path
#' @importFrom rlang list2

path_struc <- function(pooled = TRUE, copy_hobbes = TRUE){
  WD = fs::path_wd()
  pl = ifelse(test = pooled, yes = "pooled", no = "unpooled")

  if (pooled == TRUE){
    WDP = fs::path_wd("pooled")
    sub_paths <- rlang::list2(
      d = "data",
      k = "keys",
      ia = "item analysis",
      u = "unequated",
      e = "equated")
    fs::dir_create(WDP,sub_paths)
    x <- fs::path(WDP, sub_paths) %>% as.list

  }else{
    WDU = fs::path_wd("unpooled")
    sub_paths <- rlang::list2(
      ia = "item analysis",
      u = "unequated",
      e = "equated")
    fs::dir_create(WDU,sub_paths)
    x <- fs::path(WDU, sub_paths) %>% as.list
  }
  names(x) <- sub_paths
  paths_list <<- x
  if (copy_hobbes == TRUE){
    hobbesfiles = fs::dir_ls("Hobbes Original",type = "file")
    eq_files = hobbesfiles %>%
      stringr::str_replace_all(., "Hobbes Original",
                               replacement = glue::glue("{pl}/equated"))
    fs::file_copy(path = hobbesfiles,
                  new_path = eq_files,
                  overwrite = FALSE)
    fs::dir_copy(path = "Hobbes Original/_Survey",
                 new_path = glue::glue("{pl}/equated"),overwrite = FALSE)
    message(
      glue::glue('Contents from Hobbes Original have been copied into the {pl}/equated directory.
                 This function does not overwrite any files that may be in {pl}/equated.')
    )
  }else{
    message(
      glue::glue('Hobbes Original contents has not been copied into the {pl}/equated directory.')
    )
  }
}
