---
title: Writing Data
teaching: 10
exercises: 10
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to write out plots and data from R.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I save plots and data created in R?

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: instructor

Learners will need to have created the directory structure described in
[Project Management With RStudio](../episodes/02-project-intro.Rmd) in order
for the code in this episode to work.

::::::::::::::::::::::::::::::::::::::::



## Saving plots

You can save a plot from within RStudio using the 'Export' button
in the 'Plot' window. This will give you the option of saving as a
.pdf or as .png, .jpg or other image formats.

Sometimes you will want to save plots without creating them in the 'Plot'
window first. Perhaps you want to make a pdf document, for example. Or perhaps
you're looping through multiple subsets of a file, plotting data from each
subset, and you want to save each plot.
In this case you can use flexible approach. The `ggsave` function saves the
latest plot by default. You can control the size and resolution using the
arguments to this function.


```r
ggplot(data = gapminder, aes(x = gdpPercap)) +
  geom_histogram()
ggsave("Distribution-of-gdpPercap.pdf", width=12, height=4)
```

Open up this document and have a look.

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Create and save a new plot showing the side-by-side bar plot of gdp per capita
in countries in the Americas in the years 1952 and 2007 that you created in the
previous episode.



:::::::::::::::  solution

## Solution to challenge 1


```r
ggplot(data = gapminder_small_2, aes(x = country, y = gdpPercap,
                                     fill = as.factor(year))) +
  geom_col(position = "dodge") +
  coord_flip()
# Note that ggsave saves by default the latest plot.
ggsave("Distribution-of-gdpPercap.pdf", width = 12, height = 4)
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

To produce documents in different formats, change the file extension for
`jpeg`, `png`, `tiff`, or `bmp`.



## Writing data

At some point, you'll also want to write out data from R.

We can use the `write.csv` function for this, which is
very similar to `read.csv` from before.

Let's create a data-cleaning script, for this analysis, we
only want to focus on the gapminder data for Australia:


```r
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


```r
?write.csv
```

By default R will write out the row and
column names when writing data to a file.
To over write this behavior, we can do the following:


```r
write.csv(
  aust_subset,
  file="cleaned-data/gapminder-aus.csv",
  row.names=FALSE
)
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Subset the gapminder
data to include only data points collected since 1990. Write out the new subset to a file
in the `cleaned-data/` directory.

:::::::::::::::  solution

## Solution to challenge 2


```r
gapminder_after_1990 <- filter(gapminder, year > 1990)

write.csv(gapminder_after_1990,
  file = "cleaned-data/gapminder-after-1990.csv",
  row.names = FALSE)
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::: keypoints

- Save plots using `ggsave()`.
- Use `write.csv` to save tabular data.

::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::: instructor

- Now that learners know the fundamentals of R, the rest of the workshop will
  apply these concepts to working with geospatial data in R.
- Packages and functions specific for working with geospatial data will be the
  focus of the rest of the workshop.
- They will have lots of challenges to practice applying and expanding these
  skills in the next lesson.

::::::::::::::::::::::::::::::::::::::::
