---
title: "Data Structures"
teaching: 40
exercises: 15
questions:
- "How can I read data in R?"
- "What are the basic data types in R?"
- "How do I represent categorical information in R?"
objectives:
- "To be aware of the different types of data."
- "To begin exploring data frames, and understand how they are related to vectors, factors and lists."
- "To be able to ask questions from R about the type, class, and structure of an object."
keypoints:
- "Use `read.csv` to read tabular data in R."
- "The basic data types in R are double, integer, complex, logical, and character."
- "Use factors to represent categories in R."
source: Rmd
---

```{r, include=FALSE}
source("../bin/chunk-options.R")
knitr_fig_path("03-")
```

One of R's most powerful features is its ability to deal with tabular data -
such as you may already have in a spreadsheet or a CSV file. Let's start by
downloading and reading in a file `nordic-data.csv`. We will
save this data as an object named `nordic`:

```{r}
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

```{r}
nordic$country
nordic$lifeExp
```

We can do other operations on the columns. For example, if we discovered that the life expectancy is two years higher: 

```{r}
nordic$lifeExp + 2
```

But what about:

```{r}
nordic$lifeExp + nordic$country
```

Understanding what happened here is key to successfully analyzing data in R.

## Data Types

If you guessed that the last command will return an error because `77.2` plus
`"Denmark"` is nonsense, you're right - and you already have some intuition for an
important concept in programming called *data classes*. We can ask what class of
data something is:

```{r}
class(nordic$lifeExp)
```

There are 6 main types: `numeric`, `integer`, `complex`, `logical`, `character`, and `factor`.

```{r}
class(3.14)
class(1L) # The L suffix forces the number to be an integer, since by default R uses float numbers
class(1+1i)
class(TRUE)
class('banana')
class(factor('banana'))
```

No matter how
complicated our analyses become, all data in R is interpreted a specific 
data class. This strictness has some really important consequences.

A user has added new details of age expectancy. This information is in the file
`data/nordic-monarchy-data-2.csv`.

Load the new nordic data as `nordic_2`, and check what class of data we find in the
`lifeExp` column:

```{r}
nordic_2 <- read.csv("data/nordic-data-2.csv")
class(nordic_2$lifeExp)
```

Oh no, our life expectancy lifeExp aren't the numeric type anymore! If we try to do the same math
we did on them before, we run into trouble:

```{r}
nordic_2$lifeExp + 2
```

What happened? When R reads a csv file into one of these tables, it insists that
everything in a column be the same class; if it can't understand
*everything* in the column as numeric, then *nothing* in the column gets to be numeric. The table that R loaded our nordic data into is something called a
dataframe, and it is our first example of something called a *data
structure* - that is, a structure which R knows how to build out of the basic
data types.

We can see that it is a dataframe by calling the `class()` function on it:

```{r}
class(nordic)
```

In order to successfully use our data in R, we need to understand what the basic
data structures are, and how they behave. 

## Vectors and Type Coercion

To better understand this behavior, let's meet another of the data structures:
the vector.

```{r}
my_vector <- vector(length = 3)
my_vector
```

A vector in R is essentially an ordered list of things, with the special
condition that everything in the vector must be the same basic data type. If
you don't choose the data type, it'll default to `logical`; or, you can declare
an empty vector of whatever type you like.

```{r}
another_vector <- vector(mode = 'character', length = 3)
another_vector
```

You can check if something is a vector:

```{r}
str(another_vector)
```

The somewhat cryptic output from this command indicates the basic data type
found in this vector - in this case `chr`, character; an indication of the
number of things in the vector - actually, the indexes of the vector, in this
case `[1:3]`; and a few examples of what's actually in the vector - in this case
empty character strings. If we similarly do

```{r}
str(nordic$lifeExp)
```

we see that `nordic$lifeExp` is a vector, too - the columns of data we load into R
data frames are all vectors, and that's the root of why R forces everything in
a column to be the same basic data type.

> ## Discussion 1
>
> Why is R so opinionated about what we put in our columns of data?
> How does this help us?
>
> > ## Discussion 1
> >
> > By keeping everything in a column the same, we allow ourselves to make simple
> > assumptions about our data; if you can interpret one entry in the column as a
> > number, then you can interpret *all* of them as numbers, so we don't have to
> > check every time. This consistency is what people mean when they talk about
> > *clean data*; in the long run, strict consistency goes a long way to making
> > our lives easier in R.
> {: .solution}
{: .discussion}

You can also make vectors with explicit contents with the combine function:

```{r}
combine_vector <- c(2, 6, 3)
combine_vector
```

Given what we've learned so far, what do you think the following will produce?

```{r}
quiz_vector <- c(2, 6, '3')
```

This is something called *type coercion*, and it is the source of many surprises
and the reason why we need to be aware of the basic data types and how R will
interpret them. When R encounters a mix of types (here numeric and character) to
be combined into a single vector, it will force them all to be the same
type. Consider:

```{r}
coercion_vector <- c('a', TRUE)
coercion_vector
another_coercion_vector <- c(0, TRUE)
another_coercion_vector
```

The coercion rules go: `logical` -> `integer` -> `numeric` -> `complex` ->
`character`, where -> can be read as *are transformed into*. You can try to
force coercion against this flow using the `as.` functions:

```{r}
character_vector_example <- c('0', '2', '4')
character_vector_example
character_coerced_to_numeric <- as.numeric(character_vector_example)
character_coerced_to_numeric
numeric_coerced_to_logical <- as.logical(character_coerced_to_numeric)
numeric_coerced_to_logical
```

As you can see, some surprising things can happen when R forces one basic data
type into another! Nitty-gritty of type coercion aside, the point is: if your
data doesn't look like what you thought it was going to look like, type coercion
may well be to blame; make sure everything is the same type in your vectors and
your columns of data frames, or you will get nasty surprises!

> ## Challenge 1
> 
> Given what you now know about type conversion, look at the class of
> data in `nordic_2$lifeExp` and compare it with `nordic$lifeExp`. Why are
> these columns different classes? 
> 
> > ## Solution
> > ```{r}
> > str(nordic_2$lifeExp)
> > str(nordic$lifeExp)
> > ```
> > The data in `nordic_2$lifeExp` is stored as factors rather than 
> > numeric. This is because of the "or" character string in the third 
> > data point. "Factor" is R's special term for categorical data. 
> > We will be working more with factor data later in this workshop.
> {: .solution}
{: .challenge}

The combine function, `c()`, will also append things to an existing vector:

```{r}
ab_vector <- c('a', 'b')
ab_vector
combine_example <- c(ab_vector, 'DC')
combine_example
```

You can also make series of numbers:

```{r}
my_series <- 1:10
my_series
seq(10)
seq(1,10, by = 0.1)
```

We can ask a few questions about vectors:

```{r}
sequence_example <- seq(10)
head(sequence_example,n = 2)
tail(sequence_example, n = 4)
length(sequence_example)
class(sequence_example)
```

Finally, you can give names to elements in your vector:

```{r}
my_example <- 5:8
names(my_example) <- c("a", "b", "c", "d")
my_example
names(my_example)
```

> ## Challenge 2
>
> Start by making a vector with the numbers 1 through 26.
> Multiply the vector by 2, and give the resulting vector
> names A through Z (hint: there is a built in vector called `LETTERS`)
>
> > ## Solution to Challenge 2
> >
> > ```{r}
> > x <- 1:26
> > x <- x * 2
> > names(x) <- LETTERS
> > ```
> {: .solution}
{: .challenge}


## Factors

We said that columns in data frames were vectors:

```{r}
str(nordic$lifeExp)
str(nordic$year)
```

These make sense. But what about

```{r}
str(nordic$country)
```

Another important data structure is called a factor. Factors look like character
data, but are used to represent categorical information. For example, let's make
a vector of strings labeling nordic countries for all the countries in our
study:

```{r}
nordic_countries <- c('Norway', 'Finland', 'Denmark', 'Iceland', 'Sweden')
nordic_countries
str(nordic_countries)
```

We can turn a vector into a factor like so:

```{r}
categories <- factor(nordic_countries)
class(categories)
str(categories)
```

Now R has noticed that there are 5 possible categories in our data - but it
also did something surprising; instead of printing out the strings we gave it,
we got a bunch of numbers instead. R has replaced our human-readable categories
with numbered indices under the hood, this is necessary as many statistical
calculations utilise such numerical representations for categorical data:

```{r}
class(nordic_countries)
class(categories)
```

> ## Challenge
>
> Can you guess why these numbers are used to represent these countries?
>
>> ## Solution
>> 
>> They are sorted in alphabetical order
> {: .solution}
{: .challenge}

> ## Challenge 3
>
> Is there a factor in our `nordic` data frame? what is its name? Try using
> `?read.csv` to figure out how to keep text columns as character vectors
> instead of factors; then write a command or two to show that the factor in
> `nordic` is actually a character vector when loaded in this way.
>
> > ## Solution to Challenge 3
> >
> > One solution is use the argument `stringAsFactors`:
> >
> > ```{r, eval = FALSE}
> > nordic <- read.csv(file = "data/nordic-data.csv", stringsAsFactors = FALSE)
> > str(nordic$country)
> > ```
> >
> > Another solution is use the argument `colClasses`
> > that allow finer control.
> >
> > ```{r, eval = FALSE}
> > nordic <- read.csv(file="data/nordic-data.csv", colClasses=c(NA, NA, "character"))
> > str(nordic$country)
> > ```
> >
> > Note: new students find the help files difficult to understand; make sure to let them know
> > that this is typical, and encourage them to take their best guess based on semantic meaning,
> > even if they aren't sure.
> {: .solution}
{: .challenge}

When doing statistical modelling, it's important to know what the baseline
levels are. This is assumed to be the first factor, but by default factors are
labeled in alphabetical order. You can change this by specifying the levels:

```{r}
mydata <- c("case", "control", "control", "case")
factor_ordering_example <- factor(mydata, levels = c("control", "case"))
str(factor_ordering_example)
```

In this case, we've explicitly told R that "control" should represented by 1,
and "case" by 2. This designation can be very important for interpreting the
results of statistical models!

## Lists

Another data structure you'll want in your bag of tricks is the `list`. A list
is simpler in some ways than the other types, because you can put anything you
want in it:

```{r}
list_example <- list(1, "a", TRUE, c(2, 6, 7))
list_example
another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE )
another_list
```

We can now understand something a bit surprising in our data frame; what happens if we compare `str(nordic)` and `str(another_list)`:

```{r}
str(nordic)
str(another_list)
```

We see that the output for these two objects look very similar. It is because
data frames are lists 'under the hood'. Data frames are a special case of lists where each element (the columns of the data frame) have the same lengths.

In our `nordic` example, we have an integer, a double and a logical variable. As
we have seen already, each column of data frame is a vector.

```{r}
nordic$country
nordic[, 1]
class(nordic[, 1])
str(nordic[, 1])
```

Each row is an *observation* of different variables, itself a data frame, and
thus can be composed of elements of different types.

```{r}
nordic[1, ]
class(nordic[1, ])
str(nordic[1, ])
```

> ## Challenge 4
>
> There are several subtly different ways to call variables, observations and
> elements from data frames:
>
> - `nordic[1]`
> - `nordic[[1]]`
> - `nordic$country`
> - `nordic["country"]`
> - `nordic[1, 1]`
> - `nordic[, 1]`
> - `nordic[1, ]`
>
> Try out these examples and explain what is returned by each one.
>
> *Hint:* Use the function `class()` to examine what is returned in each case.
>
> > ## Solution to Challenge 4
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic[1]
> > ```
> >
> > We can think of a data frame as a list of vectors. The single brace `[1]`
> > returns the first slice of the list, as another list. In this case it is the
> > first column of the data frame.
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic[[1]]
> > ```
> >
> > The double brace `[[1]]` returns the contents of the list item. In this case
> > it is the contents of the first column, a _vector_ of type _factor_.
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic$country
> > ```
> >
> > This example uses the `$` character to address items by name. _coat_ is the
> > first column of the data frame, again a _vector_ of type _factor_.
> X
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic["country"]
> > ```
> > Here we are using a single brace `["country"]` replacing the index number
> > with the column name. Like example 1, the returned object is a _list_.
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic[1, 1]
> > ```
> >
> > This example uses a single brace, but this time we provide row and column
> coordinates. The returned object is the value in row 1, column 1. The object
> is an _integer_ but because it is part of a _vector_ of type _factor_, R
> displays the label "Denmark" associated with the integer value.
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic[, 1]
> > ```
> >
> > Like the previous example we use single braces and provide row and column
> > coordinates. The row coordinate is not specified, R interprets this missing
> > value as all the elements in this _column_ _vector_.
> >
> > ```{r, eval=TRUE, echo=TRUE}
> > nordic[1, ]
> > ```
> >
> > Again we use the single brace with row and column coordinates. The column
> > coordinate is not specified. The return value is a _list_ containing all the
> > values in the first row.
> {: .solution}
{: .challenge}
