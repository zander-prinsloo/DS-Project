########################################################
########### Plot - Bar Plot: Loan Status ###############
########################################################


Corrplot_Unemploy_Crime <- function(){


    pacman::p_load(cowplot)

    # First Plot - Unemployment Rates
    g1 <- df_merge %>%
        mutate(Default = ifelse(Default == 0, "No", "Yes")) %>%
        dplyr::select(Unemploy_95, Unemploy_96, Default) %>%
        ggpairs(mapping = aes(colour = Default, fill = Default), alpha = 0.1)+
        scale_color_economist()+
        theme_economist_white()+
        labs(title = "Correlation of Crimes in 1995 and 1996",
             subtitle = "",
             caption = "Note: \n A & B - contract finished \n C & D - contract running",
             xlab = "Loan Status",
             ylab = "Frequency")

    g2 <- df_merge %>%
        mutate(Default = ifelse(Default == 0, "No", "Yes")) %>%
        dplyr::select(Crimes_95, Crimes_96, Default) %>%
        ggpairs(mapping = aes(colour = Default, fill = Default), alpha = 0.1)+
        scale_color_economist()+
        theme_economist_white()+
        labs(title = "Correlation of Crimes in 1995 and 1996",
             subtitle = "",
             caption = "Note: \n A & B - contract finished \n C & D - contract running",
             xlab = "Loan Status",
             ylab = "Frequency")


    par(mfrow = c(2, 1))
    g1
    g2



    #plot_grid(g1, g2, ncol = 1, labels = c("A", "B"))
        # plot_annotation(
        #     title = "Correlation of Unemployment Rates and Crime "
        # )





}



