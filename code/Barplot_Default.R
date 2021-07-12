#####################################################
########### Plot - Bar Plot: Defaults ###############
#####################################################


Barplot_Default <- function(){
    # barplot of the target variable
    # 'Default' is a binary target variable
    g <- ggplot(data = df_merge %>%
               mutate(Default = ifelse(Default == 1, "Yes", "No")) %>%
               group_by(Default) %>%
               mutate(Freq = n()) %>%
               dplyr::select(Default, Freq) %>%
               distinct(Default, .keep_all = TRUE))+
        geom_bar(mapping = aes(x = Default, y = Freq, colour = Default, fill = Default), stat = "identity")+
        geom_text(mapping = aes(x = Default, y = Freq, label = Freq, vjust = -0.3), stat = "identity")+
        scale_color_economist()+
        theme_economist_white()

    g


}





