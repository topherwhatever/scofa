item_rev_move = function(ir_track_output = NULL){

path_rev = fs::dir_ls(fs::path_home_r("_Tools"),recurse = 0,
           glob = "*Item Revision Tracker*", type = "directory")
rev_out_path = fs::dir_ls(path_rev,type = "file",glob = "*CSV_*")
rev_out1 = read.csv(rev_out_path, skip = 3)
rev_out2 = read.csv(rev_out_path, header = FALSE,nrows = 2) %>% unlist
new_rev = fs::path_wd("_revision_tracker/CSV_Report.csv")
fs::dir_create(fs::path_wd("_revision_tracker/"))
fs::file_copy(path = rev_out_path, new_path = new_rev,overwrite = TRUE)
write.table(x = glue::glue_collapse(c("Rev_tracker Options:",rev_out2), sep = "\n\n"),eol = "",
             quote =FALSE,file = fs::path_wd("_revision_tracker/Rev_out_opts.txt"))
}
