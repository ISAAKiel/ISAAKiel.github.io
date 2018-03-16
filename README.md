[![Website](https://img.shields.io/website/https/isaakiel.github.io.svg?maxAge=2592000)](https://isaakiel.github.io/) [![GitHub contributors](https://img.shields.io/github/contributors/ISAAKiel/ISAAKiel.github.io.svg?maxAge=2592000)](https://github.com/ISAAKiel/ISAAKiel.github.io)

## ISAAKiel Website

To learn about ISAAKiel see https://ISAAKiel.github.io. 

This website can also be reached via [isaakiel.de](http://www.isaakiel.de).

***

#### For members of ISAAKiel: **How it works** 

This an [RMarkdown Website](http://rmarkdown.rstudio.com/rmarkdown_websites.html) based on [this](https://github.com/rstudio/rmarkdown-website) example.

- To apply changes just clone the repo, edit the relevant .Rmd files, knit the files with the <kbd>Knit HTML</kbd> button of RStudio and push the changes to the .Rmd and the .html file. That's it - no more magic involved, except ...

- ... to update the **index.Rmd** and **projects.Rmd** you need a github API key. You get one in the [github user settings](https://help.github.com/articles/creating-an-access-token-for-command-line-use/). It is not necessary to grant the token any scopes (on the selection page that appears once you create a token). Set it up locally as a string in a file called **oauth.RData** in the root directory of the homepage repository. Something like this should do the trick: 
    
```{r}
oauth <- "your key goes here"    
save(oauth, file = "oauth.RData")
```

- The same applies for the **screencasts.Rmd** where you need a youtube data API key.

- If you want to create a new subpage you also have to add it to the static part of the **_site.yml** file.

- To update everything after a change you can press the <kbd>Build All</kbd> button of RStudio or use `rmarkdown::render_site()`. This will trigger the attempt to rebuild **index.Rmd**, **projects.Rmd** and all the other .Rmd files in the repository.

- If a change doesn't appear online try to clear your browser cache.
