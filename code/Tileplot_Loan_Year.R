########################################################
########### Plot - Tile Plot: Loan Year ################
########################################################

Tileplot_Loan_Year <- function(){

   g <-  df_merge %>%
        count(Loan_Status, Loan_Year) %>%
        rename(Count = n) %>%
        ggplot(data = . )+
        geom_tile(mapping = aes(x = Loan_Status, y = Loan_Year, colour = Count, fill = Count))+
        # scale_color_economist()+
        theme_economist_white()+
        labs(title = "",
             subtitle = "",
             caption = "Note: \n A & B - contract finished \n C & D - contract running",
             xlab = "Loan Status",
             ylab = "Frequency")

    # Return
    g



}








