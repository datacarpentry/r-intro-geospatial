---
title: Data Structures
teaching: 40
exercises: 15
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be aware of the different types of data.
- To begin exploring data frames, and understand how they are related to vectors, factors and lists.
- To be able to ask questions from R about the type, class, and structure of an object.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I read data in R?
- What are the basic data types in R?
- How do I represent categorical information in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



One of R's most powerful features is its ability to deal with tabular data -
such as you may already have in a spreadsheet or a CSV file. Let's start by
downloading and reading in a file `nordic-data.csv`. We will
save this data as an object named `nordic`:


```r
nordic <- read.csv("data/nordic-data.csv")
```

The `read.table` function is used for reading in tabular data stored in a text
file where the columns of data are separated by punctuation characters such as
CSV files (csv = comma-separated values). Tabs and commas are the most common
punctuation characters used to separate or delimit data points in csv files.
For convenience R provides 2 other versions of `read.table`. These are: `read.csv`
for files where the data are separated with commas and `read.delim` for files
where the data are separated with tabs. Of these three functions `read.csv` is
the most commonly used.  If needed it is possible to override the default
delimiting punctuation marks for both `read.csv` and `read.delim`.

We can begin exploring our dataset right away, pulling out columns by specifying
them using the `$` operator:


```r
nordic$country
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

```r
nordic$lifeExp
```

```{.output}
[1] 77.2 80.0 79.0
```

We can do other operations on the columns. For example, if we discovered that the life expectancy is two years higher:


```r
nordic$lifeExp + 2
```

```{.output}
[1] 79.2 82.0 81.0
```

But what about:


```r
nordic$lifeExp + nordic$country
```

```{.error}
Error in nordic$lifeExp + nordic$country: non-numeric argument to binary operator
```

Understanding what happened here is key to successfully analyzing data in R.

## Data Types

::::::::::::::::::::::::::::::::::::::: instructor

- Learners will work with factors in the following lesson. Be sure to
  cover this concept.
- If needed for time reasons, you can skip the section on lists. The learners
  don't use lists in the rest of the workshop.
  
:::::::::::::::::::::::::::::::::::::::

If you guessed that the last command will return an error because `77.2` plus
`"Denmark"` is nonsense, you're right - and you already have some intuition for an
important concept in programming called *data classes*. We can ask what class of
data something is:


```r
class(nordic$lifeExp)
```

```{.output}
[1] "numeric"
```

There are 6 main types: `numeric`, `integer`, `complex`, `logical`, `character`, and `factor`.


```r
class(3.14)
```

```{.output}
[1] "numeric"
```

```r
class(1L) # The L suffix forces the number to be an integer, since by default R uses float numbers
```

```{.output}
[1] "integer"
```

```r
class(1+1i)
```

```{.output}
[1] "complex"
```

```r
class(TRUE)
```

```{.output}
[1] "logical"
```

```r
class('banana')
```

```{.output}
[1] "character"
```

```r
class(factor('banana'))
```

```{.output}
[1] "factor"
```

No matter how
complicated our analyses become, all data in R is interpreted a specific
data class. This strictness has some really important consequences.

A user has added new details of age expectancy. This information is in the file
`data/nordic-data-2.csv`.

Load the new nordic data as `nordic_2`, and check what class of data we find in the
`lifeExp` column:


```r
nordic_2 <- read.csv("data/nordic-data-2.csv")
class(nordic_2$lifeExp)
```

```{.output}
[1] "character"
```

Oh no, our life expectancy lifeExp aren't the numeric type anymore! If we try to do the same math
we did on them before, we run into trouble:


```r
nordic_2$lifeExp + 2
```

```{.error}
Error in nordic_2$lifeExp + 2: non-numeric argument to binary operator
```

What happened? When R reads a csv file into one of these tables, it insists that
everything in a column be the same class; if it can't understand
*everything* in the column as numeric, then *nothing* in the column gets to be numeric. The table that R loaded our nordic data into is something called a
dataframe, and it is our first example of something called a *data
structure* - that is, a structure which R knows how to build out of the basic
data types.

We can see that it is a dataframe by calling the `class()` function on it:


```r
class(nordic)
```

```{.output}
[1] "data.frame"
```

In order to successfully use our data in R, we need to understand what the basic
data structures are, and how they behave.

## Vectors and Type Coercion

To better understand this behavior, let's meet another of the data structures:
the vector.


```r
my_vector <- vector(length = 3)
my_vector
```

```{.output}
[1] FALSE FALSE FALSE
```

A vector in R is essentially an ordered list of things, with the special
condition that everything in the vector must be the same basic data type. If
you don't choose the data type, it'll default to `logical`; or, you can declare
an empty vector of whatever type you like.


```r
another_vector <- vector(mode = 'character', length = 3)
another_vector
```

```{.output}
[1] "" "" ""
```

You can check if something is a vector:


```r
str(another_vector)
```

```{.output}
 chr [1:3] "" "" ""
```

The somewhat cryptic output from this command indicates the basic data type
found in this vector - in this case `chr`, character; an indication of the
number of things in the vector - actually, the indexes of the vector, in this
case `[1:3]`; and a few examples of what's actually in the vector - in this case
empty character strings. If we similarly do


```r
str(nordic$lifeExp)
```

```{.output}
 num [1:3] 77.2 80 79
```

we see that `nordic$lifeExp` is a vector, too - the columns of data we load into R
data frames are all vectors, and that's the root of why R forces everything in
a column to be the same basic data type.

::::::::::::::::::::::::::::::::::::::  discussion

## Discussion 1

Why is R so opinionated about what we put in our columns of data?
How does this help us?

:::::::::::::::  solution

## Discussion 1

By keeping everything in a column the same, we allow ourselves to make simple
assumptions about our data; if you can interpret one entry in the column as a
number, then you can interpret *all* of them as numbers, so we don't have to
check every time. This consistency is what people mean when they talk about
*clean data*; in the long run, strict consistency goes a long way to making
our lives easier in R.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

You can also make vectors with explicit contents with the combine function:


```r
combine_vector <- c(2, 6, 3)
combine_vector
```

```{.output}
[1] 2 6 3
```

Given what we've learned so far, what do you think the following will produce?


```r
quiz_vector <- c(2, 6, '3')
```

This is something called *type coercion*, and it is the source of many surprises
and the reason why we need to be aware of the basic data types and how R will
interpret them. When R encounters a mix of types (here numeric and character) to
be combined into a single vector, it will force them all to be the same
type. Consider:


```r
coercion_vector <- c('a', TRUE)
coercion_vector
```

```{.output}
[1] "a"    "TRUE"
```

```r
another_coercion_vector <- c(0, TRUE)
another_coercion_vector
```

```{.output}
[1] 0 1
```

The coercion rules go: `logical` -> `integer` -> `numeric` -> `complex` ->
`character`, where -> can be read as *are transformed into*. You can try to
force coercion against this flow using the `as.` functions:


```r
character_vector_example <- c('0', '2', '4')
character_vector_example
```

```{.output}
[1] "0" "2" "4"
```

```r
character_coerced_to_numeric <- as.numeric(character_vector_example)
character_coerced_to_numeric
```

```{.output}
[1] 0 2 4
```

```r
numeric_coerced_to_logical <- as.logical(character_coerced_to_numeric)
numeric_coerced_to_logical
```

```{.output}
[1] FALSE  TRUE  TRUE
```

As you can see, some surprising things can happen when R forces one basic data
type into another! Nitty-gritty of type coercion aside, the point is: if your
data doesn't look like what you thought it was going to look like, type coercion
may well be to blame; make sure everything is the same type in your vectors and
your columns of data frames, or you will get nasty surprises!

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Given what you now know about type conversion, look at the class of
data in `nordic_2$lifeExp` and compare it with `nordic$lifeExp`. Why are
these columns different classes?

:::::::::::::::  solution

## Solution


```r
str(nordic_2$lifeExp)
```

```{.output}
 chr [1:3] "77.2" "80" "79.0 or 83"
```

```r
str(nordic$lifeExp)
```

```{.output}
 num [1:3] 77.2 80 79
```

The data in `nordic_2$lifeExp` is stored as a character vector, rather than as
a numeric vector. This is because of the "or" character string in the third
data point.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

The combine function, `c()`, will also append things to an existing vector:


```r
ab_vector <- c('a', 'b')
ab_vector
```

```{.output}
[1] "a" "b"
```

```r
combine_example <- c(ab_vector, 'DC')
combine_example
```

```{.output}
[1] "a"  "b"  "DC"
```

You can also make series of numbers:


```r
my_series <- 1:10
my_series
```

```{.output}
 [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(10)
```

```{.output}
 [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(1,10, by = 0.1)
```

```{.output}
 [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3  2.4
[16]  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7  3.8  3.9
[31]  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1  5.2  5.3  5.4
[46]  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5  6.6  6.7  6.8  6.9
[61]  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9  8.0  8.1  8.2  8.3  8.4
[76]  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3  9.4  9.5  9.6  9.7  9.8  9.9
[91] 10.0
```

We can ask a few questions about vectors:


```r
sequence_example <- seq(10)
head(sequence_example,n = 2)
```

```{.output}
[1] 1 2
```

```r
tail(sequence_example, n = 4)
```

```{.output}
[1]  7  8  9 10
```

```r
length(sequence_example)
```

```{.output}
[1] 10
```

```r
class(sequence_example)
```

```{.output}
[1] "integer"
```

Finally, you can give names to elements in your vector:


```r
my_example <- 5:8
names(my_example) <- c("a", "b", "c", "d")
my_example
```

```{.output}
a b c d 
5 6 7 8 
```

```r
names(my_example)
```

```{.output}
[1] "a" "b" "c" "d"
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Start by making a vector with the numbers 1 through 26.
Multiply the vector by 2, and give the resulting vector
names A through Z (hint: there is a built in vector called `LETTERS`)

:::::::::::::::  solution

## Solution to Challenge 2


```r
x <- 1:26
x <- x * 2
names(x) <- LETTERS
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Factors

We said that columns in data frames were vectors:


```r
str(nordic$lifeExp)
```

```{.output}
 num [1:3] 77.2 80 79
```

```r
str(nordic$year)
```

```{.output}
 int [1:3] 2002 2002 2002
```

```r
str(nordic$country)
```

```{.output}
 chr [1:3] "Denmark" "Sweden" "Norway"
```

One final important data structure in R is called a "factor". Factors look like 
character data, but are used to represent data where each element of the vector
must be one of a limited number of "levels". To phrase that another way, factors
are an "enumerated" type where there are a finite number of pre-defined values
that your vector can have. 

For example, let's make a vector of strings labeling nordic countries for all 
the countries in our study:


```r
nordic_countries <- c('Norway', 'Finland', 'Denmark', 'Iceland', 'Sweden')
nordic_countries
```

```{.output}
[1] "Norway"  "Finland" "Denmark" "Iceland" "Sweden" 
```

```r
str(nordic_countries)
```

```{.output}
 chr [1:5] "Norway" "Finland" "Denmark" "Iceland" "Sweden"
```

We can turn a vector into a factor like so:


```r
categories <- factor(nordic_countries)
class(categories)
```

```{.output}
[1] "factor"
```

```r
str(categories)
```

```{.output}
 Factor w/ 5 levels "Denmark","Finland",..: 4 2 1 3 5
```

Now R has noticed that there are 5 possible categories in our data - but it
also did something surprising; instead of printing out the strings we gave it,
we got a bunch of numbers instead. R has replaced our human-readable categories
with numbered indices under the hood, this is necessary as many statistical
calculations utilise such numerical representations for categorical data:


```r
class(nordic_countries)
```

```{.output}
[1] "character"
```

```r
class(categories)
```

```{.output}
[1] "factor"
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge

Can you guess why these numbers are used to represent these countries?

:::::::::::::::  solution

## Solution

They are sorted in alphabetical order

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Convert the `country` column of our `nordic` data frame to a factor. Then try
converting it back to a character vector. 

Now try converting `lifeExp` in our `nordic` data frame to a factor, then back
to a numeric vector. What happens if you use `as.numeric()`?

Remember that you can reload the `nordic` data frame using 
`read.csv("data/nordic-data.csv")` if you accidentally lose some data!

:::::::::::::::  solution

## Solution to Challenge 3

Converting character vectors to factors can be done using the `factor()` 
function:


```r
nordic$country <- factor(nordic$country)
nordic$country
```

```{.output}
[1] Denmark Sweden  Norway 
Levels: Denmark Norway Sweden
```

You can convert these back to character vectors using `as.character()`:


```r
nordic$country <- as.character(nordic$country)
nordic$country
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

You can convert numeric vectors to factors in the exact same way:


```r
nordic$lifeExp <- factor(nordic$lifeExp)
nordic$lifeExp
```

```{.output}
[1] 77.2 80   79  
Levels: 77.2 79 80
```

But be careful -- you can't use `as.numeric()` to convert factors to numerics!


```r
as.numeric(nordic$lifeExp)
```

```{.output}
[1] 1 3 2
```

Instead, `as.numeric()` converts factors to those "numbers under the hood" we 
talked about. To go from a factor to a number, you need to first turn the factor
into a character vector, and _then_ turn that into a numeric vector:


```r
nordic$lifeExp <- as.character(nordic$lifeExp)
nordic$lifeExp <- as.numeric(nordic$lifeExp)
nordic$lifeExp
```

```{.output}
[1] 77.2 80.0 79.0
```

Note: new students find the help files difficult to understand; make sure to let them know
that this is typical, and encourage them to take their best guess based on semantic meaning,
even if they aren't sure.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

When doing statistical modelling, it's important to know what the baseline
levels are. This is assumed to be the first factor, but by default factors are
labeled in alphabetical order. You can change this by specifying the levels:


```r
mydata <- c("case", "control", "control", "case")
factor_ordering_example <- factor(mydata, levels = c("control", "case"))
str(factor_ordering_example)
```

```{.output}
 Factor w/ 2 levels "control","case": 2 1 1 2
```

In this case, we've explicitly told R that "control" should represented by 1,
and "case" by 2. This designation can be very important for interpreting the
results of statistical models!

## Lists

Another data structure you'll want in your bag of tricks is the `list`. A list
is simpler in some ways than the other types, because you can put anything you
want in it:


```r
list_example <- list(1, "a", TRUE, c(2, 6, 7))
list_example
```

```{.output}
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 2 6 7
```

```r
another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE )
another_list
```

```{.output}
$title
[1] "Numbers"

$numbers
 [1]  1  2  3  4  5  6  7  8  9 10

$data
[1] TRUE
```

We can now understand something a bit surprising in our data frame; what happens if we compare `str(nordic)` and `str(another_list)`:


```r
str(nordic)
```

```{.output}
'data.frame':	3 obs. of  3 variables:
 $ country: chr  "Denmark" "Sweden" "Norway"
 $ year   : int  2002 2002 2002
 $ lifeExp: num  77.2 80 79
```

```r
str(another_list)
```

```{.output}
List of 3
 $ title  : chr "Numbers"
 $ numbers: int [1:10] 1 2 3 4 5 6 7 8 9 10
 $ data   : logi TRUE
```

We see that the output for these two objects look very similar. It is because
data frames are lists 'under the hood'. Data frames are a special case of lists where each element (the columns of the data frame) have the same lengths.

In our `nordic` example, we have an integer, a double and a logical variable. As
we have seen already, each column of data frame is a vector.


```r
nordic$country
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

```r
nordic[, 1]
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

```r
class(nordic[, 1])
```

```{.output}
[1] "character"
```

```r
str(nordic[, 1])
```

```{.output}
 chr [1:3] "Denmark" "Sweden" "Norway"
```

Each row is an *observation* of different variables, itself a data frame, and
thus can be composed of elements of different types.


```r
nordic[1, ]
```

```{.output}
  country year lifeExp
1 Denmark 2002    77.2
```

```r
class(nordic[1, ])
```

```{.output}
[1] "data.frame"
```

```r
str(nordic[1, ])
```

```{.output}
'data.frame':	1 obs. of  3 variables:
 $ country: chr "Denmark"
 $ year   : int 2002
 $ lifeExp: num 77.2
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4

There are several subtly different ways to call variables, observations and
elements from data frames:

- `nordic[1]`
- `nordic[[1]]`
- `nordic$country`
- `nordic["country"]`
- `nordic[1, 1]`
- `nordic[, 1]`
- `nordic[1, ]`

Try out these examples and explain what is returned by each one.

*Hint:* Use the function `class()` to examine what is returned in each case.

:::::::::::::::  solution

## Solution to Challenge 4


```r
nordic[1]
```

```{.output}
  country
1 Denmark
2  Sweden
3  Norway
```

We can think of a data frame as a list of vectors. The single brace `[1]`
returns the first slice of the list, as another list. In this case it is the
first column of the data frame.


```r
nordic[[1]]
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

The double brace `[[1]]` returns the contents of the list item. In this case
it is the contents of the first column, a *vector* of type *character*.


```r
nordic$country
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

This example uses the `$` character to address items by name. *country* is the
first column of the data frame, again a *vector* of type *character*.


```r
nordic["country"]
```

```{.output}
  country
1 Denmark
2  Sweden
3  Norway
```

Here we are using a single brace `["country"]` replacing the index number
with the column name. Like example 1, the returned object is a *list*.


```r
nordic[1, 1]
```

```{.output}
[1] "Denmark"
```

This example uses a single brace, but this time we provide row and column
coordinates. The returned object is the value in row 1, column 1. The object
is an *character*: the first value of the first vector in our `nordic` object.


```r
nordic[, 1]
```

```{.output}
[1] "Denmark" "Sweden"  "Norway" 
```

Like the previous example we use single braces and provide row and column
coordinates. The row coordinate is not specified, R interprets this missing
value as all the elements in this *column* *vector*.


```r
nordic[1, ]
```

```{.output}
  country year lifeExp
1 Denmark 2002    77.2
```

Again we use the single brace with row and column coordinates. The column
coordinate is not specified. The return value is a *list* containing all the
values in the first row.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `read.csv` to read tabular data in R.
- The basic data types in R are double, integer, complex, logical, and character.
- Use factors to represent categories in R.

::::::::::::::::::::::::::::::::::::::::::::::::::


