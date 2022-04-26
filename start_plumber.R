#!/usr/bin/env Rscript

#install.packages('plumber', repos='https://cloud.r-project.org')
plumber::pr_run(plumber::plumb("/home/plumber.R"), host = '0.0.0.0', port = 8080)