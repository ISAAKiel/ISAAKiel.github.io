## ISAAKiel Website

To learn about ISAAKiel see https://ISAAKiel.github.io. 

***

#### For members of ISAAKiel: **How it works** 

This an [RMarkdown Website](http://rmarkdown.rstudio.com/rmarkdown_websites.html) based on [this](https://github.com/rstudio/rmarkdown-website) example.

To apply changes in **Home**, **About** or **Projects** just clone the repo, edit the files **index.Rmd**, **about.Rmd** or **projects.Rmd**, knit the files and push the changes to the .Rmd and the .html file. That's it - no more magic involved. 
If you want to create a new subpage you have to add it to the static part of the _site.yml file.

If one of the source tutorial repos (like the R-Tutorial) changed and you want to see the new version on this website, you have to run the constructor script (R/site_constructor.R) and push all the files that changed. You usually don't have to do this. 

**Remember to clear your browser cache to see changes.**