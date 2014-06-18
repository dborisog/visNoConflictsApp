
# This dataset encompasses wars in the middle category - wars that 
# take place between a state(s) and a nonstate entity outside the 
# borders of the state, or extra-state wars.
df.ES <- read.csv(file='https://github.com/dborisog/visNoConflictsApp/raw/master/data/Extra-StateWarData_v4.0.csv',header=TRUE, sep=',')

# This dataset encompasses wars that take place between or 
# among the recognized states, or interstate wars.
df.IrS <- read.csv(file='https://github.com/dborisog/visNoConflictsApp/raw/master/data/Inter-StateWarData_v4.0.csv',header=TRUE, sep=',')

# This dataset encompasses wars that predominantly take place within 
# the recognized territory of a state, or intra-state wars.
df.IaS <- read.csv(file='https://github.com/dborisog/visNoConflictsApp/raw/master/data/Intra-StateWarData_v4.1.csv',header=TRUE, sep=',')

# wars between or among non-state entities, such entities include
# governments of other types of geopolitical units (GPUs), such as
# dependencies or non-state autonomous entities, that do not meet 
# the criteria of system membership. They also might involve 
# nonterritorial entities (NTEs) or non-state armed groups (NSAs) 
# that have no defined territorial base.
df.NS <- read.csv(file='https://github.com/dborisog/visNoConflictsApp/raw/master/data/Non-StateWarData_v4.0.csv',header=TRUE, sep=',')


# for each row with EndYear2 != -8 change EndYear1 to EndYear2
df.irs <- df.IrS[,c(1,2,3,20,9,12,15,18)]
df.es <- df.ES[,c(1,2,3,25,10,13,16,19)]
df.ias <- df.IaS[,c(1,2,3,22,11,14,17,20)]
df.ns <- df.NS[,c(1,2,3,4,12,15)]

df.irs[which(df.irs$EndYear2 != -8),6] <- df.IrS[which(df.IrS$EndYear2 != -8),18]
df.es[which(df.es$EndYear2 != -8),6] <- df.ES[which(df.ES$EndYear2 != -8),19]
df.ias[which(df.ias$EndYear2 != -8),6] <- df.IaS[which(df.IaS$EndYear2 != -8),20]
remove(df.IrS,df.ES,df.IaS,df.NS) 


# drop Year2 columns
df.irs$StartYear2 <- NULL
df.irs$EndYear2 <- NULL
df.es$StartYear2 <- NULL
df.es$EndYear2 <- NULL
df.ias$StartYear2 <- NULL
df.ias$EndYear2 <- NULL

# change colnames in df.irs, df.es, df.ias, so
# colnames in df.irs, df.es, df.ias, df.ns be the same

colnames(df.irs) <- colnames(df.ns)
colnames(df.es) <- colnames(df.ns)
colnames(df.ias) <- colnames(df.ns)

# vertical merge of all four datasets
df.all <- rbind(df.irs, df.es, df.ias, df.ns)

# remove duplicates
df.all <- unique(df.all)

df.unq <- data.frame()
for (i in unique(df.all$WarNum)) {
  df.tmp <- df.all[which(df.all$WarNum == i),]
  df.sngl <- data.frame(
    WarNum = df.tmp[1,1],
    WarName = df.tmp[1,2],
    WarType = df.tmp[1,3],
    WhereFought = df.tmp[1,4],
    StartYear = min(df.tmp$StartYear),
    EndYear = max(df.tmp$EndYear)
  )
  df.unq <- rbind(df.unq,df.sngl)
}

# fix data issues with wars had been ongoing at the time of dataset collection
# > df.unq[which(df.unq$EndYear < 0),]
#     WarNum                WarName WarType WhereFought StartYear EndYear
# 257    481      Afghan Resistance       3           7      2001      -7
# 528    856        Eighth Colombia       5           1      1989      -7
# 591    940 Second Sri Lanka Tamil       5           7      2006      -7
#
# according to Wikipedia
# http://en.wikipedia.org/wiki/Afghanistan "and the 2001–present war"
# http://en.wikipedia.org/wiki/Colombia "As of May 2014, the talks have represented breakthroughs."
# http://en.wikipedia.org/wiki/Sri_Lankan_Civil_War "19 May 2009 President Mahinda Rajapaksa delivered a victory"
df.unq[c(257,528,591),6] <- c(2014, 2014,2009)

# similar situation with NA in EndYear
# > df.unq[is.na(df.unq$EndYear),]
#     WarNum             WarName WarType WhereFought StartYear EndYear
# 328    585 Yellow Cliff Revolt       5           7      1866      NA
# 391    682   Sparticist Rising       7           2      1919      NA
df.unq[c(328,391),6] <- c(1866,1919)

# Define how to work with WarType and Regions
# 
# WarType: 
#1 = Inter-state war; 2= Colonial War; 3= Imperial War; 4 = Civil war for central control; 
# 5 = Civil war over local issues; 8 = wars between or among non-state entities that take place in non-state territory;
# 9 = wars between NSAs that take place across state borders
# 6 = Regional internal; 7 = Intercommunal
#
# WhereFought - Region(s) where combat involving the state occurred. Values are:
# 1 = W. Hemisphere; 2 = Europe; 4 = Africa; 6 = Middle East; 7 = Asia; 9 = Oceania;
# 11 = Europe & Middle East; 12 = Europe & Asia; 13 = W. Hemisphere & Asia
# 14 = Europe, Africa & Middle East; 15 = Europe, Africa, Middle East, & Asia
# 16 = Africa, Middle East, Asia & Oceania; 17 = Asia & Oceania;
# 18 = Africa & Middle East; 19 = Europe, Africa, Middle East, Asia & Oceania
df.lcn <- df.unq
df.lcn[,c('West Hemisphere','Europe','Africa','Middle East','Asia','Oceania')] <- 0

df.lcn[which(df.lcn$WhereFought ==1),'West Hemisphere'] <- 1
df.lcn[which(df.lcn$WhereFought ==2),'Europe'] <- 1
df.lcn[which(df.lcn$WhereFought ==4),'Africa'] <- 1
df.lcn[which(df.lcn$WhereFought ==6),'Middle East'] <- 1
df.lcn[which(df.lcn$WhereFought ==7),'Asia'] <- 1
df.lcn[which(df.lcn$WhereFought ==9),'Oceania'] <- 1
df.lcn[which(df.lcn$WhereFought ==11),c('Europe','Middle East')] <- 1
df.lcn[which(df.lcn$WhereFought ==12),c('Europe','Asia')] <- 1
df.lcn[which(df.lcn$WhereFought ==13),c('West Hemisphere','Asia')] <- 1
df.lcn[which(df.lcn$WhereFought ==14),c('Europe','Asia','Middle East')] <- 1
df.lcn[which(df.lcn$WhereFought ==15),c('Europe','Africa','Middle East','Asia')] <- 1
df.lcn[which(df.lcn$WhereFought ==16),c('Africa','Middle East','Asia','Oceania')] <- 1
df.lcn[which(df.lcn$WhereFought ==17),c('Asia','Oceania')] <- 1
df.lcn[which(df.lcn$WhereFought ==18),c('Africa','Middle East')] <- 1
df.lcn[which(df.lcn$WhereFought ==19),c('Europe','Africa','Middle East','Asia','Oceania')] <- 1

df.list <- data.frame(Year = numeric(),Region=character())
for (num in 1:length(df.lcn$WarNum)) {
  for (ayear in df.lcn[num,'StartYear']:df.lcn[num,'EndYear']) {
    for (reg in c('West Hemisphere','Europe','Africa','Middle East','Asia','Oceania')) {
      if(df.lcn[num,reg] != 0) {
        df.list <- rbind(df.list,data.frame(Year=ayear,Region=reg))
      }
    }
  }  
}

# density with multiplier
myhist <- list()
multiplier  <- list()
mydensity  <- list()
for (reg in c('West Hemisphere','Europe','Africa','Middle East','Asia','Oceania')) {
  myhist[[reg]] <- hist(df.list[which(df.list$Region==reg),'Year'])
  multiplier[[reg]] <- myhist[[reg]]$counts / myhist[[reg]]$density
  mydensity[[reg]] <- density(df.list[which(df.list$Region==reg),'Year'])
  mydensity[[reg]]$y <- mydensity[[reg]]$y * multiplier[[reg]][1]
}
