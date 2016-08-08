#### setup for the R-Tutorial ####

# create folder for the R-Tutorial texts
system("rm -r downloads/r-tut/ ; mkdir downloads/r-tut")

# download scripts, data and images from github 
system("cd downloads/r-tut && svn checkout https://github.com/ISAAKiel/R-Tutorial_CAA2016/trunk/presentation/")
system("cd downloads/r-tut && svn checkout https://github.com/ISAAKiel/R-Tutorial_CAA2016/trunk/data/")
system("cd downloads/r-tut && svn checkout https://github.com/ISAAKiel/R-Tutorial_CAA2016/trunk/img/")

# delete all non *.Rmd-files 
#system("find downloads/r-tut/presentation -type f -not -name '*Rmd' -print0 | xargs -0 rm --")

# get lists of the downloaded *.Rmd-files
cfiles <- list.files(path = "downloads/r-tut/presentation/", pattern = "*.Rmd", full.names = TRUE)
rtutfiles <- list.files(path = "downloads/r-tut/presentation/", pattern = "*.Rmd")

# change header and paths in the *.Rmd-files
for(i in 1:length(cfiles)){
  # adjust header
  text <- readLines(cfiles[i])
  title <- grep("title:", text)[1]
  author <- grep("author:", text)[1]
  date <- grep("date:", text)[1]
  hspan <- grep("---", text)
  head <- c((hspan[1]+1):(hspan[2]-1))
  headkeep <- c(title, author, date)
  text <- text[-head[!(head %in% headkeep)]]
  
  hspan2 <- grep("---", text)
  text[hspan2[2]] <- gsub(
    "---",
    "output:\n  html_document:\n    theme: \"spacelab\"\n---", 
    text[hspan2[2]]
  )

  # adjust file paths and heading types
  for (tp in 1:length(text)){
    text[tp] <- gsub("../img/", "downloads/r-tut/img/", text[tp])
    text[tp] <- gsub("../data/", "downloads/r-tut/data/", text[tp])
    text[tp] <- gsub("^## ", "#### ", text[tp])
    text[tp] <- gsub("^# ", "## ", text[tp])
  }
  
  write(text, sep = "\n", file = cfiles[i])
}

# move *.Rmd-files to root path 
system("find downloads/r-tut/presentation -type f -name '*.Rmd' -print | xargs -i mv {} .")



#### setup for the recexcavAAR vignette ####

# create folder for the vignette *.Rmd file
system("rm -r downloads/vignettes/ ; mkdir downloads/vignettes; mkdir downloads/vignettes/recexcavAAR")

# download vignette
system("cd downloads/vignettes/recexcavAAR && svn checkout https://github.com/ISAAKiel/recexcavAAR/trunk/vignettes")

# get lists of the downloaded *.Rmd-files
cfiles <- list.files(path = "downloads/vignettes/recexcavAAR/vignettes", pattern = "*.Rmd", full.names = TRUE)

# replace devtools::load_all() in vignette
vignette <- readLines(cfiles[1])
loadall <- grep("devtools::load_all", vignette)
vignette[loadall] <- "library(recexcavAAR)"
write(vignette, sep = "\n", file = cfiles[1])

# move vignette *.Rmd-files to root path 
system("find downloads/vignettes/recexcavAAR/vignettes -type f -name '*.Rmd' -print | xargs -i mv {} .")



#### construct _site.yml ####

yml1 <- "
name: \"ISAAKiel\"
navbar:
  title: \"ISAAKiel\"
  type: inverse
  left:
    - text: \"Home\"
      icon: fa-home
      href: index.html
    - text: \"About\"
      icon: fa-info
      href: about.html
    - text: \"Projects\"
      icon: fa-gear
      href: projects.html
"
writeLines(yml1, "_site.yml")

yml2 <-"
    - text: \"R-Tutorial\"
      icon: fa-gear
      menu: 
" 
write(yml2, "_site.yml", append = TRUE)

for (fp in 1:length(rtutfiles)){
  rtutfiles[fp] <- gsub(".Rmd", ".html", rtutfiles[fp])
  
  if (fp > 1 && substr(rtutfiles[fp-1], 1, 1) == substr(rtutfiles[fp], 1, 1)){
    yml3 <- paste(
      paste("        - text: \"", gsub(".html", "", rtutfiles[fp]), "\"", sep = ""), 
      paste("          href: ", rtutfiles[fp], sep = ""), 
      sep = "\n"
    )
  } else {
    yml3 <- paste(
      paste("        - text: \"Abschnitt ", substr(rtutfiles[fp], 1, 1), "\"", sep = ""), 
      paste("        - text: \"", gsub(".html", "", rtutfiles[fp]), "\"", sep = ""), 
      paste("          href: ", rtutfiles[fp], sep = ""), 
      sep = "\n"
    )
  }
  write(yml3, "_site.yml", append = TRUE)
}

yml4 <-"
    - text: \"Vignettes\"
      icon: fa-gear
      menu: 
        - text: \"recexcavAAR Vignette 1\"
          href: recexcavAAR-vignette-1.html
" 
write(yml4, "_site.yml", append = TRUE)

yml5 <- "output_dir: \".\""
write(yml5, "_site.yml", append = TRUE)



#### render site ####

library(rmarkdown)
system("make")



#### delete remains ####

# delete R-Tutorial folder
system("rm -r downloads/r-tut/")

# delete vignettes folder
system("rm -r downloads/vignettes/")
