##################################################################
########### Hyperparameters for Second Tune XGBoost ###############
##################################################################

fn_xgb_tune2_table <- function(df){

    # Data for Table
    model_data <- hyper_grid_2 %>%
        arrange(test_error) %>%
        head(10) %>%
        as_tibble() %>%
        round(digits = 5) %>%
        dplyr::select(eta:colsample_bytree)

    model_data <- model_data[1,]

    # Table
    variable_table <- xtable(model_data,
                             caption = "Tuning Previous Default Hyperparameters for XGBoost Fully Tuned Model \\label{XGBTune2Table}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}


fn_xgb_tune2_table_b <- function(df){

    # Data for Table
    model_data <- hyper_grid_2 %>%
        arrange(test_error) %>%
        head(10) %>%
        as_tibble() %>%
        round(digits = 5) %>%
        dplyr::select(gamma:trees)

    # Table
    variable_table <- xtable(model_data,
                             caption = "Tuning Regularization Hyperparameters for XGBoost Fully Tuned Model \\label{XGBTune2Table_b}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}


