---
title: Instructor Notes
---



relative path root: {{ relative\_root\_path }}

## Instructor notes

## Lesson design

#### [Introduction to R and RStudio](../episodes/01-rstudio-intro.Rmd)

- If your workshop includes the [Introduction to Geospatial Concepts](https://datacarpentry.org/organization-geospatial/) lesson, learners will have
  just been introduced to RStudio in the context of the overall Geospatial
  software landscape.
- Have your learners open RStudio and follow along as you explain each pane. Make sure that your RStudio environment is the default so learners can follow along.
- Be sure to explain how to execute code from the script window, whether you're
  using the Run button or the keyboard shortcut.
- Learners will be using several libraries in the next lesson, so be sure to
  introduce what a library is and how it is installed.

#### [Project Management With RStudio](../episodes/02-project-intro.Rmd)

- Make sure learners download the data files in Challenge 1 and move those files
  to their `data/` directory.

#### [Data Structures](../episodes/03-data-structures-part1.Rmd)


#### [Exploring Data Frames](../episodes/04-data-structures-part2.Rmd)

- Pay attention to and explain the errors and warnings generated from the examples in this episode.

#### [Subsetting Data](../episodes/05-data-subsetting.Rmd)

- The episode after this one covers the `dplyr` package, which has an
  alternate subsetting mechanism. Learners do still need to learn the
  base R subsetting covered here, as `dplyr` won't work in all situations. However,
  the examples in the rest of the workshop focus on `dplyr` syntax.

#### [Dataframe Manipulation with dplyr](../episodes/06-dplyr.Rmd)

- Introduce the `dplyr` package as a simpler, more intuitive way of doing
  subsetting.
- Unlike other SWC and DC R lessons, this lesson does **not** include data
  reshaping with `tidyr` as it isn't used in the rest of the workshop.

#### [Introduction to Visualization](../episodes/07-plot-ggplot2.Rmd)

- This episode introduces `geom_col` and `geom_histogram`. These geoms are used
  in the rest of the workshop, along with geoms specifically for geospatial data.
- Emphasize that we will go much deeper into visualization and creating
  publication-quality graphics later in the workshop.

#### [Writing Data](../episodes/08-writing-data.Rmd)

- Learners will need to have created the directory structure described in
  [Project Management With RStudio](../episodes/02-project-intro.Rmd) in order for the code
  in this episode to work.

#### Concluding remarks

- Now that learners know the fundamentals of R, the rest of the workshop
  will apply these concepts to working with geospatial data in R.
- Packages and functions specific for working with geospatial data will be
  the focus of the rest of the workshop.
- They will have lots of changes to practice applying and expanding these
  skills in the next lesson.

## Technical tips and tricks

- Leave about 30 minutes at the start of each workshop and another 15 mins
  at the start of each session for technical difficulties like WiFi and
  installing things (even if you asked students to install in advance, longer if
  not).

- Be sure to actually go through examples of an R help page: help files
  can be intimidating at first, but knowing how to read them is tremendously
  useful.

- Don't worry about being correct or knowing the material back-to-front. Use
  mistakes as teaching moments: the most vital skill you can impart is how to
  debug and recover from unexpected errors.

## Common problems

TBA - Instructors please add situations you encounter here.




