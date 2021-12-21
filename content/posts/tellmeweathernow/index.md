---
title: "TellMeWeatherNow!"
date: 2015-09-24
description: "GopherConIndia 2015 project made in Golang, shows weather of 5 cities concurrently."
weight: 1
link: https://github.com/yashrajsingh/tellmeweathernow-gopherconindia2015
repo: https://github.com/yashrajsingh/tellmeweathernow-gopherconindia2015
icon: icons/twn!.png
type: project
tags:
- challenge
- golang
- google-app-engine
categories:
- projects
- archived
---

## TellMeWeatherNow!

[TellMeWeatherNow!](http://tellmeweathernow.appspot.com/)

In September, 2014 I solved a challenge for selection of GopherConIndia 2015 scholars, I had to create a web based application for showing Weather updates for 5 cities concurrently, in Golang using Go Routines for concurrency. 

I did [got selected as a Student Scholar](http://www.gophercon.in/2015/scholarship/). You can view the [code on GitHub](https://github.com/yashrajsingh/tellmeweathernow-gopherconindia2015).

### Google App Engine with Go

I used an [online weather API available freely for use](http://developer.worldweatheronline.com/api/), for fetching the data. Go Routines made it possible to fetch the data concurrently and load them asynchroniously on the results page.
