#' Get early information about an exam using contextual information
#'
#' The function assumes a properly generated paths_list list and a list of revised items, which can be replaced with subsequent functions, in form list(ITEMID, ITEMID, ITEMID). Specifying the revised items in alternative list formats, vectors, or numeric with lead to issues at this stage of development.
#'
#' @param revised_items a list of revised items, which can be replaced with subsequent functions, in form list(ITEMID, ITEMID, ITEMID). Specifying the revised items in alternative list formats, vectors, or numeric with lead to issues at this stage of development.
#'
#' @return exam information in list form to be used in subsequent scoring functions
#'
#'
#' @examples
#' info_exam()
#' info_exam(list(984654, 243567))
info_exam1 <- function(exam_infolist = exam_info, revised_items=NULL){
  scofa::lst2global(exam_info)
  nitms_form = testform_k
  exam_code =  fs::path_file(fs::path_wd())
  nitms_form = read.csv("Hobbes Original/Domain Key.csv") %>% nrow()
  noptions = read.csv("Hobbes Original/Domain Key.csv") %>%
    dplyr::select(KEY) %>% unique() %>% nrow
  codes = ifelse(noptions == 4, "CODES = ABCD-",
                 ifelse(noptions == 5, "CODES = ABCDE-",
                        "CODE = [**ERROR**: NOT 4 or 5 response options]{shading.color=}"))
  rfiles_path = paths_list[["data"]]
  ioptions = LETTERS[1:noptions]
  pool_path = rfiles_path %>% stringr::str_sub(start = 1, end = -6L)
  exam_info <<- tibble::lst(cohort_n, exam_code, nitms_form, noptions,ioptions, codes,
                            rfiles_path, pool_path, revised_items)
}
