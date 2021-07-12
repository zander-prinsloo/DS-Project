############################
###### Merge Data ##########
############################



fn_merge_data <- function(){

    # Account to Loans by 'account_id'
    db_merge <- left_join(
        db_loan,
        db_account,
        by = "account_id"
    )

    # Disp by 'account_id'
    db_merge <- left_join(
        db_merge,
        db_disp,
        by = "account_id"
    )


    # Client by 'client_id'
    db_merge <- left_join(
        db_merge,
        db_client %>% dplyr::select(-c(district_id)),
        by = "client_id"
    )

    # District by 'district_id'
    db_merge <- left_join(
        db_merge,
        db_district,
        by = "district_id"
    )

    # Order by 'account_id'
    db_merge <- left_join(
        db_merge,
        db_order,
        by = "account_id"
    )

    # Transactions by 'account_id'
    db_merge <- left_join(
        db_merge,
        db_trans,
        by = "account_id"
    )

    # Return
    db_merge


}



