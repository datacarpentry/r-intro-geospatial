---
title: Writing Data
teaching: 10
exercises: 10
questions:
- "How can I save plots and data created in R?"
objectives:
- "To be able to write out plots and data from R."
keypoints:
- "Save plots using `ggsave()` or `pdf()` combined with `dev.off()`."
- "Use `write.csv` to save tabular data."
source: Rmd
---

```{r, include=FALSE}
source("../bin/chunk-options.R")
knitr_fig_path("08-")
# Silently load in the data so the rest of the lesson works
library("ggplot2")
library(dplyr)
gapminder <- read.csv("data/gapminder_data.csv", header=TRUE)

# load data that learners created in previous episode
gapminder_small_2 <- filter(gapminder, continent == "Americas", year %in% c(1952, 2007))

# Temporarily create a cleaned-data directory so that the writing examples work
# The students should have created this in topic 2.
dir.create("cleaned-data")
```


## Saving plots

You can save a plot from within RStudio using the 'Export' button
in the 'Plot' window. This will give you the option of saving as a
.pdf or as .png, .jpg or other image formats.

Sometimes you will want to save plots without creating them in the
'Plot' window first. Perhaps you want to make a pdf document with
multiple pages: each one a different plot, for example. Or perhaps
you're looping through multiple subsets of a file, plotting data from
each subset, and you want to save each plot. 
In this case you can use a more flexible approach. The
`pdf()` function creates a new pdf device. You can control the size and resolution
using the arguments to this function.

```{r, eval=FALSE}
pdf("Distribution-of-gdpPercap.pdf", width=12, height=4)
ggplot(data = gapminder, aes(x = gdpPercap)) +   
  geom_histogram()

# You then have to make sure to turn off the pdf device!

dev.off()
```

Open up this document and have a look.

> ## Challenge 1
>
> Rewrite your 'pdf' command to print a second
> page in the pdf, showing the side-by-side bar
> plot of gdp per capita in countries in the Americas
> in the years 1952 and 2007 that you created in the 
> previous episode. 
> 
> > ## Solution to challenge 1
> >
> > ```{r, eval = FALSE}
> > pdf("Distribution-of-gdpPercap.pdf", width = 12, height = 4)
> > ggplot(data = gapminder, aes(x = gdpPercap)) + 
> > geom_histogram()
> > 
> > ggplot(data = gapminder_small_2, aes(x = country, y = gdpPercap, fill = as.factor(year))) +
> > geom_col(position = "dodge") + coord_flip()
> > 
> > dev.off()
> > ```
> {: .solution}
{: .challenge}


The commands `jpeg`, `png` etc. are used similarly to produce
documents in different formats.

## Writing data

At some point, you'll also want to write out data from R.

We can use the `write.csv` function for this, which is
very similar to `read.csv` from before.

Let's create a data-cleaning script, for this analysis, we
only want to focus on the gapminder data for Australia:

```{r}
aust_subset <- filter(gapminder, country == "Australia")

write.csv(aust_subset,
  file="cleaned-data/gapminder-aus.csv"
)
```

Let's open the file to make sure it contains the data we expect. Navigate to your
`cleaned-data` directory and double-click the file name. It will open using your
computer's default for opening files with a `.csv` extension. To open in a specific
application, right click and select the application. Using a spreadsheet program
(like Excel) to open this file shows us that we do have properly formatted data
including only the data points from Australia. However, there are row numbers 
associated with the data that are not useful to us (they refer to the row numbers
from the gapminder data frame).

Let's look at the help file to work out how to change this
behaviour.

```{r, eval=FALSE}
?write.csv
```

By default R will write out the row and
column names when writing data to a file.
To over write this behavior, we can do the following:

```{r}
write.csv(
  aust_subset,
  file="cleaned-data/gapminder-aus.csv",
  row.names=FALSE
)
```

> ## Challenge 2
>
> Subset the gapminder
> data to include only data points collected since 1990. Write out the new subset to a file
> in the `cleaned-data/` directory.
> 
> > ## Solution to challenge 2
> >
> > ```{r, eval = FALSE}
> > 
> > gapminder_after_1990 <- filter(gapminder, year > 1990)
> > 
> > write.csv(gapminder_after_1990,
> >   file = "cleaned-data/gapminder-after-1990.csv",
> >   row.names = FALSE)
> > ```
> {: .solution}
{: .challenge}

```{r, echo=FALSE}
# We remove after rendering the lesson, because we don't want this in the lesson
# repository
unlink("cleaned-data", recursive=TRUE)
```
