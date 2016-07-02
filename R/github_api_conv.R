#### function to call github api and get back a nice data.frame ####
## url: github api url 
## col: variable of interest
api_call <- function(url, col){

  # call github api
  library(httr)
  api_ret <- content(GET(url))
  
  # call function to transform the result of the api call to a clean data.frame
  api_simple <- api_trans(api_ret, col)
  
  # return clean data.frame
  return(api_simple)
}

#### function to transform github api results to a nice data.frame ####
## url: github api result list 
## col: variable of interest
api_trans <- function(api_ret, col){
  
  # transform results to a clean format
  api_ret_s1 <- lapply(api_ret, function(x){
    res <- data.frame(str = unlist(x), stringsAsFactors = FALSE)
    res <- data.frame(id = row.names(res), res)
    colnames(res) <- c("id", paste(x[col]))
    return(res)
  })
  
  api_ret_s2 <- Reduce(function(...) merge(..., all=T), api_ret_s1)
  
  api_ret_s3 <- as.data.frame(t(api_ret_s2)[-1,], stringsAsFactors = FALSE)
  colnames(api_ret_s3) <- api_ret_s2$id
  
  # return clean data.frame
  return(api_ret_s3)
}