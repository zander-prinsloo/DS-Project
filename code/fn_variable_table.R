###############################################
########### Variable Name Table ###############
###############################################

fn_variable_table <- function(df){

    # Prepare Data
    variable_names <- colnames(df)
    # variable_number <- seq(1, length(variable_names))

    # Describe Variables
    variable_description <- c("Loan Default: No (0) or Yes (1) - Target Variable",
                              "Loan Amount",
                              "Duration Of The Loan Agreement",
                              "Size Of Regular Loan Repayments",
                              "Year That Loan Contract Commenced",
                              "Month That Loan Contract Commenced",
                              "Year In Which Account Was Created",
                              "Month In Which Account Was Created",
                              "Frequency With Which Statements Are Issued",
                              "Client Age",
                              "Client Gender",
                              "Name Of District In Which Client Resides",
                              "Region In Which Client Resides",
                              "District Population Size",
                              "Number Of Municipalities In District With Inhabitants < 499",
                              "Number Of Municipalities In District With Inhabitants 500 - 1 999",
                              "Number Of Municipalities In District With Inhabitants 2 000 - 9 999",
                              "Number Of Municipalities In District With Inhabitants > 10 000",
                              "Number Of Cities In District",
                              "Ratio of Urban Inhabitants In District",
                              "Average Salary In District",
                              "District Unemployment Rate In 1995",
                              "Number Of Entrpreneurs Per 1 000 Inhabitants In District",
                              "Number Of Crimes Committed In 1995",
                              "Mean Amount Debited Account",
                              "Most Frequent Payment Type (e.g. Insurance, etc.) By Account",
                              "Number Of Credit Transactions Per Account",
                              "Amount Of Transactions Made By A Single Account",
                              "Number Of Withdrawal Transactions Per Account",
                              "Mean Transaction Amount Per Account",
                              "Mean BalancE In Account After A Transaction",
                              "Modal Transaction Type (e.g. Credit Card Withdrawal, etc.)",
                              "Amount After Transaction minus the Mean Transaction Amount"
                              )


    # Data for Table
    variable_data <- tibble(VariableNames = variable_names,
                            VariableDescription = variable_description)

    # Table
    variable_table <- xtable(variable_data,
                             caption = "Variable Names and Descriptions \\label{VariableTable}")

    print.xtable(x = variable_table,
                 type = "latex",
                 floating = TRUE,
                 tabular.environment = "longtable",
                 table.placement = 'H',
                 # scalebox = 0.3,
                 comment = FALSE,
                 caption.placement = 'bottom')



}

