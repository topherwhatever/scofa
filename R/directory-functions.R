#' Create a directory structure for pooled or unpooled data
#'
#' This function creates a directory structure for pooled or unpooled data
#' and optionally copies the contents from Hobbes Original into the equated subdirectory.
#'
#' @param exam_info = list generated from scofa::info_exam0();checks cohort n. create a pooled directory with subdirectories for data (scored responses, raw data, and keys) , item analysis, unequated and equated. If FALSE, create an unpooled directory with subdirectories for item analysis, unequated and equated.
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

path_struc <- function(exam_info = NULL, copy_hobbes = TRUE){
if(is.null(exam_info)){
  warning("use info_exam0() to determine initial N for pooling determination")
}else{
  lst2global(exam_info)
}
  cohort_n = 27
  # Set the working directory path
  WD = fs::path_wd()

  # Determine the folder name ('pooled' or 'unpooled') based on the 'pooled' argument
  pl = ifelse(cohort_n <30, yes = "pooled", no = "unpooled")

  # If 'pooled' is TRUE
  if (pooled == TRUE){

    # Set the path for the 'pooled' directory
    WDP = fs::path_wd("pooled")

    # Define a list of subdirectories for the 'pooled' directory
    sub_paths <- rlang::list2(
      d = "data",
      ia = "item analysis",
      u = "unequated",
      e = "equated")

    # Create the 'pooled' directory and its subdirectories
    fs::dir_create(WDP,sub_paths)

    # Create a list of full paths for each subdirectory
    x <- fs::path(WDP, sub_paths) %>% as.list

    # If 'pooled' is FALSE
  }else{

    # Set the path for the 'unpooled' directory
    WDU = fs::path_wd("unpooled")

    # Define a list of subdirectories for the 'unpooled' directory
    sub_paths <- rlang::list2(
      ia = "item analysis",
      u = "unequated",
      e = "equated")

    # Create the 'unpooled' directory and its subdirectories
    fs::dir_create(WDU,sub_paths)

    # Create a list of full paths for each subdirectory
    x <- fs::path(WDU, sub_paths) %>% as.list
  }

  # Assign the names of the subdirectories to the list of full paths
  names(x) <- sub_paths

  # Assign the list of full paths to a global variable called 'paths_list'
  paths_list <<- x

  # If 'copy_hobbes' is TRUE
  if (copy_hobbes == TRUE){

    # List all the files in the 'Hobbes Original' directory
    hobbesfiles = fs::dir_ls("Hobbes Original",type = "file")

    # Replace 'Hobbes Original' with the folder name ('pooled' or 'unpooled') in the file paths
    eq_files = hobbesfiles %>%
      stringr::str_replace_all(., "Hobbes Original",
                               replacement = glue::glue("{pl}/equated"))

    # Copy the files from the 'Hobbes Original' directory to the new folder
    fs::file_copy(path = hobbesfiles,
                  new_path = eq_files,
                  overwrite = FALSE)

    # Copy the '_Survey' folder from the 'Hobbes Original' directory to the new folder
    fs::dir_copy(path = "Hobbes Original/_Survey",
                 new_path = glue::glue("{pl}/equated"),overwrite = FALSE)

    # Print a message indicating the files have been copied
    message(
      glue::glue('Contents from Hobbes Original have been copied into the {pl}/equated directory.
                 This function does not overwrite any files that may be in {pl}/equated.')
    )
  }else{
    # Print a message indicating the files have been copied
    message(
      glue::glue('Hobbes Original contents has not been copied into the {pl}/equated directory.')
    )
  }
}
