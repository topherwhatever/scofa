#' Write and inspect control file
#'
#' This writes an updated control file used by Calvin. Currently, it creates the pooled control file, but it will be updated to write all control files.
#'
#' @param pooled Logical. Pooled control file differs from unpooled. TRUE writes the pooled version. Unpooled version yet to be implemented.
#' @param info_list list object generated and updated throughout analysis
#' @param path This is the path for the control file. Its default is the equated subfolder of the un/pooled structure.
#'
#' @return A table is returned to the viewer with the control file open for inspection.
#' @export
#'
#' @examples
#' ctrl_write(pooled = TRUE, info_list = info_list)
ctrl_write <- function(exam_info=exam_info, dir_ctrl = equated){
  lst2global(x = exam_info, envir = rlang::current_env())
  K1 = stringr::str_c(Items_pool[["KEY"]],
                      collapse = "",sep = "")
  ilist = glue::glue_collapse(items_pool$ID,sep = "\n")
  ctrl_file = glue::glue("{dir_ctrl}/Control_{exam_code}.txt")
  yr = lubridate::year(lubridate::now())


  card = glue::glue(
    'Title = "Pooled {yr} {exam_code} Written Exam"\nDATA = {exam_code}_RESP.dat
ITEM1 = 8
NI = {n_items_pool
NAME1 = 1
NAMLEN = 7
{codes}
XWIDE = 1
TABLES = 101000000000110011010000000000000000000000000
RFILE = SCORED_RESP.csv
KEY1 = {K1}
TOTALSCORE = Yes
CSV = Y
MISSCORE=-1
IFILE = ITEMS_Total.csv
DISFILE = ITEMANALYSIS_Total.txt
PFILE = PERSONS_Total.csv
OFILE = {exam_code}_Total.txt
AFILE = Anchor_{exam_code}.anc
DFILE = Delete_{exam_code}.rmv
&END
{ilist}
END NAMES')
  table = card %>%
    stringr::str_split(pattern = "\n",
                       simplify = TRUE) %>% t %>%
    tibble::as_tibble_col(column_name = "     ")
  require(flextable)
  set_flextable_defaults(table.layout = "autofit",padding = 0.25,post_process_html = TRUE, line_spacing = 1,
                         font.family = "Consolas", font.size = 15)
  ft = table %>% flextable() %>% add_header_row(
    values = "[**Check Control Card for Errors**]{.underline color=red}") %>%
    font(fontname = "Arial", part = "body") %>%
    fontsize(size = 10, part = "body") %>%
    align(align = "left",part = "header") %>%
    fontsize(size = 16, part = "header") %>%
    ftExtra::colformat_md(part = "all",.sep = "")
  write(card,file = ctrl_file, sep = "")
  require(crayon)
  warn <- magenta $ underline $ bgBlack

  cat(warn("I hope this function makes it simpler to inspect the card before it's written and used."))
  rstudioapi::showPrompt(title = "View card?",
                         message = "View as html in RStudio before writing the file?",default = "Yes")
  if("Yes")print(ft)
}
