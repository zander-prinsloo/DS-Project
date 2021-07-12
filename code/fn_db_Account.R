############################
###### Prep Account ########
############################

fn_db_Account <- function(){

    presentday <- as.Date(paste("1999", "01", "01", sep = "/"))

    db_account <- db_account %>%
        mutate(Account_Year = str_sub(date, 1, 2),
               Account_Month = str_sub(date, 3, 4),
               Account_Day = str_sub(date, 5,6),
               Account_Date = as.Date(paste(paste0("19",Account_Year), Account_Month, Account_Day, sep = "/")),
               Present_Day = as.Date(paste("1999", "01", "01", sep = "/")),
               Issuance_Freq = ifelse(frequency=="POPLATEK MESICNE", "monthly",
                                      ifelse(frequency=="POPLATEK TYDNE", "weekly",
                                             ifelse(frequency=="POPLATEK PO OBRATU", "after_transaction", "other")))) %>%
        dplyr::select(-c(frequency, date))

    # Return
    db_account

}






