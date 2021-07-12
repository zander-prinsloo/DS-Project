########################
##### Data Import ######
########################

fn_import_data <- function(){

    # import 9 data frames
    df_account <- read_delim("data/account.csv", delim = ';')
    df_card <- read_delim("data/card.csv", delim = ';')
    df_client <- read_delim("data/client.csv", delim = ';')
    df_disp <- read_delim("data/disp.csv", delim = ';')
    df_district <- read_delim("data/district.csv", delim = ';')
    df_loan <- read_delim("data/loan.csv", delim = ';')
    df_order <- read_delim("data/order.csv", delim = ';')
    df_trans <- read_delim("data/trans.csv", delim = ';')

    data_list <- list(df_account, df_card,
                      df_client, df_disp,
                      df_district, df_loan,
                      df_order, df_trans)

    data_list


}







