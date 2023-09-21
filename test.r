library(fredr)
library(ggplot2)
library(gridExtra)

readRenviron(".env")

api_key <- Sys.getenv("FRED_API_KEY")

women <- fredr("LNS14000002")
men <- fredr("LNS14000001")

start_date <- as.Date("1976-01-01")
end_date <- as.Date("2023-12-31")

women <- subset(women, date >= start_date & date <= end_date)
men <- subset(men, date >= start_date & date <= end_date)

# View the filtered data
View(women)
View(men)

ggplot() +
    geom_line(data = women, aes(x = date, y = value, color = "Ž"), size = 1) +
    geom_line(data = men, aes(x = date, y = value, color = "M"), size = 1) +
    labs(
        x = "Rok",
        y = "Nezaměstnanost (%)"
    ) +
    theme_classic()

decomposition <- decompose(ts(women$value, frequency = 12))

plot(decomposition,
    col = "#055069", pch = 19, xlab = "Time",
    main = "Decomposition of Women's Employment Data",
    ylab = "Custom Y-axis Label"
)



decomposition_df <- data.frame(
    Date = women$date,
    Trend = decomposition$trend,
    Seasonal = decomposition$seasonal,
    Random = decomposition$random
)

plots <- list(
    ggplot(women, aes(date, value)) +
        geom_line(color = "black") +
        labs(title = "Původní časová řada", y = "Nezaměstnanost (%)"),
    ggplot(decomposition_df, aes(Date, Trend)) +
        geom_line(color = "blue") +
        labs(title = "Trend", y = "Nezaměstnanost (%)"),
    ggplot(decomposition_df, aes(Date, Seasonal)) +
        geom_line(color = "red") +
        labs(title = "Sezónní složka", y = "Nezaměstnanost (%)"),
    ggplot(decomposition_df, aes(Date, Random)) +
        geom_line(color = "green") +
        labs(title = "Náhodná složka", y = "Nezaměstnanost (%)")
)

grid.arrange(grobs = plots, ncol = 2)


dataset <- data.frame()
for (state in state.abb) {
    dataset <- rbind(dataset, fredr(paste0(state, "URN"))[, 1:3])
}

dataset$series_id <- gsub("urn", "", dataset$series_id, ignore.case = TRUE)
df <- na.omit(dataset)



df$date <- as.Date(df$date)

# Filter data for the year 2008
df_2008 <- df[df$date >= as.Date("2009-01-01") & df$date <= as.Date("2009-12-31"), ]

# Load the dplyr package
library(dplyr)

# Group by 'series_id' and find the maximum value within each group
max_values_2008 <- df_2008 %>%
    group_by(series_id) %>%
    summarise(max_value = max(value, na.rm = TRUE))
max_values_2008_sorted <- max_values_2008 %>%
    arrange(desc(max_value))
# View the result
print(max_values_2008_sorted)

state.name[which(state.abb == "NY")]

replace_abbreviations <- function(abbreviation) {
    matching_name <- state.name[state.abb == abbreviation]
    if (length(matching_name) > 0) {
        return(matching_name)
    } else {
        return(abbreviation)
    }
}

dataset <- data.frame()
for (state in state.abb) {
    dataset <- rbind(dataset, fredr(paste0(state, "URN"))[, 1:3])
}

dataset$series_id <- gsub("urn", "", dataset$series_id, ignore.case = TRUE)

dataset$series_id <- sapply(dataset$series_id, replace_abbreviations)

View(dataset)
