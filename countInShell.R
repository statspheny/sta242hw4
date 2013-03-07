setwd("~/school/sta242/sta242hw4")

# set the shell
shell=system;

numlines = shell("wc -l testcase.csv",intern=TRUE)

# original test case
testcase = read.csv("testcases/testcase.csv",header=TRUE)
counts = shell("cut -d, -f17 testcases/testcase.csv | egrep '(LAX|OAK|SFO|SMF)' | sort | uniq -c",intern=TRUE)
table(testcase[[17]])

# shell commands
# I also have a bash script that does this
datafile = "data/*.csv"
airportSearchTerm = "'(LAX|OAK|SFO|SMF)'"
shellCountAirportCommandBase = "cut -d, -f17 %s | egrep %s | sort | uniq -c"
shellCountAirportCommand = sprintf(shellCountAirportCommandBase, datafile, airportSearchTerm)

shellCountsOutput = shell(shellCountAirportCommand,intern=TRUE)

shelltime = system.time(shell(shellCountAirportCommand,intern=TRUE))
shelltime


# using R connection
con = file("data/2000.csv","r")
close(con)
B = 10000

originAirports=c("LAX","OAK","SFO","SMF")

getTotalUsingConnections = function(datafile,origin,B=10000) {
    print(datafile)
    con = file(datafile,"r")
    total = structure(integer(length(origin)),names=origin)
    while(TRUE) {
        ll = readLines(con,n=B)
        if(length(ll)==0)
          break
        tmp = sapply(strsplit(ll,","),`[[`,17)
        subCounts = table(tmp)[origin]
        subCounts[ is.na(subCounts) ] = 0
        total = total + subCounts
    }
    names(total)=origin
    close(con)
    return(total)
}

system.time(getTotalUsingConnections("data/2001.csv",originAirports,B=50000))

Sys.setlocale(locale="C")
alldata = sprintf("data/%s.csv",1987:2008)
totals = sapply(alldata,getTotalUsingConnections,origin=originAirports,B=50000)
       


