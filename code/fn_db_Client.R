############################
###### Prep Client #########
############################


fn_db_Client <- function(){

    db_client <- db_client %>%
        mutate(Born_Year = str_sub(birth_number, 1, 2),
               Born_Year = paste0("19", Born_Year),
               Born_Month = ifelse(as.numeric(str_sub(birth_number, 3, 4))<50,
                                   str_sub(birth_number, 3, 4),
                                   paste(as.numeric(str_sub(birth_number, 3, 4))-50)),
               Born_Day = str_sub(birth_number, 5, 6),
               Age = paste(1999 - as.numeric(Born_Year)),
               Gender = ifelse(as.numeric(str_sub(birth_number, 3, 4))<50, "Man", "Woman")) %>%
        dplyr::select(-c(birth_number))

    # Return
    db_client

}







