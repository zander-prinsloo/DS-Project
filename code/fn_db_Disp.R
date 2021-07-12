#################################
###### Prep Disposition #########
#################################

fn_db_Disp <- function(){


    db_disp <- db_disp %>%
        mutate(Owner = ifelse(type == "OWNER", 1, 0)) %>%
        dplyr::select(-c(type, disp_id))


    # db_disp <- db_disp %>%
    #     distinct(account_id, .keep_all = T) %>%
    #     mutate(Multiple_Clients = ifelse( (df_disp %>%
    #                                            distinct(account_id) )$account_id %in% (df_disp %>%
    #                                                                                        count(account_id) %>%
    #                                                                                        filter(n>1) )$account_id ,
    #                                       1, 0))

    # Return
    db_disp

}





