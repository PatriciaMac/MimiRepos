install.packages("httr")
install.packages("rvest")
library(httr)
library(rvest)
library(rlang)

get_wikipedia_covid19_testing_page <- function() {
  # Our target COVID-19 wiki page URL is: https://en.wikipedia.org/w/index.php?title=Template:COVID-19_testing_by_country  
  # Which has two parts: 
  # 1) base URL `https://en.wikipedia.org/w/index.php  
  # 2) URL parameter: `title=Template:COVID-19_testing_by_country`, seperated by question mark ?
  
  # Wiki page base
  wikipedia_base_url <-  "https://en.wikipedia.org/w/index.php"
  
  # You will need to create a List which has an element called `title` to specify which page you want to get from Wiki
  # in our case, it will be `Template:COVID-19_testing_by_country`
  wikipedia_parameter <- list(title = "Template:COVID-19_testing_by_country")
  
  # - Use the `GET` function in httr library with a `url` argument and a `query` arugment to get a HTTP response
  wikipedia_response <- GET(wikipedia_base_url, query = wikipedia_parameter)
  
  # Use the `return` function to return the response
  return(wikipedia_response)
}
wikipedia_covid19_page_response <- get_wikipedia_covid19_testing_page()
wikipedia_covid19_page_response

print(wikipedia_covid19_page_response)

# Get the root html node from the http response in task 1 
root_html_node <- read_html(wikipedia_covid19_page_response)
root_html_node

# Get the table node from the root html node
table_node <- html_nodes(root_html_node,"table")

# Read the table node and convert it into a data frame, and print the data frame for review
getdata_frame <- html_table(table_node[2])
as.data.frame(getdata_frame)

# Print the summary of the data frame
summary(getdata_frame)
