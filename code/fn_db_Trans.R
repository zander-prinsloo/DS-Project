#################################
######### Prep Trans ############
#################################

fn_db_Trans <- function(){




    db_trans <- db_trans %>%
        dplyr::select(-c(trans_id,  k_symbol, bank, account)) %>%
        filter(!is.na(operation)) %>%
        mutate(Transaction_Mode = ifelse(operation == "VYBER KARTOU", "Credit_Card_Withdrawal",
                                         ifelse(operation == "VKLAD", "Credit_in_Cash",
                                                ifelse(operation == "PREVOD Z UCTU" | operation == "PREVOD NA UCET", "Other_Bank",
                                                       ifelse(operation == "VYBER", "Cash_Withdrawal", "other"))))) %>%
        dplyr::mutate(Trans_Credit_count = ifelse(type == "PRIJEM", 1, 0),
                      Trans_Withdraw_count = ifelse(type == "VYDAJ", 1, 0),
                      Trans_Mode_count_a = ifelse(Transaction_Mode == "Credit_Card_Withdrawal", 1, 0),
                      Trans_Mode_count_b = ifelse(Transaction_Mode == "Credit_in_Cash", 1, 0),
                      Trans_Mode_count_c = ifelse(Transaction_Mode == "Other_Bank", 1, 0),
                      Trans_Mode_count_d = ifelse(Transaction_Mode == "Cash_Withdrawal", 1, 0),
                      Trans_Mode_count_e = ifelse(Transaction_Mode == "other", 1, 0)) %>%
        group_by(account_id) %>%
        dplyr::mutate(Trans_Credit = sum(Trans_Credit_count),
                      Transaction_Freq = n(),
                      Trans_Withdraw = sum(Trans_Withdraw_count),
                      Trans_Amount_Mean = mean(amount, na.rm = T),
                      Trans_Balance = mean(balance, na.rm = T)) %>%
        dplyr::mutate(Spread = mean(Trans_Balance - Trans_Amount_Mean)) %>%
        dplyr::mutate(Trans_Mode_a = sum(Trans_Mode_count_a),
                      Trans_Mode_b = sum(Trans_Mode_count_b),
                      Trans_Mode_c = sum(Trans_Mode_count_c),
                      Trans_Mode_d = sum(Trans_Mode_count_d),
                      Trans_Mode_e = sum(Trans_Mode_count_e)) %>%
        dplyr::mutate(Trans_Mode = "Credit_Card_Withdrawal",
                      Trans_Mode = ifelse(Trans_Mode_a > Trans_Mode_b &
                                              Trans_Mode_a > Trans_Mode_c &
                                              Trans_Mode_a > Trans_Mode_d &
                                              Trans_Mode_a > Trans_Mode_e, "Credit_Card_Withdrawal", Trans_Mode),
                      Trans_Mode = ifelse(Trans_Mode_b > Trans_Mode_a &
                                              Trans_Mode_b > Trans_Mode_c &
                                              Trans_Mode_b > Trans_Mode_d &
                                              Trans_Mode_b > Trans_Mode_e, "Credit_in_Cash", Trans_Mode),
                      Trans_Mode = ifelse(Trans_Mode_c > Trans_Mode_a &
                                              Trans_Mode_c > Trans_Mode_b &
                                              Trans_Mode_c > Trans_Mode_d &
                                              Trans_Mode_c > Trans_Mode_e, "Other_Bank", Trans_Mode),
                      Trans_Mode = ifelse(Trans_Mode_d > Trans_Mode_a &
                                              Trans_Mode_d > Trans_Mode_b &
                                              Trans_Mode_d > Trans_Mode_c &
                                              Trans_Mode_d > Trans_Mode_e, "Cash_Withdrawal", Trans_Mode),
                      Trans_Mode = ifelse(Trans_Mode_e > Trans_Mode_a &
                                              Trans_Mode_e > Trans_Mode_b &
                                              Trans_Mode_e > Trans_Mode_c &
                                              Trans_Mode_e > Trans_Mode_d, "other", Trans_Mode)) %>%
        dplyr::select(-contains("count")) %>%
        dplyr::select(-c(Trans_Mode_a:Trans_Mode_e, date:balance)) %>%
        ungroup()

    # Return
    db_trans




    # df_trans %>%
    #     dplyr::select(-c(trans_id,  k_symbol, bank, account)) %>%
    #     mutate(Transaction_Mode = ifelse(operation == "VYBER KARTOU", "Credit_Card_Withdrawal",
    #                                      ifelse(operation == "VKLAD", "Credit_in_Cash",
    #                                             ifelse(operation == "PREVOD Z UCTU" | operation == "PREVOD NA UCET", "Other_Bank",
    #                                                    ifelse(operation == "VYBER", "Cash_Withdrawal", "other"))))) %>%
    #
    #     group_by(account_id) %>%
    #     mutate(Trans_Credit = sum(type == "PRIJEM", na.rm = T),
    #            Trans_Withdraw = sum(type == "VYDAJ", na.rm = T),
    #            Trans_Amount_Mean = mean(amount, na.rm = T),
    #            Trans_Mode = Mode(Transaction_Mode),
    #            Trans_Balance = mean(balance, na.rm = T),
    #            Spread = mean(Trans_Balance - Trans_Amount_Mean)) %>%
    #     arrange(account_id)
    # ungroup()


}




