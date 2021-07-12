#################################
######### Prep Loan ############
#################################

fn_db_Loan <- function(){

    db_loan <- db_loan %>%
        mutate(Loan_Year = str_sub(date, 1, 2),
               Loan_Month = str_sub(date, 3, 4),
               Loan_Day = str_sub(date, 5, 6),
               Loan_Date = as.Date(paste(paste0("19",Loan_Year), Loan_Month, Loan_Day, sep = "/")),
               Default = ifelse(status == "B" | status == "D", 1, 0)) %>%
        rename(Loan_Amount = amount,
               Loan_Duration = duration,
               Loan_Payments = payments,
               Loan_Status = status) %>%
        dplyr::select(-c(date))

    # Return
    db_loan

}



