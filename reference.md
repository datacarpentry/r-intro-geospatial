---
layout: reference
---
{% include base_path.html %}

## Reference

## [Introduction to R and RStudio]({{ relative_root_path }}/{% link _episodes/01-rstudio-intro.md %})

 - Use the escape key to cancel incomplete commands or running code
   (Ctrl+C) if you're using R from the shell.
 - Basic arithmetic operations follow standard order of precedence:
   - Brackets: `(`, `)`
   - Exponents: `^` or `**`
   - Divide: `/`
   - Multiply: `*`
   - Add: `+`
   - Subtract: `-`
 - Scientific notation is available, e.g: `2e-3`
 - Anything to the right of a `#` is a comment, R will ignore this!
 - Functions are denoted by `function_name()`. Expressions inside the
   brackets are evaluated before being passed to the function, and
   functions can be nested.
 - Comparison operators: `<`, `<=`, `>`, `>=`, `==`, `!=`
 - Use `all.equal` to compare numbers!
 - `<-` is the assignment operator. Anything to the right is evaluate, then
   stored in a variable named to the left.
 - `ls` lists all variables and functions you've created
 - `rm` can be used to remove them
 - When assigning values to function arguments, you _must_ use `=`.

## [Project management with RStudio]({{ relative_root_path }}/{% link _episodes/02-project-intro.md %})

 - To create a new project, go to File -> New Project
 - Some best practices:
   * Treat data as read-only
   * Keep cleaned data separate from raw dirty data
   * Treat generated output as disposable
   * Keep related data together
   * Use a consistent naming scheme

## [Data Structures]({{ relative_root_path }}/{% link _episodes/03-data-structures-part1.md %})

- Use `read.csv()` to import data in memory
- ` class()` gives you the data class of your object
- R automatic converts data types
- The functions: `length()`, `nrow()`, `head()`, `tail()`, and `str()` can be
  useful to explore data.
- Factors are a special class to deal with categorical data.
- Lists provide a flexible data type.
- Data frames are a special case of lists.

## [Exploring Data Frames]({{ relative_root_path }}/{% link _episodes/04-data-structures-part2.md %})

* R makes it easy to import datasets storred remotely
* **[Data Frames]({{ relative_root_path }}/05-data-structures-part2/)**
 - `?data.frame` is a key data structure. It is a `list` of `vectors`.
 - `cbind()` will add a column (vector) to a data.frame.
 - `rbind()` will add a row (list) to a data.frame.

 **Useful functions for querying data structures:**
 - `?str` structure, prints out a summary of the whole data structure
 - `?class` what is the data structure?
 - `?head` print the first `n` elements (rows for two-dimensional objects)
 - `?tail` print the last `n` elements (rows for two-dimensional objects)
 - `?rownames`, `?colnames`, `?dimnames` retrieve or modify the row names
   and column names of an object.
 - `?length` get the number of elements in an atomic vector
 - `?nrow`, `?ncol`, `?dim` get the dimensions of a n-dimensional object
   (Won't work on atomic vectors or lists).
* If your data frame contains factors, you need to take extra steps to add rows
  that contain new level values.
 
- `read.csv` to read in data in a regular structure
   - `sep` argument to specify the separator
     - "," for comma separated
     - "\t" for tab separated
   - Other arguments:
     - `header=TRUE` if there is a header row
 

## [Subsetting data]({{ relative_root_path }}/{% link _episodes/05-data-subsetting.md %})

 - Elements can be accessed by:
   - Index
   - Name
   - Logical vectors

- `[` single square brackets:
   - *extract* single elements or *subset* vectors
    - e.g.`x[1]` extracts the first item from vector x.
   - *extract* single elements of a list. The returned value will be another `list()`.
   - *extract* columns from a data.frame
 - `[` with two arguments to:
   - *extract* rows and/or columns of
     - matrices
     - data.frames
     - e.g. `x[1,2]` will extract the value in row 1, column 2.
     - e.g. `x[2,:]` will extract the entire second column of values.

 - `[[` double square brackets to extract items from lists.
 - `$` to access columns or list elements by name
 - negative indices skip elements


## [Data frame manipulation with dplyr]({{ relative_root_path }}/{% link _episodes/06-dplyr.md %})


 - `?select` to extract variables by name.
 - `?filter` return rows with matching conditions.
 - `?group_by` group data by one of more variables.
 - `?summarize` summarize multiple values to a single value.
 - `?mutate` add new variables to a data.frame.
 - `?count` and `?n` to tally values in the data frame.
 - Combine operations using the `?"%>%"` pipe operator.


## [Control flow]({{ relative_root_path }}/{% link _episodes/07-plot-ggplot2.md %})


 - figures can be created with the grammar of graphics:
   - `library(ggplot2)`
   - `ggplot` to create the base figure
   - `aes`thetics specify the data axes, shape, color, and data size
   - `geom`etry functions specify the type of plot, e.g. `point`, `line`, `density`, `box`
   - `geom`etry functions also add statistical transforms, e.g. `geom_smooth`
   - `scale` functions change the mapping from data to aesthetics
   - `facet` functions stratify the figure into panels
   - `aes`thetics apply to individual layers, or can be set for the whole plot
     inside `ggplot`.
   - `theme` functions change the overall look of the plot
   - order of layers matters!
   - `ggsave` to save a figure.


## [Writing data]({{ relative_root_path }}/{% link _episodes/08-writing-data.md %})

 - `write.table` to write out objects in regular format


## Glossary

{:auto_ids}
argument
:   A value given to a function or program when it runs.
    The term is often used interchangeably (and inconsistently) with [parameter](#parameter).

assign
:   To give a value a name by associating a variable with it.

body
:   (of a function): the statements that are executed when a function runs.

comment
:   A remark in a program that is intended to help human readers understand what is going on,
    but is ignored by the computer.
    Comments in Python, R, and the Unix shell start with a `#` character and run to the end of the line;
    comments in SQL start with `--`,
    and other languages have other conventions.

comma-separated values
:   (CSV) A common textual representation for tables
    in which the values in each row are separated by commas.

delimiter
:   A character or characters used to separate individual values,
    such as the commas between columns in a [CSV](#comma-separated-values) file.

documentation
:   Human-language text written to explain what software does,
    how it works, or how to use it.

floating-point number
:   A number containing a fractional part and an exponent.
    See also: [integer](#integer).

for loop
:   A loop that is executed once for each value in some kind of set, list, or range.
    See also: [while loop](#while-loop).

index
:   A subscript that specifies the location of a single value in a collection,
    such as a single pixel in an image.

integer
:   A whole number, such as -12343. See also: [floating-point number](#floating-point-number).

library
:   In R, the directory(ies) where [packages](#package) are stored.

package
:   A collection of R functions, data and compiled code in a well-defined format. Packages are stored in a [library](#library) and loaded using the library() function.

parameter
:   A variable named in the function's declaration that is used to hold a value passed into the call.
    The term is often used interchangeably (and inconsistently) with [argument](#argument).

return statement
:   A statement that causes a function to stop executing and return a value to its caller immediately.

sequence
:   A collection of information that is presented in a specific order.

shape
:   An array's dimensions, represented as a vector.
    For example, a 5×3 array's shape is `(5,3)`.

string
:   Short for "character string",
    a [sequence](#sequence) of zero or more characters.

syntax error
:   A programming error that occurs when statements are in an order or contain characters
    not expected by the programming language.

type
:   The classification of something in a program (for example, the contents of a variable)
    as a kind of number (e.g. [floating-point](#float), [integer](#integer)), [string](#string),
    or something else. In R the command typeof() is used to query a variables type.

while loop
:   A loop that keeps executing as long as some condition is true.
    See also: [for loop](#for-loop).
