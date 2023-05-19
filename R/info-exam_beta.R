info_exam_beta <- function(hobbes_in_wd = NULL, revised_items = NULL) {
  if (!isTRUE(hobbes_in_wd)) {
    message('Please follow the standardized directory structure:\n\n "Root folder named as "exam_code",\n "Hobbes Original" copied unaltered into the root folder, which is the working directory.')
    return(NULL)
  }

  prescored <- fs::dir_ls(fs::path_wd("Hobbes Original"),
                          type = "file",
                          glob = "*SCORED*") %>%
    read.csv()
  cohort_n <- prescored %>% nrow()
  nitms_form <- prescored %>% ncol() - 1


  exam_code =  fs::path_file(fs::path_wd())

  nitms_form = read.csv("Hobbes Original/Domain Key.csv") %>% nrow()
  noptions = read.csv("Hobbes Original/Domain Key.csv") %>%
    dplyr::select(KEY) %>% unique() %>% nrow
  codes = ifelse(noptions == 4, "CODES = ABCD-",
                 ifelse(noptions == 5, "CODES = ABCDE-",
                        "CODE = [**ERROR**: NOT 4 or 5 response options]{shading.color=}"))

  ioptions = LETTERS[1:noptions]
  exam_info = tibble::lst(cohort_n, exam_code, nitms_form, noptions,ioptions, codes, revised_items)

  return(exam_info)
}


