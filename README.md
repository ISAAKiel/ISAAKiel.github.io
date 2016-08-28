[![Website](https://img.shields.io/website/https/isaakiel.github.io.svg?maxAge=2592000)]()  [![Maintenance](https://img.shields.io/maintenance/yes/2016.svg?maxAge=2592000)]() [![GitHub contributors](https://img.shields.io/github/contributors/ISAAKiel/ISAAKiel.github.io.svg?maxAge=2592000)]()

## ISAAKiel Website

To learn about ISAAKiel see https://ISAAKiel.github.io. 

***

#### For members of ISAAKiel: **How it works** 

This an [RMarkdown Website](http://rmarkdown.rstudio.com/rmarkdown_websites.html) based on [this](https://github.com/rstudio/rmarkdown-website) example.

- To apply changes in Home, About or Projects just clone the repo, edit the files **index.Rmd**, **about.Rmd** or **projects.Rmd**, knit the files with the <kbd>Knit HTML</kbd> button of RStudio and push the changes to the .Rmd and the .html file. That's it - no more magic involved, except ...

- ... first of all you need a github API key. You get one in the [github user settings](https://help.github.com/articles/creating-an-access-token-for-command-line-use/). Set it up locally as a string in a file called **oauth.RData** in the root directory of the homepage repository. Something like this should do the trick: 
    
    ```{r}
    oauth <- "your key goes here"    
    save(oauth, file = "oauth.RData")
    ```

- If you want to create a new subpage you also have to add it to the static part of the **_site.yml** file.

- Never press the <kbd>Build All</kbd> button of RStudio or use `rmarkdown::render_site()`. This will trigger the attempt to rebuild not just **index.Rmd**, **about.Rmd** and **projects.Rmd** but also the .Rmd files of the included tutorials. And this will fail due to missing data. Don't ever do this!

- If a change doesn't appear online try to clear your browser cache.

- If one of the source tutorial repos (like the R-Tutorial) changed and you want to see the new version on this website, you have to run the constructor script **R/site_constructor.R** and push all the files that changed. You usually don't have to do this. 

- If you want to add a new tutorial/source repo you will have to understand and carefully adjust the site constructor script **R/site_constructor.R**. 