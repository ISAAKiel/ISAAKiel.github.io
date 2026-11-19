[![Website](https://img.shields.io/website/https/isaakiel.github.io.svg?maxAge=2592000)](https://isaakiel.github.io/) [![GitHub contributors](https://img.shields.io/github/contributors/ISAAKiel/ISAAKiel.github.io.svg?maxAge=2592000)](https://github.com/ISAAKiel/ISAAKiel.github.io) [![Build and deploy](https://github.com/ISAAKiel/ISAAKiel.github.io/actions/workflows/build.yml/badge.svg)](https://github.com/ISAAKiel/ISAAKiel.github.io/actions/workflows/build.yml)

## ISAAKiel Website

Website of the **Initiative for Statistical Analysis in Archaeology Kiel (ISAAK)**.

Visit [isaakiel.github.io](https://isaakiel.github.io/) or [isaakiel.de](http://www.isaakiel.de).

### Contributing

The website is built with [R Markdown](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html) and automatically rendered and published through GitHub Actions.

To make changes, edit the relevant files and open a pull request against `master`. The website is rebuilt automatically after merging.

- **Members:** Edit [`active_members.csv`](active_members.csv) to add or remove active members. All other public members of the [ISAAKiel GitHub organization](https://github.com/orgs/ISAAKiel/people) are listed as alumni. Names and avatars are retrieved from GitHub. Organization membership must be public to appear on the website.
- **Projects:** Repository information is retrieved automatically from GitHub.
- **Events:** Edit [`data/events_list.csv`](data/events_list.csv).
- **New pages:** Add an `.Rmd` file and update [`_site.yml`](_site.yml).

### Building locally

The website can also be rendered locally using RStudio or:

```r
rmarkdown::render_site(".")
```

The automated build uses a [Rocker](https://rocker-project.org/) container and is configured in [`.github/workflows/build.yml`](.github/workflows/build.yml). It runs on changes to `master` and weekly to update GitHub-derived information.