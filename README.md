
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scofa

<!-- badges: start -->
<!-- badges: end -->

The goal of scofa is to …

## Installation

You can install the development version of scofa like so:

``` r
devtools::install_github("topherwhatever/scofa")
```

## Example

``` r

exam_code =  fs::path_wd()

exam_info = scofa::info_exam_beta(hobbes_in_wd = TRUE)
#> dunno yet
print(exam_info)
#> $exam_code
#> [1] "AOBFPOCC"
#> 
#> $cohort_n
#> [1] 27
#> 
#> $nitms_form
#> [1] 200
#> 
#> $n_opts
#> [1] 4
#> 
#> $codes
#> [1] "CODES = ABCD-"
```

This is a basic example which shows you how to create the initial
directory structure:

``` r

scofa::path_struc(exam_info = exam_info, copy_hobbes = FALSE)
#> Hobbes Original contents has not been copied into the pooled/equated directory.
fs::dir_tree(path = fs::path_wd(),recurse = 2)
#> C:/Users/cgallagher/Documents/Doing/local_scoring/AOBFPOCC
#> ├── AOBFPOCC.Rproj
#> ├── Hobbes Original
#> │   ├── Anchor_AOBFPOCC.anc
#> │   ├── AOBFPOCC_names.csv
#> │   ├── AOBFPOCC_RESP.dat
#> │   ├── AOBFPOCC_Total.out
#> │   ├── AOBFPOCC_Total.txt
#> │   ├── Control_AOBFPOCC.txt
#> │   ├── Delete_AOBFPOCC.rmv
#> │   ├── Domain Key.csv
#> │   ├── DomainLookup.csv
#> │   ├── ExamTimeReport.csv
#> │   ├── ITEMANALYSIS_Total.txt
#> │   ├── ITEMS_Total.csv
#> │   ├── ItemTimeReport.csv
#> │   ├── NOPP.csv
#> │   ├── OPP.csv
#> │   ├── PERSONS_Total.csv
#> │   ├── SCORED_RESP.csv
#> │   ├── _AOBFPOCC_item_comments.csv
#> │   ├── _AOBFPOCC_RUN.cmd
#> │   ├── _ERRORLOG.txt
#> │   └── _Survey
#> │       ├── AOBFPOCC APR 2023 MEDU Survey Results Report.docx
#> │       ├── S1_data.csv
#> │       ├── S1_Examination_Sources_Prep.png
#> │       ├── S1_JournalList.csv
#> │       ├── S1_OtherList.csv
#> │       ├── S1_ReviewcourseList.csv
#> │       ├── S1_TextbookList.csv
#> │       ├── S2_data.csv
#> │       ├── S2_How_far_in_advance_preparing.png
#> │       ├── S3_data.csv
#> │       ├── S3_Topics_Covered_Appropriate_For_Examination.png
#> │       ├── S4_data.csv
#> │       ├── S4_Questions_Adequately_Tested_Knowledge.png
#> │       ├── S5_data.csv
#> │       ├── S5_Questions_Relevant_Clinical_Practice.png
#> │       ├── S6_data.csv
#> │       ├── S6_Time_Alloted_Sufficient.png
#> │       ├── S7_data.csv
#> │       ├── S7_Remote_Proctored_Effectively_Delivered.png
#> │       ├── S8_Open_Comment.csv
#> │       ├── Summary.csv
#> │       ├── Survey Question Reference.csv
#> │       └── z_Logo.png
#> ├── pooled
#> │   ├── data
#> │   ├── equated
#> │   ├── item analysis
#> │   └── unequated
#> ├── README.md
#> ├── README.Rmd
#> ├── summary_2022_techreport.docx
#> ├── _historical_info.docx
#> ├── _revision_tracker
#> │   ├── AOBFPOCC_ED_RT_export_2023.xlsx
#> │   ├── CSV_Report.csv
#> │   └── REVISED_ITEM_DECISIONS.txt
#> ├── _scripts
#> │   ├── 01isolate_revised_items.R
#> │   ├── 01pre-stage tests.R
#> │   └── 0isolate_revised_items.R
#> ├── _SOPs
#> │   ├── Anchor_EXAMPLE.anc
#> │   ├── cover.png
#> │   ├── coverAOA.png
#> │   ├── index.qmd
#> │   ├── intro.qmd
#> │   ├── preface.qmd
#> │   ├── r4ss.scss
#> │   ├── references.bib
#> │   ├── _quarto.yml
#> │   └── _SOPs.Rproj
#> └── _SOPs_
#>     ├── Anchor_EXAMPLE.anc
#>     ├── cover.png
#>     ├── coverAOA.png
#>     ├── index.qmd
#>     ├── intro.html
#>     ├── intro.qmd
#>     ├── intro_files
#>     │   └── mediabag
#>     ├── prepwork.qmd
#>     ├── r4ss.scss
#>     ├── references.bib
#>     ├── _bookoutput
#>     │   ├── index.html
#>     │   ├── index_files
#>     │   ├── intro.html
#>     │   ├── preface.html
#>     │   ├── search.json
#>     │   ├── site_libs
#>     │   └── test
#>     ├── _quarto.yml
#>     └── _SOPs_.Rproj
```
