#' Count the number of artists in your playlist
#'
#' @param spotify_data A data.frame from exportify.net
#' @param count An integer indicating the number of rows to return
#' @param see_all A Boolean indicating if the function should return all available rows
#' @param ascending A Boolean who orders the resulting data.frame based on num_appearances
#'
#' @return A data.frame ordering the amount of times each artist appears in a data.frame
#' @export
#'
#' @examples
#' a = "WIP"
#'
favorite_artists <- function(spotify_data, count = 6L, see_all = FALSE, ascending = FALSE) {
  if (!is.data.frame(spotify_data)) {
    stop('`spotify_data` argument requires a type dataframe')
  } else if (
    !identical(dplyr::select(spotify_data, 1), dplyr::select(spotify_data, `Spotify ID`))
    ) {
    stop('`favorite_artists` argument requires data from "Expority"')
  } else if (!is.integer(count) & count %% 1 != 0) {
    stop('`count` argument must be an integer')
  }
  result <- artist_breakdown(spotify_data=spotify_data, ascending = ascending)
  if (see_all) {
    return (result)
  } else {
    return (head(result, count))
  }
}

artist_breakdown <- function(spotify_data, ascending) {
  result <- spotify_data |>
    dplyr::select(`Artist Name(s)`) |>
    dplyr::mutate(artist = (stringr::str_split(`Artist Name(s)`, ",(?=\\S)"))) |>
    tidyr::unnest(artist) |>
    dplyr::group_by(artist) |>
    dplyr::summarize(num_appearances = dplyr::n())
  if (ascending) {
    return (result |> dplyr::arrange(num_appearances))
  }
  return (result |> dplyr::arrange(dplyr::desc(num_appearances)))
}
