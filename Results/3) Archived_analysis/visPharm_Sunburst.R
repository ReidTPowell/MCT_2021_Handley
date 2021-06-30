library(readxl)
library(d3r)
library(sunburstR)
library(htmlwidgets)

##Load data
Input <- read_excel("T:/MDA_KatelynFosterHandley_AnilSood/screen/Results/4) Campaign summary/Screening library summary.xlsx", sheet = "AUC_GRI table")

Build_from = c("Class","Process","Target")
##Clean inputs 
dat = Input[,Build_from]
##dat[,"size"] = 1
dat[is.na(dat)] = "Others"

dat = data.frame(lapply(dat, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))


df = count(dat,Build_from)
colnames(df)[4] <- "size"

tree <- d3_nest(df, value_cols = "size")
sb1 <- sunburst(tree, width="100%", height=400,count = T, sortFunction = htmlwidgets::JS(
    "
    function(a,b) {
      // sort by count descending
      //   unlike the other example using data.name, value is at the top level of the object
      return b.value - a.value
    }
    "    
  )
  
)
sb1
#saveWidget(sb1, file="SunburstR.html", selfcontained = TRUE)




