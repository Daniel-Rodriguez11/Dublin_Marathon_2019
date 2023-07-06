setwd("C:/Users/j/Desktop/NCI Modules/8.Analytical - CRM")

library(dplyr)
library(rvest)
library(xml2)
library(purrr)
url_base <- "http://results.dublinmarathon.ie/results.php?search&race=90&sort=placeall&from=%d"

seq1<-seq(from=10, to=17730, by=10)
loop<-c(0,seq1)

map_df(loop,function(i){
  cat(".")
  page<- read_html(sprintf(url_base,i))
  
  data.frame(PlaceOverall=html_text(html_nodes(page,"td:nth-child(1)")),
             Name=html_text(html_nodes(page,"td:nth-child(2)")),
             From=html_text(html_nodes(page,"td:nth-child(3)")),
             Cat.=html_text(html_nodes(page,"td:nth-child(4)")),
             PlaceInCat=html_text(html_nodes(page,"td:nth-child(5)")),
             "10kmTime"=html_text(html_nodes(page,"td:nth-child(6)")),
             "1stHalf"=html_text(html_nodes(page,"td:nth-child(7)")),
             "30km"=html_text(html_nodes(page,"td:nth-child(8)")),
             ChipTime=html_text(html_nodes(page,"td:nth-child(9)")),
             FinishTime=html_text(html_nodes(page,"td:nth-child(10)")),
             stringsAsFactors = FALSE
  )
})->marathontable

write.csv(marathontable, file="NewtableTest.csv", row.names = F, na = " ")
warnings()
?cat
