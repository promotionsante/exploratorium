#' Clean the id of a project
#'
#' @return Character. The id cleaned.
#'
#' @noRd
clean_id_project <- function(
    id_project
    ){

    iconv(
      gsub("[[:punct:]]| ", "", id_project),
      to = "ASCII//TRANSLIT"
    )

}
