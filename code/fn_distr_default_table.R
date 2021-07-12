######################################################
########### Default Distribution Table ###############
######################################################



fn_distr_default_table <- function(){

    # Column 1 - labels
    Data <- c("Full Data Set",
              "Training Set",
              "Test Set")

    # Column 2 - Default = 0 (no)
    No <- c(
        paste(round(mean(df_use$Default=="No"), digits = 5)),
        paste(round(mean(df_train$Default=="No"), digits = 5)),
        paste(round(mean(df_test$Default=="No"), digits = 5))
    )

    # Column 3 - Default = 1 (yes)
    Yes <- c(
        paste(round(mean(df_use$Default=="Yes"), digits = 5)),
        paste(round(mean(df_train$Default=="Yes"), digits = 5)),
        paste(round(mean(df_test$Default=="Yes"), digits = 5))
    )

    # Data for table
    Variable_Data <- tibble(Data = Data,
                            No = No,
                            Yes = Yes)

    # Table
    Variable_Data <- xtable(Variable_Data,
                            caption = "Comparing Distributions of Defaults in Different Data Sets \\label{DistributionDefaultTable}"
    )

    # Return table
    print.xtable(x = Variable_Data,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')


}







