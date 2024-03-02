
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Spotilytics

``` r
library(spotilytics)
data('rb')
```

### How to get properly formatted data for spotilytics:

1)  Visit [Exportify](https://exportify.net/).

2)  Log in with your Spotify SSO.

3)  Choose your favorite playlist and click download .csv.

4)  Load your playlist data into RStudio.

### How to use `favorite_artists()` Function:

After loading in playlist data from Exportify, you may see your top 6
artists within this playlist like so:

``` r
favorite_artists(rb)
#> # A tibble: 6 × 2
#>   artist         num_appearances
#>   <chr>                    <int>
#> 1 Frank Ocean                  8
#> 2 SZA                          5
#> 3 Sampha                       5
#> 4 Anderson .Paak               4
#> 5 Daniel Caesar                3
#> 6 Giveon                       3
```

If you would like to see your “least favorite” artists (or at least the
ones who appear the least in your playlist), change the `ascending`
argument to `TRUE`.

``` r
favorite_artists(rb, ascending=TRUE)
#> # A tibble: 6 × 2
#>   artist          num_appearances
#>   <chr>                     <int>
#> 1 A$AP Rocky                    1
#> 2 André 3000                    1
#> 3 Brent Faiyaz                  1
#> 4 Bruno Mars                    1
#> 5 Drake                         1
#> 6 Earl Sweatshirt               1
```

If you want to see more of your favorite artists, use the `count=`
argument

``` r
favorite_artists(rb, count=10)
#> # A tibble: 10 × 2
#>    artist             num_appearances
#>    <chr>                        <int>
#>  1 Frank Ocean                      8
#>  2 SZA                              5
#>  3 Sampha                           5
#>  4 Anderson .Paak                   4
#>  5 Daniel Caesar                    3
#>  6 Giveon                           3
#>  7 Kendrick Lamar                   3
#>  8 Mac Miller                       3
#>  9 Tyler, The Creator               3
#> 10 Childish Gambino                 2
```

To just return the whole dataframe, set the `see_all` argument to
`TRUE`.

``` r
all_artists <- favorite_artists(rb, see_all=TRUE)

all_artists
#> # A tibble: 26 × 2
#>    artist             num_appearances
#>    <chr>                        <int>
#>  1 Frank Ocean                      8
#>  2 SZA                              5
#>  3 Sampha                           5
#>  4 Anderson .Paak                   4
#>  5 Daniel Caesar                    3
#>  6 Giveon                           3
#>  7 Kendrick Lamar                   3
#>  8 Mac Miller                       3
#>  9 Tyler, The Creator               3
#> 10 Childish Gambino                 2
#> # ℹ 16 more rows
```
