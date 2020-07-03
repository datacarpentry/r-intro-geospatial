library(tic)

BuildLesson <- R6::R6Class(
  "BuildLesson", inherit = TicStep,
  public = list(
    run = function() {
      build_status <- system("make clean-rmd; make lesson-md")
      if (build_status > 0)
        stop("Error during building process")

      file.remove(".gitignore")
      system("mkdir  _rendered")
      system("cp -r \`ls -A | grep -v '.git' | grep -v '_rendered' | grep -v '_site'\` _rendered")
    })
)

build_lesson <- function() {
  BuildLesson$new()
}


CheckLinks <- R6::R6Class(
  "CheckLinks", inherit = TicStep,
  public = list(
    run = function() {
      ## While build_lesson() merely copies the content of the repo into a
      ## new folder that GitHub picks up to render (so the dynamically
      ## generated links such as "Edit on GitHub" are functional), here we
      ## actually need to generate the website so we can test the links.
      on.exit(system("rm -rf _rendered/_site"))

      res <- checker::check_jekyll_links(
        site_root = "_rendered",
        ruby_cmd = "rvm 2.5.8 do ruby -S",
        show_summary = TRUE,
        check_external = TRUE,
        only_with_issues = FALSE,
        ignore_pattern = "site_libs"
      )

      res
    })
)

check_links <- function() {
  CheckLinks$new()
}
