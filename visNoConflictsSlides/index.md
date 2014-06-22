---
title       : Number of conflicts in regions
subtitle    : from 1825 to 2005
author      : Dmitry Borisoglebsky
job         : R&D
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : prettify  # {highlight.js, prettify, highlight}
hitheme     : solarized_light      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

I see two major factors making the world less stable than before, an accelerating rise of science and technology, and rise of China with stabilizing EU, Russia, and India. This presentation provides a loose analysis of the latter.

The simplest indicator of conflicting geo-political ambitions is the number of wars in different regions of the world. Plotting these numbers may give a very high level view of the world's dynamics. This presentation delivers the plot.

--- 

## Data

Data from <a href="http://www.correlatesofwar.org/COW2%20Data/WarData_NEW/WarList_NEW.html">Correlates of War Project, v4.0</a> were used, including:
- Inter-state wars, i.e. between the recognized states.
- Intra-state wars, i.e. within a state.
- Extra-state wars, i.e. between state and non-state entity.
- Non-state wars, i.e. with <span title="Previously, the Correlates of War (COW) Project has examined only wars that involved the government of a member of the interstate system (a state) in one form or another. The inclusion of non-state wars in the data presented here represents an attempt to broaden our understanding of war by including wars between or among non-state entities. Such entities include governments of other types of geopolitical units (GPUs), such as dependencies or non-state autonomous entities, that do not meet the criteria of system membership. They also might involve nonterritorial entities (NTEs) or non-state armed groups (NSAs) that have no defined territorial base.">non-state entities.</span>

These datasets are merged and shaped for presentation, few cases of incomplete observations were updated.

The world is divided into six regions within the datasets, namely: West Hemisphere, Europe, Africa, Middle East, Asia, and Oceania.

--- 

## Results



```
## [1] "000"
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-11.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-12.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-13.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-14.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-15.png) ![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-16.png) 

```
## [1] "aaa"
```

```
##   Year          Region
## 1 1823          Europe
## 2 1828          Europe
## 3 1828     Middle East
## 4 1829          Europe
## 5 1829     Middle East
## 6 1846 West Hemisphere
```

```
## [1] "bbb"
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-17.png) 

--- 

## <del>Conclusions</del> Speculations

Some historians think that First and Second World wars were actually one war with a ~20 years time gap in between, because before there were certain empires having colonies, and after there were first, second, and third worlds. The plot is showing that wars were in decline in Europe and Western Hemisphere before this war. Wars were mostly in decline before this major world war.

The increase of wars in Asia, Africa, and South America are likely explained by ambitions of superpowers and post-decolonization processes. The number of wars were falling after the fall of USSR.

With the rising power of China, EU, and Russia the number of conflicts might increase. Considering the previous pattern of wars on the borders of 'emprires', conflicts are likely to happen in South and Central America (the boder of USA), South Asia (the border of China), and Middle East (the borders of EU, Russia, and China).

Currently there is an ongoing conflict in between EU and Russia, using these primitive speculations, this conflict might be harmful/beneficial to EU and Russia, and beneficial/harmful to USA and China. 
