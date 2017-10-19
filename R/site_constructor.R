#### setup packages ####

if(!require('devtools')) install.packages('devtools')
if(!require('rmarkdown')) install.packages('rmarkdown')
if(!require('magrittr')) install.packages('magrittr')
library(magrittr)

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



#### setup for vignettes ####

# list of ISAAK packages with vignettes
packlist <- c("recexcavAAR", "quantAAR", "mortAAR") #"mortAAR"

sapply(packlist, function(x){
  if(!require(paste(x), character.only = TRUE)){
    devtools::install_github(paste0("ISAAKiel/", x))
  }
})

# create folder for the vignette *.Rmd file
system("rm -r downloads/vignettes/; mkdir downloads/vignettes")

# loop to download, edit and move vignettes by package
ymlvignettes <- list()
for (p1 in 1:length(packlist)) {
  system(paste("mkdir downloads/vignettes/", packlist[p1], sep = ""))
  system(paste(
    "cd downloads/vignettes/", packlist[p1], 
    " && svn checkout https://github.com/ISAAKiel/", packlist[p1], "/trunk/vignettes/",
    sep = ""))
  # system(paste("mv downloads/vignettes/", packlist[p1], "/vignettes/*.Rmd downloads/vignettes/",  
  #   sep = ""))
  
  # get lists of the downloaded *.Rmd-files for the current package
  cfiles <- list.files(
    path = paste("downloads/vignettes/", packlist[p1], "/vignettes", sep = ""), 
    pattern = "*.Rmd", 
    full.names = TRUE
  )
  vignettefilenames <- list.files(
    path = paste("downloads/vignettes/", packlist[p1], "/vignettes", sep = ""), 
    pattern = "*.Rmd"
  )
  
  # replace devtools::load_all() in vignettes
  for (p2 in 1:length(cfiles)) {
    vignette <- readLines(cfiles[p2])
    loadall <- grep("devtools::load_all", vignette)
    vignette[loadall] <- paste("library(", packlist[p1], ")", sep = "")
    write(vignette, sep = "\n", file = cfiles[p2])
  }
  
  # adjust header of vignettes
  for (p4 in 1:length(cfiles)) {
    vignette <- readLines(cfiles[p4])
    output <- grep("output: rmarkdown::html_vignette", vignette)[1]
    hspan <- grep("---", vignette)[2]
    vignette <- vignette[-c(output:hspan)] 
    vignette[output] <- paste("output:\n  html_document:\n    theme: \"spacelab\"\n---\n", sep = "")
    write(vignette, sep = "\n", file = cfiles[p4])
  }
  
  # get vignette titles
  vignettetitles <- c()
  for (p5 in 1:length(cfiles)) {
    vignette <- readLines(cfiles[p5])
    tline <- grep("^title:", vignette)[1]
    title <- gsub("\"", "", substring(vignette[tline], 8))
    vignettetitles[p5] <- title
  }
  
  # move vignette *.Rmd-files to root path 
  system(paste("find downloads/vignettes/", packlist[p1], "/vignettes -type f -name '*.Rmd' -print | xargs -i mv {} .", sep = ""))
  
  # setup .yml-entries for current packages
  ymlvignettes[[p1]] <- c(NA)
  for (p3 in 1:length(vignettefilenames)) {
    ymlvignettes[[p1]][p3] <- paste(
      paste("        - text: \"", gsub(".Rmd", "", vignettetitles[p3]), "\"", sep = ""), 
      paste("          href: ", gsub(".Rmd", ".html", vignettefilenames[p3]), sep = ""),
      sep = "\n"
    )
  }
}



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
    - text: \"CAA2018\"
      icon: fa-users
      href: CAA2018.html
    - text: \"Projects\"
      icon: fa-gears
      href: projects.html
"
writeLines(yml1, "_site.yml")

yml2 <-"
    - text: \"R-Tutorial CAA 2016\"
      icon: fa-bar-chart
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

yml7 <-"
    - text: \"R-Tutorial Mosaic 2016\"
      icon: fa-area-chart
      href: https://isaakiel.github.io/Mosaic/
" 
write(yml7, "_site.yml", append = TRUE)

yml4 <-"
    - text: \"Vignettes\"
      icon: fa-eye
      menu:
" 
write(yml4, "_site.yml", append = TRUE)

for (p1 in 1:length(ymlvignettes)) {
  for (p2 in 1:length(ymlvignettes[[p1]])) {
    yml5 <- ymlvignettes[[p1]][p2]
    write(yml5, "_site.yml", append = TRUE)
  }
} 

yml6 <- "output_dir: \".\""
write(yml6, "_site.yml", append = TRUE)


#### setup all necessary libraries for rendering ####

# search all library calls in RMD files
liblist_raw <- system("grep -r --include \\*.Rmd \"^library(\" --no-filename", intern = TRUE)
liblist <- liblist_raw %>% gsub("library\\(", "", .) %>% gsub("\\)", "", .) %>%
  unique

# install packages if needed
liblist %>% sapply(
  function(x){
    if(!require(paste(x), character.only = TRUE)){
      install.packages(paste(x))
    }
  })

#### render site ####

system("make")



#### delete remains ####

# delete R-Tutorial folder
system("rm -r downloads/r-tut/")

# delete vignettes folder
system("rm -r downloads/vignettes/")
