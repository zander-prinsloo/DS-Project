##################################################################
########### Hyperparameters for First Tune XGBoost ###############
##################################################################

fn_xgb_tune1_table <- function(df){

    # Data for Table
    model_data <- hyper_grid %>%
        arrange(test_error) %>%
        head(10) %>%
        as_tibble() %>%
        round(digits = 5) %>%
        dplyr::select(eta:colsample_bytree)

    model_data <- model_data[1,]

    # Table
    variable_table <- xtable(model_data,
                             caption = "Default Hyperparameters for XGBoost Partially Tuned Model \\label{XGBTune1Table}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}

fn_xgb_tune1_table_b <- function(df){

    # Data for Table
    model_data <- hyper_grid %>%
        arrange(test_error) %>%
        head(10) %>%
        as_tibble() %>%
        round(digits = 5) %>%
        dplyr::select(gamma:trees)

    # Table
    variable_table <- xtable(model_data,
                             caption = "Tuning Regularization Hyperparameters for XGBoost Partially Tuned Model \\label{XGBTune1Table_b}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}


