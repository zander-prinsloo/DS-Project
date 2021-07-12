############################
###### Prep District #######
############################


fn_db_District <- function(){

    ### DISTRICT ###
    # Rename variables
    db_district <- db_district %>%
        rename(
            district_id = A1,
            District_Name = A2,
            Region = A3,
            Inhabitants = A4,
            VSmall_Municipalities = A5,
            Small_Municipalities = A6,
            Medium_Municipalities = A7,
            Big_Municipalities = A8,
            Cities = A9,
            Urban_Ratio = A10,
            Salary_Ave = A11,
            Unemploy_95 = A12,
            Unemploy_96 = A13,
            Entrep = A14,
            Crimes_95 = A15,
            Crimes_96 = A16
        )

    # Return
    db_district



}



