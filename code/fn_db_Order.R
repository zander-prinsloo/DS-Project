#################################
######### Prep Order ############
#################################


fn_db_Order <- function(){

    #source(file = "/Users/zanderprinsloo/Library/Mobile Documents/com~apple~CloudDocs/Desktop/Desktop – MacBookPro’s MacBook Pro/Academic/Postgraduate/Masters/Modules/Data Science/Project/DS-Project/code/Mode.R")
    db_order <- left_join(
        db_order %>%
            group_by(account_id) %>%
            summarise(Mean_Debited_Order_Amount = mean(amount, na.rm = T)) %>%
            ungroup(),
        db_order %>%
            mutate(K = ifelse(k_symbol == "POJISTNE", "Insurance",
                              ifelse(k_symbol == "SIPO", "Household_Payment",
                                     ifelse(k_symbol == "LEASING", "Leasing",
                                            ifelse(k_symbol == "Uver", "Loan", "other"))))) %>%
            group_by(account_id) %>%
            summarise(Modal_Order_Type = Mode(K)) %>%
            ungroup(),
        by = "account_id")

    # Return
    db_order

}




