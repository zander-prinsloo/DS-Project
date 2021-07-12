################################################
########### Logistic Model Table ###############
################################################

fn_logistic_assess_table <- function(df){

    # Model names
    model_name <- c("Full Model (All Features)",
                    "PCA Model (Reduced Dimension)",
                    "L1 Regularized Model - Optimal",
                    "L1 Regularized Model - 1 S.E. Rule")

    # Accuracy
    model_mean_accuracy <- c(
        as_tibble(cv_logistic_1$results)$Accuracy,
        as_tibble(cv_logistic_2$results)$Accuracy,
        1-min(cv_logistic_3$cvm),
        1-cv_logistic_3$cvm[which(cv_logistic_3$lambda==cv_logistic_3$lambda.1se)]
    )

    # Standard Errors
    model_se <- c(
        as_tibble(cv_logistic_1$results)$AccuracySD,
        as_tibble(cv_logistic_2$results)$AccuracySD,
        cv_logistic_3$cvsd[which(cv_logistic_3$lambda==cv_logistic_3$lambda.min)],
        cv_logistic_3$cvm[which(cv_logistic_3$lambda==cv_logistic_3$lambda.1se)]
    )

    # Lambda values
    model_lambda <- c(0, # no regularisation
                      0, # no regularisation
                      cv_logistic_3$lambda.min, # regularised
                      cv_logistic_3$lambda.1se # regularised
                      )

    # Data for Table
    model_data <- tibble(Models = model_name,
                         "10-Fold CV Accuracy" = model_mean_accuracy,
                         "Accuracy Standard Error" = model_se,
                         "Lambda Value" = model_lambda
                         )

    # Table
    variable_table <- xtable(model_data,
                             caption = "Comparing Logistic Regression Models for Model Selection \\label{LogisticTable}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}




