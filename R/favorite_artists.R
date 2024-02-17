#' Count the number of artists in your playlist!
#'
#' @param spotify_data A data.frame from exportify.net
#' @param count An integer who dictates the number of rows
#' @param see_all A Boolean who dictates if the function should return all available rows
#'
#' @return A data.frame ordering the amount of times each artist appears in a data.frame
#' @export
#'
#' @examples
#' my_playlist <- readr::read_csv('my_playlist.csv')
#' favorite_artists(spotify_data = my_playlist)
#' favorite_artists(my_playlist, count = 5L)
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
    dplyr::mutate(artist = (str_split(`Artist Name(s)`, ",(?=\\S)"))) |>
    tidyr::unnest(artist) |>
    dplyr::group_by(artist) |>
    dplyr::summarize(num_appearances = dplyr::n())
  if (ascending) {
    return (result |> dplyr::arrange(num_appearances))
  }
  return (result |> dplyr::arrange(desc(num_appearances)))
}
