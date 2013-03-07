library(RSQLite)

dr = dbDriver("SQLite")

con = dbConnect(dr, dbname="airlineDelays.db")

## make it flexible to change
originAirports = c('LAX','OAK','SFO','SMF')
whereConditiontmp = sprintf("origin=='%s'",originAirports)
whereCondition = paste("where",paste(whereConditiontmp,collapse=" or "))


## get the counts from each departure airport
queryCounts = paste("SELECT origin, count(*) FROM delays", whereCondition, "group by origin")

r1 = dbSendQuery(con, queryCounts)
ans1 = fetch(r1)
print(ans1)

time1 = system.time(fetch(dbSendQuery(con, queryCounts)))

## get the average from each departure airport
queryAvg = paste("SELECT origin, avg(depdelay) FROM delays", whereCondition, "group by origin")

r2 = dbSendQuery(con, queryAvg)
ans2 = fetch(r2)
print(ans2)

time2 = system.time(fetch(dbSendQuery(con, queryAvg)))


## get the variance of times from each departure airport
queryVar = paste("SELECT origin, sum(delays.depdelay*delays.depdelay) FROM delays", whereCondition, "group by origin")

r3 = dbSendQuery(con, queryVar)

ans3 = fetch(r3)
print(ans3)

time3 = system.time(fetch(dbSendQuery(con, queryVar)))


##
