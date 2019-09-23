---
layout: page
title: "Instructor Notes"
---
{% include base_path.html %}

relative path root: {{ relative_root_path }}

## Instructor notes

## Lesson motivation and learning objectives

This lesson is designed to introduce learners to the core concepts of R 
that they will need in order to complete the other lessons
in this workshop. It is intended for learners who have no prior experience with
R. If your workshop learners have all completed another Software or Data 
Carpentry R workshop, or have taken courses in R, you can skip this lesson
and move straight into the 
[Introduction to Geospatial Raster and Vector Data with R](https://datacarpentry.org/r-raster-vector-geospatial/) lesson.

This lesson is a trimmed-down version of the 
[R for Reproducible Scientific Analysis](http://swcarpentry.github.io/r-novice-gapminder) SWC lesson. It does not cover visualization in detail, 
as the later lesson in this workshop covers visualization in the context of
geospatial data. 

## Lesson design

#### [Introduction to R and RStudio]({{ relative_root_path }}/{% link _episodes/01-rstudio-intro.md %})

* If your workshop includes the [Introduction to Geospatial Concepts](https://datacarpentry.org/organization-geospatial/) lesson, learners will have 
just been introduced to RStudio in the context of the overall Geospatial 
software landscape. 
* Have your learners open RStudio and follow along as you explain each pane. Make sure that your RStudio environment is the default so learners can follow along.
* Be sure to explain how to execute code from the script window, whether you're
using the Run button or the keyboard shortcut. 
* Learners will be using several libraries in the next lesson, so be sure to 
introduce what a library is and how it is installed. 

#### [Project Management With RStudio]({{ relative_root_path }}/{% link _episodes/02-project-intro.md %})

* Make sure learners download the data files in Challenge 1 and move those files
to their `data/` directory. 

#### [Data Structures]({{ relative_root_path }}/{% link _episodes/03-data-structures-part1.md %})

* Learners will work with factors in the following lesson. Be sure to 
cover this concept.
* If needed for time reasons, you can skip the section on lists. The learners
don't use lists in the rest of the workshop.

#### [Exploring Data Frames]({{ relative_root_path }}/{% link _episodes/04-data-structures-part2.md %})

* Pay attention to and explain the errors and warnings generated from the examples in this episode.

#### [Subsetting Data]({{ relative_root_path }}/{% link _episodes/05-data-subsetting.md %})

* The episode after this one covers the `dplyr` package, which has an 
alternate subsetting mechanism. Learners do still need to learn the 
base R subsetting covered here, as `dplyr` won't work in all situations. However,
the examples in the rest of the workshop focus on `dplyr` syntax.

#### [Dataframe Manipulation with dplyr]({{ relative_root_path }}/{% link _episodes/06-dplyr.md %})

* Introduce the `dplyr` package as a simpler, more intuitive way of doing
subsetting. 
* Unlike other SWC and DC R lessons, this lesson does **not** include data 
reshaping with `tidyr` as it isn't used in the rest of the workshop.

#### [Introduction to Visualization]({{ relative_root_path }}/{% link _episodes/07-plot-ggplot2.md %})

* This episode introduces `geom_col` and `geom_histogram`. These geoms are used
in the rest of the workshop, along with geoms specificly for geospatial data.
* Emphasize that we will go much deeper into visualization and creating
publication-quality graphics later in the workshop.

#### [Writing Data]({{ relative_root_path }}/{% link _episodes/08-writing-data.md %})

* Learners will need to have created the directory structure described in 
[Project Management With RStudio]({{ relative_root_path }}{% link _episodes/02-project-intro.md %}) in order for the code
in this episode to work. 

#### Concluding remarks

* Now that learners know the fundamentals of R, the rest of the workshop
will apply these concepts to working with geospatial data in R. 
* Packages and functions specific for working with geospatial data will be
the focus of the rest of the workshop. 
* They will have lots of changes to practice applying and expanding these
skills in the next lesson. 

## Technical tips and tricks

* Leave about 30 minutes at the start of each workshop and another 15 mins
at the start of each session for technical difficulties like WiFi and
installing things (even if you asked students to install in advance, longer if
not).

* Be sure to actually go through examples of an R help page: help files
can be intimidating at first, but knowing how to read them is tremendously
useful.

* Don't worry about being correct or knowing the material back-to-front. Use
mistakes as teaching moments: the most vital skill you can impart is how to
debug and recover from unexpected errors.

## Common problems

TBA - Instructors please add situations you encounter here.


{% include links.md %}
