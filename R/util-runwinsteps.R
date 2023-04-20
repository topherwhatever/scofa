#' Run Winsteps cmd file
#'
#' @param path Path to folder containing cmd file, defaults to the equated folder in the paths_list object. Encourage using {fs} package
#'
#' @return Prints the batch file command and returns a process identifier.
#' @export
#'
#' @examples
#' run_winsteps() # defaults to equated subdirectory in either pooled or unpooled directory
#' run_winsteps(path = fs::path_wd("Hobbes Original"))
run_winsteps <- function(path = paths_list[["equated"]]){
  p = path
  cmd =  fs::dir_ls(path = p, glob = "*RUN.cmd",
                    recurse = FALSE,type = "file",all = FALSE)
  processx::process$new("cmd.exe",
                        c("/c", "call",cmd),
                        echo_cmd = TRUE)
}
