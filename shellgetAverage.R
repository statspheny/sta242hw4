shell = system


Sys.setlocale(locale="C")

getCountSumsSquares = function(year) {
    print(year)
    cmd = sprintf("cut -d, -f17,16 data/%s.csv | egrep '(LAX|OAK|SFO|SMF)'",year)
    con = pipe(cmd)

    B = 50000
    originAirports = c("LAX","OAK","SFO","SMF")
    records = matrix(0,3,4)
    
    counter=0
    ll = readLines(con)
    
    tmp = strsplit(ll,",")
    origin   = sapply(tmp, function(x) x[2])
    depdelay = sapply(tmp, function(x) as.numeric(x[1]))

    records = sapply(originAirports,
      function(x) {idx = as.logical(origin==x);
                   c(sum(idx), sum(depdelay[idx],na.rm=TRUE),sum(depdelay[idx]^2,na.rm=TRUE))})
    
    return(records)
}

time = system.time(getCountSumsSquares(2000))

years = 1987:2008
records = sapply(years,getCountSumsSquares)

totalRecords = rowSums(records)
## mean = sum/n
means = sapply(1:4, function(x) totalRecords[3*x-1]/totalRecords[3*x-2])
## standard deviation = sqrt((sumSquared - sum^2/n)/(n-1)) 
stdev = sapply(1:4, function(x)
       sqrt( (totalRecords[3*x] - totalRecords[3*x-1]^2/totalRecords[3*x-2]) / (totalRecords[3*x-2]-1)))
