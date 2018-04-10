---
title: Subsetting Data
teaching: 35
exercises: 15
questions:
- "How can I work with subsets of data in R?"
objectives:
- "To be able to subset vectors, lists and data frames"
- "To be able to extract individual and multiple elements: by index, by name, using comparison operations"
- "To be able to skip and remove elements from various data structures."
keypoints:
- "Indexing in R starts at 1, not 0."
- "Access individual values by location using `[]`."
- "Access slices of data using `[low:high]`."
- "Access arbitrary sets of data using `[c(...)]`."
- "Use logical operations and logical vectors to access subsets of data."
source: Rmd
---



R has many powerful subset operators. Mastering them will allow you to
easily perform complex operations on any kind of dataset.

There are six different ways we can subset any kind of object, and three
different subsetting operators for the different data structures.

Let's start with the workhorse of R: a simple numeric vector.


~~~
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
x
~~~
{: .language-r}



~~~
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 
~~~
{: .output}

> ## Atomic vectors
>
> In R, simple vectors containing character strings, numbers, or logical values are called *atomic* vectors because they can't be further simplified.
{: .callout}

So now that we've created a dummy vector to play with, how do we get at its
contents?

## Accessing elements using their indices

To extract elements of a vector we can give their corresponding index, starting
from one:


~~~
x[1]
~~~
{: .language-r}



~~~
  a 
5.4 
~~~
{: .output}


~~~
x[4]
~~~
{: .language-r}



~~~
  d 
4.8 
~~~
{: .output}

It may look different, but the square brackets operator is a function. For vectors
(and matrices), it means "get me the nth element".

We can ask for multiple elements at once:


~~~
x[c(1, 3)]
~~~
{: .language-r}



~~~
  a   c 
5.4 7.1 
~~~
{: .output}

Or slices of the vector:


~~~
x[1:4]
~~~
{: .language-r}



~~~
  a   b   c   d 
5.4 6.2 7.1 4.8 
~~~
{: .output}

the `:` operator creates a sequence of numbers from the left element to the right.

~~~
1:4
~~~
{: .language-r}



~~~
[1] 1 2 3 4
~~~
{: .output}



~~~
c(1, 2, 3, 4)
~~~
{: .language-r}



~~~
[1] 1 2 3 4
~~~
{: .output}


We can ask for the same element multiple times:


~~~
x[c(1,1,3)]
~~~
{: .language-r}



~~~
  a   a   c 
5.4 5.4 7.1 
~~~
{: .output}

If we ask for an index beyond the length of the vector, R will return a missing value:

~~~
x[6]
~~~
{: .language-r}



~~~
<NA> 
  NA 
~~~
{: .output}

This is a vector of length one containing an `NA`, whose name is also `NA`.

If we ask for the 0th element, we get an empty vector:


~~~
x[0]
~~~
{: .language-r}



~~~
named numeric(0)
~~~
{: .output}

> ## Vector numbering in R starts at 1
>
> In many programming languages (C and Python, for example), the first
> element of a vector has an index of 0. In R, the first element is 1.
{: .callout}

## Skipping and removing elements

If we use a negative number as the index of a vector, R will return
every element *except* for the one specified:


~~~
x[-2]
~~~
{: .language-r}



~~~
  a   c   d   e 
5.4 7.1 4.8 7.5 
~~~
{: .output}

We can skip multiple elements:


~~~
x[c(-1, -5)]  # or x[-c(1,5)]
~~~
{: .language-r}



~~~
  b   c   d 
6.2 7.1 4.8 
~~~
{: .output}

> ## Tip: Order of operations
>
> A common trip up for novices occurs when trying to skip
> slices of a vector. It's natural to to try to negate a
> sequence like so:
>
> 
> ~~~
> x[-1:3]
> ~~~
> {: .language-r}
>
> This gives a somewhat cryptic error:
>
> 
> ~~~
> Error in x[-1:3]: only 0's may be mixed with negative subscripts
> ~~~
> {: .error}
>
> But remember the order of operations. `:` is really a function.
> It takes its first argument as -1, and its second as 3,
> so generates the sequence of numbers: `c(-1, 0, 1, 2, 3)`.
>
> The correct solution is to wrap that function call in brackets, so
> that the `-` operator applies to the result:
>
> 
> ~~~
> x[-(1:3)]
> ~~~
> {: .language-r}
> 
> 
> 
> ~~~
>   d   e 
> 4.8 7.5 
> ~~~
> {: .output}
{: .callout}


To remove elements from a vector, we need to assign the result back
into the variable:


~~~
x <- x[-4]
x
~~~
{: .language-r}



~~~
  a   b   c   e 
5.4 6.2 7.1 7.5 
~~~
{: .output}

> ## Challenge 1
>
> Given the following code:
>
> 
> ~~~
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> {: .language-r}
> 
> 
> 
> ~~~
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> {: .output}
>
> Come up with at least 3 different commands that will produce the following output:
>
> 
> ~~~
>   b   c   d 
> 6.2 7.1 4.8 
> ~~~
> {: .output}
>
> After you find 3 different commands, compare notes with your neighbour. Did you have different strategies?
>
> > ## Solution to challenge 1
> >
> > 
> > ~~~
> > x[2:4]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> >   b   c   d 
> > 6.2 7.1 4.8 
> > ~~~
> > {: .output}
> > 
> > ~~~
> > x[-c(1,5)]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> >   b   c   d 
> > 6.2 7.1 4.8 
> > ~~~
> > {: .output}
> > 
> > ~~~
> > x[c("b", "c", "d")]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> >   b   c   d 
> > 6.2 7.1 4.8 
> > ~~~
> > {: .output}
> > 
> > ~~~
> > x[c(2,3,4)]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> >   b   c   d 
> > 6.2 7.1 4.8 
> > ~~~
> > {: .output}
> >
> {: .solution}
{: .challenge}

## Subsetting by name

We can extract elements by using their name, instead of extracting by index:


~~~
x <- c(a=5.4, b=6.2, c=7.1, d=4.8, e=7.5) # we can name a vector 'on the fly'
x[c("a", "c")]
~~~
{: .language-r}



~~~
  a   c 
5.4 7.1 
~~~
{: .output}

This is usually a much more reliable way to subset objects: the
position of various elements can often change when chaining together
subsetting operations, but the names will always remain the same!

## Subsetting through other logical operations

We can also use any logical vector to subset:


~~~
x[c(FALSE, FALSE, TRUE, FALSE, TRUE)]
~~~
{: .language-r}



~~~
  c   e 
7.1 7.5 
~~~
{: .output}

Since comparison operators (e.g. `>`, `<`, `==`) evaluate to logical vectors, we can also
use them to succinctly subset vectors: the following statement gives
the same result as the previous one.


~~~
x[x > 7]
~~~
{: .language-r}



~~~
  c   e 
7.1 7.5 
~~~
{: .output}

Breaking it down, this statement first evaluates `x>7`, generating
a logical vector `c(FALSE, FALSE, TRUE, FALSE, TRUE)`, and then
selects the elements of `x` corresponding to the `TRUE` values.

We can use `==` to mimic the previous method of indexing by name
(remember you have to use `==` rather than `=` for comparisons):


~~~
x[names(x) == "a"]
~~~
{: .language-r}



~~~
  a 
5.4 
~~~
{: .output}

> ## Tip: Combining logical conditions
>
> We often want to combine multiple logical
> criteria. For example, we might want to find all the countries that are
> located in Asia **or** Europe **and** have life expectancies within a certain
> range. Several operations for combining logical vectors exist in R:
>
>  * `&`, the "logical AND" operator: returns `TRUE` if both the left and right
>    are `TRUE`.
>  * `|`, the "logical OR" operator: returns `TRUE`, if either the left or right
>    (or both) are `TRUE`.
>
> You may sometimes see `&&` and `||` instead of `&` and `|`. These two-character operators
> only look at the first element of each vector and ignore the
> remaining elements. In general you should not use the two-character
> operators in data analysis; save them
> for programming, i.e. deciding whether to execute a statement.
>
>  * `!`, the "logical NOT" operator: converts `TRUE` to `FALSE` and `FALSE` to
>    `TRUE`. It can negate a single logical condition (eg `!TRUE` becomes
>    `FALSE`), or a whole vector of conditions(eg `!c(TRUE, FALSE)` becomes
>    `c(FALSE, TRUE)`).
>
> Additionally, you can compare the elements within a single vector using the
> `all` function (which returns `TRUE` if every element of the vector is `TRUE`)
> and the `any` function (which returns `TRUE` if one or more elements of the
> vector are `TRUE`).
{: .callout}

> ## Challenge 2
>
> Given the following code:
>
> 
> ~~~
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> {: .language-r}
> 
> 
> 
> ~~~
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> {: .output}
>
> Write a subsetting command to return the values in x that are greater than 4 and less than 7.
>
> > ## Solution to challenge 2
> >
> > 
> > ~~~
> > x_subset <- x[x<7 & x>4]
> > print(x_subset)
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> >   a   b   d 
> > 5.4 6.2 4.8 
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}


> ## Tip: Non-unique names
>
> You should be aware that it is possible for multiple elements in a
> vector to have the same name. (For a data frame, columns can have
> the same name --- although R tries to avoid this --- but row names
> must be unique.) Consider these examples:
>
>
>~~~
> x <- 1:3
> x
>~~~
>{: .language-r}
>
>
>
>~~~
>[1] 1 2 3
>~~~
>{: .output}
>
>
>
>~~~
> names(x) <- c('a', 'a', 'a')
> x
>~~~
>{: .language-r}
>
>
>
>~~~
>a a a 
>1 2 3 
>~~~
>{: .output}
>
>
>
>~~~
> x['a']  # only returns first value
>~~~
>{: .language-r}
>
>
>
>~~~
>a 
>1 
>~~~
>{: .output}
>
>
>
>~~~
> x[names(x) == 'a']  # returns all three values
>~~~
>{: .language-r}
>
>
>
>~~~
>a a a 
>1 2 3 
>~~~
>{: .output}
{: .callout}

> ## Tip: Getting help for operators
>
> Remember you can search for help on operators by wrapping them in quotes:
> `help("%in%")` or `?"%in%"`.
>
{: .callout}


> ## Handling special values
> At some point you will encounter functions in R that cannot handle missing, infinite,
> or undefined data.

> There are a number of special functions you can use to filter out this data:
>
> * `is.na` will return all positions in a vector, matrix, or data.frame
>   containing `NA` (or `NaN`)
> * likewise, `is.nan`, and `is.infinite` will do the same for `NaN` and `Inf`.
> * `is.finite` will return all positions in a vector, matrix, or data.frame
>   that do not contain `NA`, `NaN` or `Inf`.
> * `na.omit` will filter out all missing values from a vector
{: .callout}

## List subsetting

Now we'll introduce some new subsetting operators. There are three functions
used to subset lists. We've already seen these when learning about atomic vectors and matrices:  `[`, `[[`, and `$`.

Using `[` will always return a list. If you want to *subset* a list, but not
*extract* an element, then you will likely use `[`.


~~~
xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris))
xlist[1]
~~~
{: .language-r}



~~~
$a
[1] "Software Carpentry"
~~~
{: .output}

This returns a *list with one element*.

We can subset elements of a list exactly the same way as atomic
vectors using `[`. Comparison operations however won't work as
they're not recursive, they will try to condition on the data structures
in each element of the list, not the individual elements within those
data structures.


~~~
xlist[1:2]
~~~
{: .language-r}



~~~
$a
[1] "Software Carpentry"

$b
 [1]  1  2  3  4  5  6  7  8  9 10
~~~
{: .output}

To extract individual elements of a list, you need to use the double-square
bracket function: `[[`.


~~~
xlist[[1]]
~~~
{: .language-r}



~~~
[1] "Software Carpentry"
~~~
{: .output}

Notice that now the result is a vector, not a list.

You can't extract more than one element at once:


~~~
xlist[[1:2]]
~~~
{: .language-r}



~~~
Error in xlist[[1:2]]: subscript out of bounds
~~~
{: .error}

Nor use it to skip elements:


~~~
xlist[[-1]]
~~~
{: .language-r}



~~~
Error in xlist[[-1]]: attempt to select more than one element in get1index <real>
~~~
{: .error}

But you can use names to both subset and extract elements:


~~~
xlist[["a"]]
~~~
{: .language-r}



~~~
[1] "Software Carpentry"
~~~
{: .output}

The `$` function is a shorthand way for extracting elements by name:


~~~
xlist$data
~~~
{: .language-r}



~~~
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
~~~
{: .output}

> ## Challenge 5
> Given the following list:
>
> 
> ~~~
> xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris))
> ~~~
> {: .language-r}
>
> Using your knowledge of both list and vector subsetting, extract the number 2 from xlist.
> Hint: the number 2 is contained within the "b" item in the list.
>
> > ## Solution to challenge 5
> >
> > 
> > ~~~
> > xlist$b[2]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> > [1] 2
> > ~~~
> > {: .output}
> > 
> > ~~~
> > xlist[[2]][2]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> > [1] 2
> > ~~~
> > {: .output}
> > 
> > ~~~
> > xlist[["b"]][2]
> > ~~~
> > {: .language-r}
> > 
> > 
> > 
> > ~~~
> > [1] 2
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}


## Data frames

Remember the data frames are lists underneath the hood, so similar rules
apply. However they are also two dimensional objects:

`[` with one argument will act the same way as for lists, where each list
element corresponds to a column. The resulting object will be a data frame:


~~~
head(gapminder[3])
~~~
{: .language-r}



~~~
       pop
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
~~~
{: .output}

Similarly, `[[` will act to extract *a single column*:


~~~
head(gapminder[["lifeExp"]])
~~~
{: .language-r}



~~~
[1] 28.801 30.332 31.997 34.020 36.088 38.438
~~~
{: .output}

And `$` provides a convenient shorthand to extract columns by name:


~~~
head(gapminder$year)
~~~
{: .language-r}



~~~
[1] 1952 1957 1962 1967 1972 1977
~~~
{: .output}

With two arguments, `[` behaves the same way as for matrices:


~~~
gapminder[1:3,]
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~
{: .output}

If we subset a single row, the result will be a data frame (because
the elements are mixed types):


~~~
gapminder[3,]
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~
{: .output}

But for a single column the result will be a vector (this can
be changed with the third argument, `drop = FALSE`).

> ## Challenge 7
>
> Fix each of the following common data frame subsetting errors:
>
> 1. Extract observations collected for the year 1957
>
>    
>    ~~~
>    gapminder[gapminder$year = 1957,]
>    ~~~
>    {: .language-r}
>
> 2. Extract all columns except 1 through to 4
>
>    
>    ~~~
>    gapminder[,-1:4]
>    ~~~
>    {: .language-r}
>
> 3. Extract the rows where the life expectancy is longer the 80 years
>
>    
>    ~~~
>    gapminder[gapminder$lifeExp > 80]
>    ~~~
>    {: .language-r}
>
> 4. Extract the first row, and the fourth and fifth columns
>   (`lifeExp` and `gdpPercap`).
>
>    
>    ~~~
>    gapminder[1, 4, 5]
>    ~~~
>    {: .language-r}
>
> 5. Advanced: extract rows that contain information for the years 2002
>    and 2007
>
>    
>    ~~~
>    gapminder[gapminder$year == 2002 | 2007,]
>    ~~~
>    {: .language-r}
>
> > ## Solution to challenge 7
> >
> > Fix each of the following common data frame subsetting errors:
> >
> > 1. Extract observations collected for the year 1957
> >
> >    
> >    ~~~
> >    # gapminder[gapminder$year = 1957,]
> >    gapminder[gapminder$year == 1957,]
> >    ~~~
> >    {: .language-r}
> >
> > 2. Extract all columns except 1 through to 4
> >
> >    
> >    ~~~
> >    # gapminder[,-1:4]
> >    gapminder[,-c(1:4)]
> >    ~~~
> >    {: .language-r}
> >
> > 3. Extract the rows where the life expectancy is longer the 80 years
> >
> >    
> >    ~~~
> >    # gapminder[gapminder$lifeExp > 80]
> >    gapminder[gapminder$lifeExp > 80,]
> >    ~~~
> >    {: .language-r}
> >
> > 4. Extract the first row, and the fourth and fifth columns
> >   (`lifeExp` and `gdpPercap`).
> >
> >    
> >    ~~~
> >    # gapminder[1, 4, 5]
> >    gapminder[1, c(4, 5)]
> >    ~~~
> >    {: .language-r}
> >
> > 5. Advanced: extract rows that contain information for the years 2002
> >    and 2007
> >
> >     
> >     ~~~
> >     # gapminder[gapminder$year == 2002 | 2007,]
> >     gapminder[gapminder$year == 2002 | gapminder$year == 2007,]
> >     gapminder[gapminder$year %in% c(2002, 2007),]
> >     ~~~
> >     {: .language-r}
> {: .solution}
{: .challenge}

> ## Challenge 8
>
> 1. Why does `gapminder[1:20]` return an error? How does it differ from `gapminder[1:20, ]`?
>
>
> 2. Create a new `data.frame` called `gapminder_small` that only contains rows 1 through 9
> and 19 through 23. You can do this in one or two steps.
>
> > ## Solution to challenge 8
> >
> > 1.  `gapminder` is a data.frame so needs to be subsetted on two dimensions. `gapminder[1:20, ]` subsets the data to give the first 20 rows and all columns.
> >
> > 2.
> >
> > 
> > ~~~
> > gapminder_small <- gapminder[c(1:9, 19:23),]
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}
