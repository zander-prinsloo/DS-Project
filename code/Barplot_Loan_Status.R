########################################################
########### Plot - Bar Plot: Loan Status ###############
########################################################


Barplot_Loan_Status <- function(){

    g <- ggplot(data = df_merge %>%
               mutate(Default = ifelse(Default == 1, "Yes", "No")) %>%
               group_by(Loan_Status) %>%
               mutate(Freq = n()) %>%
               dplyr::select(Default, Freq, Loan_Status) %>%
               distinct(Default, .keep_all = TRUE) %>%
               arrange(Loan_Status))+
        geom_bar(mapping = aes(x = Loan_Status, y = Freq, colour = Default, fill = Default), stat = "identity")+
        geom_text(mapping = aes(x = Loan_Status, y = Freq, label = Freq, vjust = -0.3), stat = "identity")+
        scale_color_economist()+
        theme_economist_white()+
        labs(title = "",
             subtitle = "",
             caption = "Note: \n A & B - contract finished \n C & D - contract running",
             xlab = "Loan Status",
             ylab = "Frequency")

    g




}







