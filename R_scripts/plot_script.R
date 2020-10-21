library("dplyr")
library("ggplot2")
library("ggridges")
require(purrr)
require(ggplot2)
require(ggsci) # color scheme
# The animation packages. transformr depends on udunits2 being installed
require(udunits2) # don't forget to install the gnu package too
require(gganimate)
require(sf)
require(transformr)
require(gifski)
require(transformr)
options(scipen = 999)

# Fonts
# library(extrafont)
# extrafont::font_import()
# extrafont::loadfonts()
# windowsFonts("Calibri"= windowsFont("Calibri"))

# Read in .rds files and combine into one dataframe
# If working directly in R, use bracer::expand_braces("{YYYY..YYYY}.rds") to get brace expansion
print("Reading in data now:")
paths = commandArgs(trailingOnly = T)
df <- purrr::map_dfr(paths, readRDS)

print("Data locked and loaded. Ready to make some gifs.")

### Filter out nonresponders
df <- df %>% filter(Education >= 1 & Education <= 9)
  
######## Stacked barplot by education, 2014-2019, All Children

cols_lz <- c("#40E0D0", "#D43F3AFF", "#EEA236FF", "#5CB85CFF", "46B8DAFF", "#357EBDFF", "#9632B8FF", "#B8B8B8FF", "#000000")

edu_labels <- c("8th grade or less", "9th-12th grade, no diploma", "High school or GED", "Some college credit",
                        "Associate's degree", "Bachelor's degree", "Master's degree", "PhD or Professional", "Unknown")

p <- ggplot(df, aes(x=Age, fill = Education)) + geom_histogram(stat = "count", alpha = 0.8) +
  scale_fill_manual(values=cols_lz, labels = edu_labels) + 
  scale_color_manual(values=cols_lz, labels = edu_labels) + theme_ridges(center_axis_labels = T) +  
  scale_x_discrete(breaks = seq(10, 50, 5)) +
  labs(title = 'Births by Age, Year: {closest_state}', subtitle = 'All children') + 
  theme_ridges(center_axis_labels = T) + coord_cartesian(clip = "off") +
  theme(text = element_text(size = 22, family ="Calibri"), 
        plot.title = element_text(size = 24, face = "bold"), 
        plot.subtitle = element_text(size = 22), axis.text = element_text(size = 18)) + 
  ylab("Births\n") + xlab("Age") +
  transition_states(as.integer(year), transition_length = 0.5, state_length = 0.5) + ease_aes("cubic-in-out")


print("ggplot saved. Time to animate.")
animate(p, width = 1000, height = 600, duration = 7, fps = 20) 
anim_save(filename = "2014_2019_bar_chart_edu_all_children.gif")
print("First gif saved.")




####### Age densities by education level, year, all children

# Filter out any "Unknowns" and "8th grade or less"
df <- filter(df, Education >= 2 & Education <= 8) 

# Recode professional or Phd to "Master's or above" (for any year before 2003)
df$Education[df$Education == 8] <- 7

plot <- ggplot(first, aes(x = Age, y = Education, fill = Education, group = Education, height = ..density..)) +
  stat_density_ridges(bandwidth = 1, 
                      alpha = .4, 
                      show.legend = F, 
                      panel_scaling = T,
                      rel_min_height=0.005, color = NA, scale = 1.4) +
  scale_color_locuszoom() + scale_fill_locuszoom() + theme_ridges(center_axis_labels = T) +  
  scale_x_discrete(breaks = seq(10, 50, 5)) +
  labs(title = 'Maternal Age Density by Education Level, Year: {closest_state}', subtitle = 'All children') + 
  theme_ridges(center_axis_labels = T) + coord_cartesian(clip = "off") +
  theme(text = element_text(size = 22, family ="Calibri"), 
        plot.title = element_text(size = 24, face = "bold"), 
        plot.subtitle = element_text(size = 22), axis.text = element_text(size = 18)) + ylab("") + xlab("Age") +
  scale_y_discrete(position = "right", breaks = 2:7, 
                   labels=c("9th-12th grade, no diploma", "High school or GED", "Some college credit",
                            "Associate's degree", "Bachelor's degree", 
                            "Master's degree or higher")) +
  transition_states(as.integer(year), transition_length = 0.5, state_length = 0.5) + ease_aes("cubic-in-out")


# Add shadow
plot2 <- plot + shadow_trail(alpha = 0.05, max_frames = 300) 
# Animate 
animate(plot2, width = 1000, height = 800, duration = 15, fps = 20)
anim_save("education_density_all_children")



#### More plots

## All children, histogram, not stratified by education

# density_plot <- ggplot(df) + geom_histogram(aes(x = Age), stat = "count", fill = "purple", alpha = 0.5) +
#   scale_color_locuszoom() + scale_fill_locuszoom() + theme_classic() +
#   labs(title = 'Year: {closest_state}', subtitle = 'All children') + 
#   theme(text = element_text(size = 18), 
#         plot.title = element_text(size = 22, face = "bold"), 
#         plot.subtitle = element_text(size = 20),
#         legend.title = element_text(size = 20, face = "bold"),
#         legend.text = element_text(size = 18)) + ylab("Count \n\n") + xlab("\n\nAge") +
#   transition_states(as.integer(year), transition_length = 0.5, state_length = 0.5) +
#   ease_aes("cubic-in-out") + 
#   scale_x_discrete(breaks = seq(10, 45, 5))
# 
# print("ggplot saved. Time to animate.")
# animate(density_plot, width = 1000, height = 600, duration = 20, fps = 20) 
# anim_save(filename = "hist_all_children_no_edu.gif")
# print("Gif saved.")
# 
# 
# ## First child, histogram, not stratified by education
# 
# first_child <- df %>% 
#   dplyr::filter(live_birth_order == 1)
# 
# 
# density_plot <- ggplot(first_child) + geom_histogram(aes(x = Age), stat = "count", fill = "purple", alpha = 0.5) +
#   scale_color_locuszoom() + scale_fill_locuszoom() + theme_classic() +
#   labs(title = 'Year: {closest_state}', subtitle = 'First child') + 
#   theme(text = element_text(size = 18), 
#         plot.title = element_text(size = 22, face = "bold"), 
#         plot.subtitle = element_text(size = 20),
#         legend.title = element_text(size = 20, face = "bold"),
#         legend.text = element_text(size = 18)) + ylab("Count \n\n") + xlab("\n\nAge") +
#   transition_states(as.integer(year), transition_length = 0.5, state_length = 0.5) +
#   ease_aes("cubic-in-out") + 
#   scale_x_discrete(breaks = seq(10, 45, 5))
# 
# print("ggplot saved. Time to animate.")
# animate(density_plot, width = 1000, height = 600, duration = 20, fps = 20) 
# anim_save(filename = "hist_first_child_no_edu.gif")
# print("Gif saved.")
# 
# 

print("GIFs complete. Exiting.")
  