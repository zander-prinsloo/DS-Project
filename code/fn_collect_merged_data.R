###############################################
######### Collect Final Data Frame ############
###############################################


fn_collect_merged_data <- function(){

    # Collect data base
    df_merge <- db_merge %>%
        collect()

    # Remove duplicates
    df_merge <- df_merge %>%
        distinct(loan_id, .keep_all = TRUE) %>%
        mutate(Unemploy_95 = as.numeric(Unemploy_95),
               Crimes_95 = as.numeric(Crimes_95))

    # Return
    df_merge


}




