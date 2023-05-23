# # Read the entire file into a vector of lines
# read_winstepsout = function()
#   lines <- fs::dir_ls(
#     fs::path_wd(final_analysis_dir = equated),glob = "*Total.txt")
#
# # Find the start and end lines for the table
# start_line <- which(grepl("TABLE OF MEASURES ON TEST OF 200 ITEM", lines))
# end_line <- which(grepl("----------------------------------------------------------------------------", lines))[2]
#
# # Extract the table lines
# table_lines <- lines[(start_line+3):(end_line-1)]
#
# # The table is split into three columns, each with three subcolumns
# # We need to split each line into three parts, then each part into three subparts
# table_data <- do.call(rbind, lapply(table_lines, function(line) {
#   # Split the line into three parts
#   parts <- strsplit(line, split = "\\|")[[1]][-1]
#
#   # Split each part into three subparts
#   subparts <- do.call(rbind, strsplit(parts, split = "\\s+"))
#
#   # Return the subparts as a numeric matrix
#   matrix(as.numeric(subparts), ncol = 3, byrow = TRUE)
# }))
#
# # Convert the data to a data frame and add column names
# df <- as.data.frame(table_data)
# colnames(df) <- c("Score", "Measure", "SE")
