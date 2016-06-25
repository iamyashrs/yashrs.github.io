---
title: "TellMeWeatherNow!"
layout: project
category: projects
favorite: true
preview: Made in Golang, shows weather of 5 cities concurrently.
bio: TellMeWeatherNow - GopherConIndia 2015
image: /assets/images/projects/tellmeweathernow/thumb.png
do_not_show_details: true
---

<div class="project project-phone clear-left spacing-one width-one">
  <a href="http://tellmeweathernow.appspot.com/" target="_blank">
    {% project tellmeweathernow, ss_mobile, png %}
  </a>
</div>

<div class="project project-website fit-right width-three">
  <a href="http://tellmeweathernow.appspot.com/" target="_blank">
    {% project tellmeweathernow, ss, png %}
  </a>
</div>

<div class="project-description width-three">
  <h3><a href="http://tellmeweathernow.appspot.com/" target="_blank">TellMeWeatherNow!</a></h3>
  <p>In September, 2014 I solved a challenge for selection of GopherConIndia 2015 scholars, I had to create a web based application for showing Weather updates for 5 cities concurrently, in Golang using Go Routines for concurrency. I did <a href="http://www.gophercon.in/2015/scholarship/" target="_blank">got selected as a Student Scholar</a>. You can view the <a href="https://github.com/yashrajsingh/tellmeweathernow-gopherconindia2015" target="_blank">code on GitHub</a>.</p>
</div>

<div class="project spacing-three width-one">
  <a href="http://www.gophercon.in/" target="_blank" title="GOPHERCON INDIA 2015, The First-Ever Go Conference in India @Bengaluru">
    {% project tellmeweathernow, gophercon, png %}
  </a>
</div>

<div class="project project-website project-google-city clear-left width-three">
  {% project tellmeweathernow, ss2, png %}
</div>

<div class="project-description project-description-google-city fit-right width-two">
  <h3>Google App Engine with Go</h3>
  <p>I used an <a href="http://developer.worldweatheronline.com/api/" target="_blank">online weather API available freely for use</a>, for fetching the data. Go Routines made it possible to fetch the data concurrently and load them asynchroniously on the results page.</p>
</div>

<div class="project project-logo spacing-three width-one">
    {% icons app_engine, png  %}
</div>

<div class="project project-logo width-one">
  {% icons golang, png %}
</div>