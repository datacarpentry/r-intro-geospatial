---
title: "Exploring Data Frames"
teaching: 20
exercises: 10
questions:
- "How can I manipulate a data frame?"
objectives:
- "Add and remove rows or columns."
- "Remove rows with `NA` values."
- "Append two data frames."
- "Understand what a `factor` is."
- "Convert a `factor` to a `character` vector and vice versa."
- "Display basic properties of data frames including size and class of the columns, names, and first few rows."
keypoints:
- "Use `cbind()` to add a new column to a data frame."
- "Use `rbind()` to add a new row to a data frame."
- "Remove rows from a data frame."
- "Use `na.omit()` to remove rows from a data frame with `NA` values."
- "Use `levels()` and `as.character()` to explore and manipulate factors."
- "Use `str()`, `nrow()`, `ncol()`, `dim()`, `colnames()`, `rownames()`, `head()`, and `typeof()` to understand the structure of a data frame."
- "Read in a csv file using `read.csv()`."
- "Understand what `length()` of a data frame represents."
source: Rmd
---



At this point, you've seen it all: in the last lesson, we toured all the basic
data types and data structures in R. Everything you do will be a manipulation of
those tools. But most of the time, the star of the show is the data frame—the table that we created by loading information from a csv file. In this lesson, we'll learn a few more things
about working with data frames.

## Realistic example

We already learned that the columns of a data frame are vectors, so that our
data are consistent in type throughout the columns. 
So far, you have seen the basics of manipulating data frames with our nordic data; now let’s use those skills to digest a more extensive dataset. Let’s read in the gapminder dataset that we downloaded previously:



> ## Miscellaneous Tips
>
> * Another type of file you might encounter are tab-separated value files (.tsv). To specify a tab as a separator, use `"\\t"` or `read.delim()`.
>
> * Files can also be downloaded directly from the Internet into a local
> folder of your choice onto your computer using the `download.file` function.
> The `read.csv` function can then be executed to read the downloaded file from the download location, for example,
> 
> ~~~
> download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
> gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> ~~~
> {: .language-r}
>
> * Alternatively, you can also read in files directly into R from the Internet by replacing the file paths with a web address in `read.csv`. One should note that in doing this no local copy of the csv file is first saved onto your computer. For example,
> 
> ~~~
> gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
> ~~~
> {: .language-r}
>
> * You can read directly from excel spreadsheets without
> converting them to plain text first by using the [readxl](https://cran.r-project.org/web/packages/readxl/index.html) package.
{: .callout}

Let's investigate gapminder a bit; the first thing we should always do is check
out what the data looks like with `str`:


~~~
str(gapminder)
~~~
{: .language-r}



~~~
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
~~~
{: .output}

We can also examine individual columns of the data frame with our `typeof` function:


~~~
typeof(gapminder$year)
~~~
{: .language-r}



~~~
[1] "integer"
~~~
{: .output}



~~~
typeof(gapminder$country)
~~~
{: .language-r}



~~~
[1] "integer"
~~~
{: .output}



~~~
str(gapminder$country)
~~~
{: .language-r}



~~~
 Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
~~~
{: .output}

We can also interrogate the data frame for information about its dimensions;
remembering that `str(gapminder)` said there were 1704 observations of 6
variables in gapminder, what do you think the following will produce, and why?


~~~
length(gapminder)
~~~
{: .language-r}



~~~
[1] 6
~~~
{: .output}

A fair guess would have been to say that the length of a data frame would be the
number of rows it has (1704), but this is not the case; remember, a data frame
is a *list of vectors and factors*:


~~~
typeof(gapminder)
~~~
{: .language-r}



~~~
[1] "list"
~~~
{: .output}

When `length` gave us 6, it's because gapminder is built out of a list of 6
columns. To get the number of rows and columns in our dataset, try:


~~~
nrow(gapminder)
~~~
{: .language-r}



~~~
[1] 1704
~~~
{: .output}



~~~
ncol(gapminder)
~~~
{: .language-r}



~~~
[1] 6
~~~
{: .output}

Or, both at once:


~~~
dim(gapminder)
~~~
{: .language-r}



~~~
[1] 1704    6
~~~
{: .output}

We'll also likely want to know what the titles of all the columns are, so we can
ask for them later:


~~~
colnames(gapminder)
~~~
{: .language-r}



~~~
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"
~~~
{: .output}

At this stage, it's important to ask ourselves if the structure R is reporting
matches our intuition or expectations; do the basic data types reported for each
column make sense? If not, we need to sort any problems out now before they turn
into bad surprises down the road, using what we've learned about how R
interprets data, and the importance of *strict consistency* in how we record our
data.

Once we're happy that the data types and structures seem reasonable, it's time
to start digging into our data proper. Check out the first few lines:


~~~
head(gapminder)
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~
{: .output}

> ## Challenge 1
>
> It's good practice to also check the last few lines of your data and some in the middle. How would you do this?
>
> Searching for ones specifically in the middle isn't too hard but we could simply ask for a few lines at random. How would you code this?
>
> > ## Solution to Challenge 1
> > To check the last few lines it's relatively simple as R already has a function for this:
> > 
> > ~~~
> > tail(gapminder)
> > tail(gapminder, n = 15)
> > ~~~
> > {: .r}
> > 
> > What about a few arbitrary rows just for sanity (or insanity depending on your view)?
> > ## Tip: There are several ways to achieve this.
> > The solution here presents one form using nested functions. i.e. a function passed as an argument to another function. This might sound like a new concept but you are already using it in fact.
> > Remember my_dataframe[rows, cols] will print to screen your data frame with the number of rows and columns you asked for (although you might have asked for a range or named columns for example). How would you get the last row if you don't know how many rows your data frame has? R has a function for this. What about getting a (pseudorandom) sample? R also has a function for this.
> > ~~~
> > gapminder[sample(nrow(gapminder), 5), ]
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 2
>
> Read the output of `str(gapminder)` again;
> this time, use what you've learned about factors, lists and vectors,
> as well as the output of functions like `colnames` and `dim`
> to explain what everything that `str` prints out for gapminder means.
> If there are any parts you can't interpret, discuss with your neighbors!
>
> > ## Solution to Challenge 2
> >
> > The object `gapminder` is a data frame with columns
> > - `country` and `continent` are factors.
> > - `year` is an integer vector.
> > - `pop`, `lifeExp`, and `gdpPercap` are numeric vectors.
> >
> {: .solution}
{: .challenge}

## Adding columns and rows in data frames

We would like to create a new column to hold information on whether the life expectancy is below the world average life expectancy (70.5) or above:


~~~
below_average <-  as.logical(gapminder$lifeExp<70.5)
head(gapminder)
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~
{: .output}

We can then add this as a column via:


~~~
cbind(gapminder, below_average)
~~~
{: .language-r}


~~~
      country year      pop continent lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333      Asia  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934      Asia  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083      Asia  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966      Asia  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460      Asia  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372      Asia  38.438  786.1134          TRUE
~~~
{: .output}

We probably don't want to print the entire dataframe each time, so
let's put our `cbind` command within a call to `head` to return
only the first six lines of the output.


~~~
head(cbind(gapminder, below_average))
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333      Asia  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934      Asia  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083      Asia  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966      Asia  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460      Asia  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372      Asia  38.438  786.1134          TRUE
~~~
{: .output}

Note that if we tried to add a vector of below_average with a different number of entries than the number of rows in the dataframe, it would fail:


~~~
below_average <- c(TRUE,TRUE,TRUE,TRUE,TRUE)
head(cbind(gapminder, below_average))
~~~
{: .language-r}



~~~
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 1704, 5
~~~
{: .error}

Why didn't this work? Of course, R wants to see one element in our new column
for every row in the table:


~~~
nrow(gapminder)
~~~
{: .language-r}



~~~
[1] 1704
~~~
{: .output}



~~~
length(below_average)
~~~
{: .language-r}



~~~
[1] 5
~~~
{: .output}

So for it to work we need either to have `nrow(gapminder)` = `length(below_average)` or `nrow(gapminder)` to be a multiple of `length(below_average)`: 


~~~
below_average <- c(TRUE,TRUE,FALSE)
head(cbind(gapminder, below_average))
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333      Asia  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934      Asia  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083      Asia  31.997  853.1007         FALSE
4 Afghanistan 1967 11537966      Asia  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460      Asia  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372      Asia  38.438  786.1134         FALSE
~~~
{: .output}
The sequence `TRUE,TRUE,FALSE` is repeated over all the gapminder rows.

Let's overwite the content of gapminder with our new data frame.




~~~
below_average <-  as.logical(gapminder$lifeExp<70.5)
gapminder <- cbind(gapminder, below_average)
~~~
{: .language-r}

Now how about adding rows? We already know that the rows of a
data frame are lists:


~~~
newRow <- list('Norway',2016,5000000,'Nordic',80.3,49400.0,FALSE)
gapminder <- rbind(gapminder, newRow)
~~~
{: .language-r}



~~~
Warning in `[<-.factor`(`*tmp*`, ri, value = "Nordic"): invalid factor
level, NA generated
~~~
{: .error}

## Factors

Here is another thing to look out for: in a `factor`, each different value represents what is called a `level`. In our case, the `factor` "continent" has 5 levels: "Africa", "Americas", "Asia", "Europe" and "Oceania". R will only accept values that match one of the levels. If you add a new value, it will become `NA`.

The warning is telling us that we unsuccessfully added "Nordic" to our
*continent* factor, but 2016 (a numeric), 5000000 (a numeric), 80.3 (a numeric), 49400.0 (a numeric) and FALSE (a logical) were
successfully added to *country*, *year*, *pop*, *lifeExp*, *gdpPercap* and *below_average* respectively, since
those variables are not factors. 'Norway' was also successfully added since it corresponds to an existing level. To successfully add a gapminder row with a
"Nordic" *continent*, add "Nordic" as a *level* of the factor:


~~~
levels(gapminder$continent)
~~~
{: .language-r}



~~~
[1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania" 
~~~
{: .output}



~~~
levels(gapminder$continent) <- c(levels(gapminder$continent), "Nordic")
gapminder <- rbind(gapminder, list('Norway',2016,5000000,'Nordic',80.3,49400.0,FALSE))
~~~
{: .language-r}

Alternatively, we can change a factor into a character vector; we lose the
handy categories of the factor, but we can subsequently add any word we want to the
column without babysitting the factor levels:


~~~
str(gapminder)
~~~
{: .language-r}



~~~
'data.frame':	1706 obs. of  7 variables:
 $ country      : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year         : num  1952 1957 1962 1967 1972 ...
 $ pop          : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent    : Factor w/ 6 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp      : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap    : num  779 821 853 836 740 ...
 $ below_average: logi  TRUE TRUE TRUE TRUE TRUE TRUE ...
~~~
{: .output}



~~~
gapminder$continent <- as.character(gapminder$continent)
str(gapminder)
~~~
{: .language-r}



~~~
'data.frame':	1706 obs. of  7 variables:
 $ country      : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year         : num  1952 1957 1962 1967 1972 ...
 $ pop          : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent    : chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp      : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap    : num  779 821 853 836 740 ...
 $ below_average: logi  TRUE TRUE TRUE TRUE TRUE TRUE ...
~~~
{: .output}

## Removing rows

We now know how to add rows and columns to our data frame in R—but in our
first attempt to add a "Nordic" continent to the data frame gapminder we have accidentally
added a garbage row:


~~~
tail(gapminder, n=3)
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp  gdpPercap below_average
1704 Zimbabwe 2007 12311143    Africa  43.487   469.7093          TRUE
1705   Norway 2016  5000000      <NA>  80.300 49400.0000         FALSE
1706   Norway 2016  5000000    Nordic  80.300 49400.0000         FALSE
~~~
{: .output}

We can ask for a data frame minus this offending row:


~~~
tail(gapminder[-1706, ])
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp  gdpPercap below_average
1700 Zimbabwe 1987  9216418    Africa  62.351   706.1573          TRUE
1701 Zimbabwe 1992 10704340    Africa  60.377   693.4208          TRUE
1702 Zimbabwe 1997 11404948    Africa  46.809   792.4500          TRUE
1703 Zimbabwe 2002 11926563    Africa  39.989   672.0386          TRUE
1704 Zimbabwe 2007 12311143    Africa  43.487   469.7093          TRUE
1705   Norway 2016  5000000      <NA>  80.300 49400.0000         FALSE
~~~
{: .output}

Notice the comma with nothing after it to indicate that we want to drop the entire row (rwo with number 1706).

Note: we could also remove both new rows at once by putting the row numbers
inside of a vector: `cats[c(-1706,-1707), ]`

Alternatively, we can drop all rows with `NA` values:


~~~
head(na.omit(gapminder))
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333      Asia  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934      Asia  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083      Asia  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966      Asia  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460      Asia  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372      Asia  38.438  786.1134          TRUE
~~~
{: .output}

Let's reassign the output to `gapminder`, so that our changes will be permanent:


~~~
gapminder <- na.omit(gapminder)
~~~
{: .language-r}

## Removing columns  

We can also remove columns in our data frame. What if we want to remove the column "continent". We can remove it in two ways, by variable number or by index.  


~~~
head(gapminder[,-4])
~~~
{: .language-r}



~~~
      country year      pop lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372  38.438  786.1134          TRUE
~~~
{: .output}

Notice the comma with nothing before it, indicating we want to keep all of the rows.  

Alternatively, we can drop the column by using the index name.  


~~~
drop <- names(gapminder) %in% c("continent")
head(gapminder[,!drop])
~~~
{: .language-r}



~~~
      country year      pop lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372  38.438  786.1134          TRUE
~~~
{: .output}

## Appending to a data frame

The key to remember when adding data to a data frame is that *columns are
vectors and rows are lists.* We can also glue two data frames
together with `rbind`:


~~~
gapminder <- rbind(gapminder, gapminder)
tail(gapminder,n=3)
~~~
{: .language-r}



~~~
       country year      pop continent lifeExp  gdpPercap below_average
17031 Zimbabwe 2002 11926563    Africa  39.989   672.0386          TRUE
17041 Zimbabwe 2007 12311143    Africa  43.487   469.7093          TRUE
17061   Norway 2016  5000000    Nordic  80.300 49400.0000         FALSE
~~~
{: .output}
But now the row names are unnecessarily complicated (not consecutive numbers). We can remove the rownames,
and R will automatically re-name them sequentially:


~~~
rownames(gapminder) <- NULL
head(gapminder)
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap below_average
1 Afghanistan 1952  8425333      Asia  28.801  779.4453          TRUE
2 Afghanistan 1957  9240934      Asia  30.332  820.8530          TRUE
3 Afghanistan 1962 10267083      Asia  31.997  853.1007          TRUE
4 Afghanistan 1967 11537966      Asia  34.020  836.1971          TRUE
5 Afghanistan 1972 13079460      Asia  36.088  739.9811          TRUE
6 Afghanistan 1977 14880372      Asia  38.438  786.1134          TRUE
~~~
{: .output}

> ## Challenge 3
>
> You can create a new data frame right from within R with the following syntax:
> 
> ~~~
> df <- data.frame(id = c("a", "b", "c"),
>                  x = 1:3,
>                  y = c(TRUE, TRUE, FALSE),
>                  stringsAsFactors = FALSE)
> ~~~
> {: .language-r}
> Make a data frame that holds the following information for yourself:
>
> - first name
> - last name
> - lucky number
>
> Then use `rbind` to add an entry for the people sitting beside you.
> Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"
>
> > ## Solution to Challenge 3
> > 
> > ~~~
> > df <- data.frame(first = c("Grace"),
> >                  last = c("Hopper"),
> >                  lucky_number = c(0),
> >                  stringsAsFactors = FALSE)
> > df <- rbind(df, list("Marie", "Curie", 238) )
> > df <- cbind(df, coffeetime = c(TRUE,TRUE))
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

