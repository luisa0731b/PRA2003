# Analyze output-Set1.txt !
# This should be a memory-efficient version for very large files
# ------------------------------------------------------------
### 1. ATTENTION!! To whoever is looking at this code, please put the path of your data set below! ###
# ------------------------------------------------------------
file <- "C:/Users/luisa/OneDrive/Desktop/PRA2003/week 3/output-Set1.txt"
^^ # just an example, but this won't work on anyone else's end as it is the path on my end

# ------------------------------------------------------------
# 2. Listing the 12 IDs we're actually interested in
# ------------------------------------------------------------
valid_ids <- c(
  211,
  -211,
  321,
  -321,
  2212,
  -2212,
  3122,
  -3122,
  3312,
  -3312,
  3334,
  -3334
) # only bacteria with these ID will be counted

# ------------------------------------------------------------
# 3. Opening the file (put the path to the file above!)
# ------------------------------------------------------------
con <- file(file, open = "r") # opens a connection to the file so we can read it line by line
## (so we don't load the whole thing into the memory at once)

# ------------------------------------------------------------
# 4. The variables for keeping track of the results
# ------------------------------------------------------------
n_events <- 0 # counts how many valid events have been processed so far (so starting at 0) 

# a running total count of each bacteria type across events
total_counts <- setNames(numeric(length(valid_ids)), as.character(valid_ids))

# accumulates the sum of square per-event counts for each ID so ew cna calculate the uncertainty later
sum_squares <- setNames(numeric(length(valid_ids)),as.character(valid_ids))

# ------------------------------------------------------------
# 5. Reading the file event-by-event
# ------------------------------------------------------------
while (TRUE) { # starts a loop that keeps reading the file until it ends

  # reading one line at a time while looking for the next header line (and skipping blank lines)
  header <- ""

  while (header == "") {
    header <- readLines(con, n = 1) # reads one line
    # End of file
    if (length(header) == 0) {
      break
    }
    header <- trimws(header) # trims unnecessary spaces
  }

  # stops if we reached the end of the file
  if (length(header) == 0) {
    break
  }

  pieces <- strsplit(header, "\\s+")[[1]]

  if (length(pieces) != 2) { # checks if it is a header as a proper header should have exactly 2 values

    # not a header, so move on
    next
  }

  # converts the two header values from text to integers
  event_number <- as.integer(pieces[1])
  n_particles <- as.integer(pieces[2])

  if (n_particles == 0) {
    next
  }

  # ----------------------------------------------------------
  # Count IDs in THIS event
  # ----------------------------------------------------------

  event_counts <- setNames(numeric(length(valid_ids)), as.character(valid_ids)) # counter set to zero for this event

  # read exactly n_particles rows
  for (j in seq_len(n_particles)) {

    particle_line <- readLines(con, n = 1)

    # Safety check
    if (length(particle_line) == 0) { # handles scenario if file ends
      break
    }

    particle_line <- trimws(particle_line)

    # Skip blank lines if necessary
    if (particle_line == "") { # handles scenario of blank line
      next
    }

    # split bacteria row
    values <- strsplit(particle_line, "\\s+")[[1]]

    # last column is the ID
    particle_id <- suppressWarnings( # hides the warning that would print if the conversion fails
      as.integer(values[length(values)])
    )

    # count it if it is one of IDs in the list of IDs with bacterias related to it
    if (!is.na(particle_id) && # if the ID is one of our bacterias, increment ID counter by one
        particle_id %in% valid_ids) {

      event_counts[as.character(particle_id)] <-
        event_counts[as.character(particle_id)] + 1
    }
  }

  n_events <- n_events + 1 # incrementing overall event counter

  # add this event's counts to the totals
  total_counts <- total_counts + event_counts

  # add squared counts for uncertainty calculation
  sum_squares <- sum_squares + event_counts^2

  # progress message every 10,000 events (so you know if the code is still processing..)
  if (n_events %% 10000 == 0) {

    cat(
      "Processed",
      n_events,
      "valid events\n"
    )
  }
}

# ------------------------------------------------------------
# 6. Closing the file
# ------------------------------------------------------------
close(con) # close the connection with the file because reading is done

# ------------------------------------------------------------
# 7. Calculating averages and statistical uncertainties
# ------------------------------------------------------------
average <- total_counts / n_events # mean number of each particle type per event

# sample variance:
## variance = [sum(x^2) - (sum(x)^2 / N)] / (N - 1)

variance <- (
  sum_squares -
    (total_counts^2 / n_events)
) / (n_events - 1) # computing sample variance


# Statistical uncertainty of the mean
uncertainty <- sqrt(variance / n_events) # standard error of mean (uncertainty)

# ------------------------------------------------------------
# 8. Making final results table
# ------------------------------------------------------------

results <- data.frame(
  ID = valid_ids,
  Total = as.numeric(total_counts),
  Events = n_events,
  Average = as.numeric(average),
  Statistical_uncertainty = as.numeric(uncertainty)
) # assembling everything into a table with one row per particle ID, showing total count, number of events processed, average per event, and uncertainty of that event

# ------------------------------------------------------------
# 9. Display results
# ------------------------------------------------------------
print(results) # prints results!