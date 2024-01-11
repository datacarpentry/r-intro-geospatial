---
title: Subsetting Data
teaching: 25
exercises: 10
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to subset vectors and data frames
- To be able to extract individual and multiple elements: by index, by name, using comparison operations
- To be able to skip and remove elements from various data structures.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I work with subsets of data in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



R has many powerful subset operators. Mastering them will allow you to
easily perform complex operations on any kind of dataset.

There are six different ways we can subset any kind of object, and three
different subsetting operators for the different data structures.

Let's start with the workhorse of R: a simple numeric vector.


```r
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
x
```

```{.output}
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Atomic vectors

In R, simple vectors containing character strings, numbers, or logical values
are called *atomic* vectors because they can't be further simplified.


::::::::::::::::::::::::::::::::::::::::::::::::::

So now that we've created a dummy vector to play with, how do we get at its
contents?

## Accessing elements using their indices

To extract elements of a vector we can give their corresponding index, starting
from one:


```r
x[1]
```

```{.output}
  a 
5.4 
```


```r
x[4]
```

```{.output}
  d 
4.8 
```

It may look different, but the square brackets operator is a function. For vectors
(and matrices), it means "get me the nth element".

We can ask for multiple elements at once:


```r
x[c(1, 3)]
```

```{.output}
  a   c 
5.4 7.1 
```

Or slices of the vector:


```r
x[1:4]
```

```{.output}
  a   b   c   d 
5.4 6.2 7.1 4.8 
```

the `:` operator creates a sequence of numbers from the left element to the right.


```r
1:4
```

```{.output}
[1] 1 2 3 4
```

```r
c(1, 2, 3, 4)
```

```{.output}
[1] 1 2 3 4
```

We can ask for the same element multiple times:


```r
x[c(1, 1, 3)]
```

```{.output}
  a   a   c 
5.4 5.4 7.1 
```

If we ask for an index beyond the length of the vector, R will return a missing value:


```r
x[6]
```

```{.output}
<NA> 
  NA 
```

This is a vector of length one containing an `NA`, whose name is also `NA`.

If we ask for the 0th element, we get an empty vector:


```r
x[0]
```

```{.output}
named numeric(0)
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Vector numbering in R starts at 1

In many programming languages (C and Python, for example), the first
element of a vector has an index of 0. In R, the first element is 1.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Skipping and removing elements

If we use a negative number as the index of a vector, R will return
every element *except* for the one specified:


```r
x[-2]
```

```{.output}
  a   c   d   e 
5.4 7.1 4.8 7.5 
```

We can skip multiple elements:


```r
x[c(-1, -5)]  # or x[-c(1,5)]
```

```{.output}
  b   c   d 
6.2 7.1 4.8 
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Order of operations

A common trip up for novices occurs when trying to skip
slices of a vector. It's natural to to try to negate a
sequence like so:


```r
x[-1:3]
```

This gives a somewhat cryptic error:


```{.error}
Error in x[-1:3]: only 0's may be mixed with negative subscripts
```

But remember the order of operations. `:` is really a function.
It takes its first argument as -1, and its second as 3,
so generates the sequence of numbers: `c(-1, 0, 1, 2, 3)`.

The correct solution is to wrap that function call in brackets, so
that the `-` operator applies to the result:


```r
x[-(1:3)]
```

```{.output}
  d   e 
4.8 7.5 
```

::::::::::::::::::::::::::::::::::::::::::::::::::

To remove elements from a vector, we need to assign the result back
into the variable:


```r
x <- x[-4]
x
```

```{.output}
  a   b   c   e 
5.4 6.2 7.1 7.5 
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Given the following code:


```r
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
print(x)
```

```{.output}
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 
```

Come up with at least 3 different commands that will produce the following output:


```{.output}
  b   c   d 
6.2 7.1 4.8 
```

After you find 3 different commands, compare notes with your neighbour. Did you have different strategies?

:::::::::::::::  solution

## Solution to challenge 1


```r
x[2:4]
```

```{.output}
  b   c   d 
6.2 7.1 4.8 
```


```r
x[-c(1,5)]
```

```{.output}
  b   c   d 
6.2 7.1 4.8 
```


```r
x[c("b", "c", "d")]
```

```{.output}
  b   c   d 
6.2 7.1 4.8 
```


```r
x[c(2,3,4)]
```

```{.output}
  b   c   d 
6.2 7.1 4.8 
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Subsetting by name

We can extract elements by using their name, instead of extracting by index:


```r
x <- c(a = 5.4, b = 6.2, c = 7.1, d = 4.8, e = 7.5) # we can name a vector 'on the fly'
x[c("a", "c")]
```

```{.output}
  a   c 
5.4 7.1 
```

This is usually a much more reliable way to subset objects: the
position of various elements can often change when chaining together
subsetting operations, but the names will always remain the same!

## Subsetting through other logical operations

We can also use any logical vector to subset:


```r
x[c(FALSE, FALSE, TRUE, FALSE, TRUE)]
```

```{.output}
  c   e 
7.1 7.5 
```

Since comparison operators (e.g. `>`, `<`, `==`) evaluate to logical vectors, we can also
use them to succinctly subset vectors: the following statement gives
the same result as the previous one.


```r
x[x > 7]
```

```{.output}
  c   e 
7.1 7.5 
```

Breaking it down, this statement first evaluates `x>7`, generating
a logical vector `c(FALSE, FALSE, TRUE, FALSE, TRUE)`, and then
selects the elements of `x` corresponding to the `TRUE` values.

We can use `==` to mimic the previous method of indexing by name
(remember you have to use `==` rather than `=` for comparisons):


```r
x[names(x) == "a"]
```

```{.output}
  a 
5.4 
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Combining logical conditions

We often want to combine multiple logical
criteria. For example, we might want to find all the countries that are
located in Asia **or** Europe **and** have life expectancies within a certain
range. Several operations for combining logical vectors exist in R:

- `&`, the "logical AND" operator: returns `TRUE` if both the left and right
  are `TRUE`.
- `|`, the "logical OR" operator: returns `TRUE`, if either the left or right
  (or both) are `TRUE`.

You may sometimes see `&&` and `||` instead of `&` and `|`. These two-character operators
only look at the first element of each vector and ignore the
remaining elements. In general you should not use the two-character
operators in data analysis; save them
for programming, i.e. deciding whether to execute a statement.

- `!`, the "logical NOT" operator: converts `TRUE` to `FALSE` and `FALSE` to
  `TRUE`. It can negate a single logical condition (eg `!TRUE` becomes
  `FALSE`), or a whole vector of conditions(eg `!c(TRUE, FALSE)` becomes
  `c(FALSE, TRUE)`).

Additionally, you can compare the elements within a single vector using the
`all` function (which returns `TRUE` if every element of the vector is `TRUE`)
and the `any` function (which returns `TRUE` if one or more elements of the
vector are `TRUE`).


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Given the following code:


```r
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
print(x)
```

```{.output}
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 
```

Write a subsetting command to return the values in x that are greater than 4 and less than 7.

:::::::::::::::  solution

## Solution to challenge 2


```r
x_subset <- x[x<7 & x>4]
print(x_subset)
```

```{.output}
  a   b   d 
5.4 6.2 4.8 
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Getting help for operators

Remember you can search for help on operators by wrapping them in quotes:
`help("%in%")` or `?"%in%"`.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Handling special values

At some point you will encounter functions in R that cannot handle missing, infinite,
or undefined data.

There are a number of special functions you can use to filter out this data:

- `is.na` will return all positions in a vector, matrix, or data frame
  containing `NA` (or `NaN`)
- likewise, `is.nan`, and `is.infinite` will do the same for `NaN` and `Inf`.
- `is.finite` will return all positions in a vector, matrix, or data.frame
  that do not contain `NA`, `NaN` or `Inf`.
- `na.omit` will filter out all missing values from a vector
  

::::::::::::::::::::::::::::::::::::::::::::::::::

## Data frames

:::::::::::::::::::::::::::::::::::::::::  instructor

The episode after this one covers the `dplyr` package, which has an alternate 
subsetting mechanism. Learners do still need to learn the base R subsetting 
covered here, as `dplyr` won't work in all situations. However, the examples in 
the rest of the workshop focus on `dplyr` syntax.

:::::::::::::::::::::::::::::::::::::::::

Remember the data frames are lists underneath the hood, so similar rules
apply. However they are also two dimensional objects:

`[` with one argument will act the same way as for lists, where each list
element corresponds to a column. The resulting object will be a data frame:


```r
head(gapminder[3])
```

```{.output}
       pop
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
```

Similarly, `[[` will act to extract *a single column*:


```r
head(gapminder[["lifeExp"]])
```

```{.output}
[1] 28.801 30.332 31.997 34.020 36.088 38.438
```

And `$` provides a convenient shorthand to extract columns by name:


```r
head(gapminder$year)
```

```{.output}
[1] 1952 1957 1962 1967 1972 1977
```

To select specific rows and/or columns, you can provide two arguments to `[`


```r
gapminder[1:3, ]
```

```{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
```

If we subset a single row, the result will be a data frame (because
the elements are mixed types):


```r
gapminder[3, ]
```

```{.output}
      country year      pop continent lifeExp gdpPercap
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
```

But for a single column the result will be a vector (this can be changed with
the third argument, `drop = FALSE`).

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Fix each of the following common data frame subsetting errors:

1. Extract observations collected for the year 1957
  
  
  ```r
  gapminder[gapminder$year = 1957, ]
  ```

2. Extract all columns except 1 through to 4
  
  
  ```r
  gapminder[, -1:4]
  ```

3. Extract the rows where the life expectancy is longer the 80 years
  
  
  ```r
  gapminder[gapminder$lifeExp > 80]
  ```

4. Extract the first row, and the fourth and fifth columns
  (`lifeExp` and `gdpPercap`).
  
  
  ```r
  gapminder[1, 4, 5]
  ```

5. Advanced: extract rows that contain information for the years 2002
  and 2007
  
  
  ```r
  gapminder[gapminder$year == 2002 | 2007,]
  ```

:::::::::::::::  solution

## Solution to challenge 3

Fix each of the following common data frame subsetting errors:

1. Extract observations collected for the year 1957
  
  
  ```r
  # gapminder[gapminder$year = 1957, ]
  gapminder[gapminder$year == 1957, ]
  ```

2. Extract all columns except 1 through to 4
  
  
  ```r
  # gapminder[, -1:4]
  gapminder[,-c(1:4)]
  ```

3. Extract the rows where the life expectancy is longer the 80 years
  
  
  ```r
  # gapminder[gapminder$lifeExp > 80]
  gapminder[gapminder$lifeExp > 80,]
  ```

4. Extract the first row, and the fourth and fifth columns
  (`lifeExp` and `gdpPercap`).
  
  
  ```r
  # gapminder[1, 4, 5]
  gapminder[1, c(4, 5)]
  ```

5. Advanced: extract rows that contain information for the years 2002
  and 2007
  
  
  ```r
  # gapminder[gapminder$year == 2002 | 2007,]
  gapminder[gapminder$year == 2002 | gapminder$year == 2007,]
  gapminder[gapminder$year %in% c(2002, 2007),]
  ```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4

1. Why does `gapminder[1:20]` return an error? How does it differ from
  `gapminder[1:20, ]`?

2. Create a new `data.frame` called `gapminder_small` that only contains rows
  1 through 9 and 19 through 23. You can do this in one or two steps.

:::::::::::::::  solution

## Solution to challenge 4

1. `gapminder` is a data.frame so it needs to be subsetted on two dimensions. `gapminder[1:20, ]` subsets the data to give the first 20 rows and all columns.

2. 

```r
gapminder_small <- gapminder[c(1:9, 19:23),]
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Indexing in R starts at 1, not 0.
- Access individual values by location using `[]`.
- Access slices of data using `[low:high]`.
- Access arbitrary sets of data using `[c(...)]`.
- Use logical operations and logical vectors to access subsets of data.

::::::::::::::::::::::::::::::::::::::::::::::::::


