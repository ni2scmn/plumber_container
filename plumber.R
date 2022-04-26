#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Plumber Example API
#* @apiDescription Plumber example description.

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
    list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
    rand <- rnorm(100)
    hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
    as.numeric(a) + as.numeric(b)
}

#* Rand DB output
#* @get /db
function() {
    con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Driver",
                      Server   = "plumber_db",
                      Database = Sys.getenv("POSTGRES_USER"),
                      UID      = Sys.getenv("POSTGRES_USER"),
                      PWD      = Sys.getenv("POSTGRES_PASSWORD"),
                      Port     = Sys.getenv("POSTGRES_PORT"))

    DBI::dbReadTable(con, "test")
}

# Programmatically alter your API
#* @plumber
function(pr) {
    pr %>%
        # Overwrite the default serializer to return unboxed JSON
        pr_set_serializer(serializer_unboxed_json())
}


