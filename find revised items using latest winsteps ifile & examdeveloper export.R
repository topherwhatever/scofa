rm(list=ls())
# SET WORKING DIRECTORY (WHERE ALL FILES ARE SAVED)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# LOAD TIDYVERSE
library(tidyverse)
library(openxlsx)
fs::path_wd("data/20230202 ExamDeveloper AOBFPEEIC",ext = "xlsx")

# bench diffs
bdiffs <- read.table(bench_file, skip=1, header=TRUE, sep = ",")

ed_stats <- read.xlsx(xlsxFile=ED_file, sheet = 1, colNames = TRUE)
ed_stats <- ed_stats %>% mutate(NAME = as.numeric(Question.ID))

#ditch deleted items from previous form
bdiffs <- bdiffs %>%
  filter(STATUS!=-3)

revised_set <- ed_stats %>%
  left_join(bdiffs,by="NAME") %>%
  filter(!is.na(MEASURE)) %>%
  filter(is.na(`Analysis.set.name.(Default)`))

revised_items <- pull(revised_set, NAME)

exam_code <- "AOBFPEEIC"
goto_folder <- "equated" #where you want the ANC file

#drop revised items from anchor set
bdiffs <- bdiffs[ ! bdiffs$NAME %in% revised_items, ]

#only need item IDs and measures
bdiffs <- bdiffs[c("NAME","MEASURE")]

#current items
form <- read.table("unpooled/item analysis/ITEMS_Total.csv",
                   skip=1,header=TRUE,sep = ",")

#only need IDs & entry number of current items
form <- form[c("NAME","ENTRY")]

#merge bench diffs to current items; filter by those items with bdiffs
anchors <- left_join(form, bdiffs, by = "NAME") %>% filter(!is.na(MEASURE))

#write the Winsteps anchor file
dir.create(goto_folder, showWarnings = FALSE)
write.table(anchors[c("ENTRY","MEASURE")],
            file = paste0(goto_folder,"/Anchor_",exam_code,".anc"),
            sep = " ",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

# save the workspace to the file .RData
save.image(paste0(exam_code,"_InitialAnchors_20230418.RData"))

