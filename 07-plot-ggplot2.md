---
title: Introduction to Visualization
teaching: 20
exercises: 15
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to use ggplot2 to generate histograms and bar plots.
- To apply geometry and aesthetic layers to a ggplot plot.
- To manipulate the aesthetics of a plot using different colors and position parameters.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What are the basics of creating graphics in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



Plotting our data is one of the best ways to quickly explore it and the various
relationships between variables. There are three main plotting systems in R, the
[base plotting system](https://www.statmethods.net/graphs/), the
[lattice](https://www.statmethods.net/advgraphs/trellis.html) package, and the
[ggplot2](https://www.statmethods.net/advgraphs/ggplot2.html) package. Today and
tomorrow we'll be learning about the ggplot2 package, because it is the most
effective for creating publication quality graphics. In this episode, we will
introduce the key features of a ggplot and make a few example plots. We will
expand on these concepts and see how they apply to geospatial data types when we
start working with geospatial data in the [R for Raster and Vector
Data](https://datacarpentry.org/r-raster-vector-geospatial/) lesson.

:::::::::::::::::::::::::::::::::::::::  instructor

- This episode introduces `geom_col` and `geom_histogram`. These geoms are used
  in the rest of the workshop, along with geoms specifically for geospatial 
  data.
- Emphasize that we will go much deeper into visualization and creating
  publication-quality graphics later in the workshop.

:::::::::::::::::::::::::::::::::::::::

ggplot2 is built on the grammar of graphics, the idea that any plot can be
expressed from the same set of components: a **data** set, a **coordinate
system**, and a set of **geoms**\--the visual representation of data points. The
key to understanding ggplot2 is thinking about a figure in layers. This idea may
be familiar to you if you have used image editing programs like Photoshop,
Illustrator, or Inkscape. In this episode we will focus on two geoms

- histograms and bar plot. In the [R for Raster and Vector Data](https://datacarpentry.org/r-raster-vector-geospatial/) lesson we will work with a number of other geometries
  and learn how to customize our plots.

Let's start off with an example plotting the
distribution of life expectancy in our dataset. The first thing we do is call the `ggplot` function. This function lets R
know that we're creating a new plot, and any of the arguments we give the
`ggplot()` function are the global options for the plot: they apply to all
layers on the plot.

We will pass in two arguments to `ggplot`. First, we tell
`ggplot` what data we
want to show on our figure, in this example we use the gapminder data we read in
earlier. For the second argument we pass in the `aes()` function, which
tells `ggplot` how variables in the data map to aesthetic properties of
the figure. Here we will tell `ggplot` we
want to plot the "lifeExp" column of the gapminder data frame on the x-axis. We don't need to specify a y-axis
for histograms.


```r
library("ggplot2")
ggplot(data = gapminder, aes(x = lifeExp)) +   
  geom_histogram()
```

<div class="figure" style="text-align: center">
<img src="fig/07-plot-ggplot2-rendered-lifeExp-vs-gdpPercap-scatter-1.png" alt="Histogram of life expectancy by country showing bimodal distribution with modes at 45 and 75"  />
<p class="caption">Histogram of life expectancy by country showing bimodal distribution with modes at 45 and 75</p>
</div>

By itself, the call to `ggplot` isn't enough to draw a figure:


```r
ggplot(data = gapminder, aes(x = lifeExp))
```

<img src="fig/07-plot-ggplot2-rendered-blank-plot-1.png" style="display: block; margin: auto;" />

We need to tell `ggplot` how we want to visually represent the data, which we
do by adding a geom layer. In our example, we used `geom_histogram()`, which
tells `ggplot` we want to visually represent the
distribution of one variable (in our case "lifeExp"):


```r
ggplot(data = gapminder, aes(x = lifeExp)) +   
  geom_histogram()
```

```{.output}
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<div class="figure" style="text-align: center">
<img src="fig/07-plot-ggplot2-rendered-lifeExp-vs-gdpPercap-scatter2-1.png" alt="Histogram of life expectancy by country showing bimodal distribution with modes at 45 and 75"  />
<p class="caption">Histogram of life expectancy by country showing bimodal distribution with modes at 45 and 75</p>
</div>

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Modify the example so that the figure shows the
distribution of gdp per capita, rather than life
expectancy:

:::::::::::::::  solution

## Solution to challenge 1


```r
ggplot(data = gapminder, aes(x = gdpPercap)) +   
 geom_histogram()
```

```{.output}
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="fig/07-plot-ggplot2-rendered-ch1-sol-1.png" style="display: block; margin: auto;" />

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

The histogram is a useful tool for visualizing the
distribution of a single categorical variable. What if
we want to compare the gdp per capita of the countries in
our dataset? We can use a bar (or column) plot.
To simplify our plot, let's look at data only from the most
recent year and only
from countries in the Americas.


```r
gapminder_small <- filter(gapminder, year == 2007, continent == "Americas")
```

This time, we will use the `geom_col()` function as our geometry.
We will plot countries on the x-axis (listed in alphabetic order
by default) and gdp per capita on the y-axis.


```r
ggplot(data = gapminder_small, aes(x = country, y = gdpPercap)) + 
  geom_col()
```

<div class="figure" style="text-align: center">
<img src="fig/07-plot-ggplot2-rendered-hist-subset-gapminder-1.png" alt="Barplot of GDP per capita. Country names on x-axis overlap and are not readable"  />
<p class="caption">Barplot of GDP per capita. Country names on x-axis overlap and are not readable</p>
</div>

With this many bars plotted, it's impossible to read all of the
x-axis labels. A quick fix to this is the add the `coord_flip()`
function to the end of our plot code.


```r
ggplot(data = gapminder_small, aes(x = country, y = gdpPercap)) + 
  geom_col() +
  coord_flip()
```

<div class="figure" style="text-align: center">
<img src="fig/07-plot-ggplot2-rendered-hist-subset-gapminder-flipped-1.png" alt="Barplot showing GDP per capita. Country names on the y-axis are readable"  />
<p class="caption">Barplot showing GDP per capita. Country names on the y-axis are readable</p>
</div>

There are more sophisticated ways of modifying axis
labels. We will be learning some of those methods
later in this workshop.

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

In the previous examples and challenge we've used the `aes` function to tell
the `geom_histogram()` and `geom_col()` functions which columns
of the
data set to plot.
Another aesthetic property we can modify is the
color. Create a new bar (column) plot showing the gdp per capita
of all countries in the Americas for the years 1952 and 2007,
color coded by year.

:::::::::::::::  solution

## Solution to challenge 2

First we create a new object with
our filtered data:


```r
gapminder_small_2 <- gapminder %>%
                        filter(continent == "Americas",
                               year %in% c(1952, 2007))
```

Then we plot that data using the `geom_col()`
geom function. We color bars using the `fill`
parameter within the `aes()` function.
Since there are multiple bars for each
country, we use the `position` parameter
to "dodge" them so they appear side-by-side.
The default behavior for `postion` in `geom_col()`
is "stack".


```r
ggplot(gapminder_small_2, 
       aes(x = country, y = gdpPercap, 
       fill = as.factor(year))) +
   geom_col(position = "dodge") + 
   coord_flip()
```

<img src="fig/07-plot-ggplot2-rendered-gpd-per-cap-1.png" style="display: block; margin: auto;" />

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

The examples given here are just the start of
creating complex and beautiful graphics with R.
In [a later lesson](https://datacarpentry.org/r-raster-vector-geospatial/) we will go into much
more depth, including:

- plotting geospatial specific data types
- adjusting the color scheme of our plots
- setting and formatting plot titles, subtitles, and axis labels
- creating multi-panel plots
- creating point (scatter) and line plots
- layering datasets to create multi-layered plots
- creating and customizing a plot legend
- and much more!

The examples we've worked through in this episode should give you the building
blocks for working with the more complex graphic types and customizations we
will be working with in that lesson.

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `ggplot2` to create plots.
- Think about graphics in layers: aesthetics, geometry, etc.

::::::::::::::::::::::::::::::::::::::::::::::::::


