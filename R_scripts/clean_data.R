library(tidyr)


path = commandArgs(trailingOnly = T)
dir = dirname(path)
file = basename(path)
year = substr(file, start = 1, 4)


if (year >= 2014) {
    y <- scan(path, what = character(), comment.char ="")
    y <- as.data.frame(y)
    clean_data <- separate(y, "y", c("Age","Education", "live_birth_order"), sep = c(2, 3, 4)) 

} else if (year >= 2009) {
    y <- readLines(path)
    y <- as.data.frame(y)
    clean_data <- separate(y, "y", c("flag","Age","Education", "live_birth_order"), sep = c(1, 3, 4))

} else if (year >= 2003) {
    y <- readLines(path)
    y <- as.data.frame(y)
    clean_data <- separate(y, "y", c("flag","Age","Education", "live_birth_order"), sep = c(1, 3, 4))

} else {
    y <- scan(path, what = character(), comment.char ="")
    y <- as.data.frame(y)
    clean_data <- separate(y, "y", c("Age","Education", "live_birth_order"), sep = c(2, 3, 4))
}


clean_data$year <- year
save_name = paste(dir,"/",year,".rds", sep="")
message = paste("Saving", save_name)
write(message, stdout())
saveRDS(clean_data, save_name)
