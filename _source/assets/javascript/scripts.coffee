---
---

#####################################
#
# Base Functions
#
#####################################

parallax = (element, direction, start, stop, rate) ->
  $(window).scroll ->
    position = document.body.scrollTop

    if position >= start and position <= stop
      element.css direction, ($(window).scrollTop() * rate)


escapable = -> $('[data-escapable]').fadeOut()


presentation = (toggle) ->
  $toggle = $(toggle)
  $show   = $toggle.data("toggle-presentation")
  $presentation = $("[data-presentation='#{$show}']")

  $toggle.click -> $presentation.fadeIn()
  $presentation.click -> $(this).fadeOut()


Retina = ->
  pixelRatio = (if !!window.devicePixelRatio then window.devicePixelRatio else 1)

  if pixelRatio > 1
    $images = $('[data-retina]')
    $images.each ->
      $image = $(@)
      $image.attr 'src', $image.data 'retina'



#####################################
#
# Global Function Executions
#
#####################################

$ ->
  # Navigation
  $nav     = $(".nav-links")
  $links   = $(".nav-links-list li")
  $trigger = $(".nav-links-trigger")

  $trigger.click ->
    $this   = $(@)
    $status = $this.data "menu"
    $delay  = 0

    switch $status
      when "closed"
        $this.data "menu", "open"
        $nav.addClass "nav-links-expanded"
        $links.each ->
          $(@).css opacity: 0
          $(@).delay($delay).fadeTo 300, 1
          $delay += 25
      when "open"
        $this.data "menu", "closed"
        $nav.removeClass "nav-links-expanded"

  # Escape
  $(window).keydown (event) ->
    switch event.keyCode
      when 27 then escapable()


  # Parallax
  $parallaxable = $('[data-parallax]')
  if $parallaxable.length
    $parallaxable.each ->
      $this = $(this)
      $direction = $this.data('parallax-direction')
      $start = $this.data('parallax-start')
      $stop = $this.data('parallax-stop')
      $rate = $this.data('parallax-rate')
      parallax $this, $direction, $start, $stop, $rate


  # Presentations
  $presentationToggles = $("[data-toggle-presentation]")
  if $presentationToggles.length
    $presentationToggles.each ->
      presentation this

  # Swap retina-ready images
  Retina()



#####################################
#
# Page: /is
#
#####################################

toggleBiography = (bio) ->
  swap = (bio) ->
    $bio = $('.about-biography')
    $bio.find('article').fadeOut ->
      $bio.find(bio).fadeIn()

  position = document.body.scrollTop

  if position > 200
    $('body').animate scrollTop: 0,
      duration: 500
      complete: -> swap bio
  else
    swap bio

$ ->
  # Biography Toggle
  $('[data-toggle-bio]').click -> toggleBiography $(this).data('toggle-bio')



#####################################
#
# Page: /essays
#
#####################################

$ ->
  filterEssays = (essayType) ->
    $essays = $('.writes-essays-list')
    $essaysList = $essays.find('li')
    $nonfavorites = $essays.find('li:not([data-favorite])')
    $favoriteToggle = $('[data-essay-filter~="favorites"]')

    switch essayType
      when 'favorites'
        if $favoriteToggle.hasClass 'selected' then $nonfavorites.show() else $nonfavorites.hide()
        $favoriteToggle.toggleClass 'selected'
      when 'recent'
        $essaysList.sort(newestFirst).appendTo $essays
      when 'shortest'
        $essaysList.sort(shortestFirst).appendTo $essays

  shortestFirst = (a, b) ->
    if ($(b).data('words')) < ($(a).data('words')) then 1 else -1

  longestFirst = (a, b) ->
    if ($(b).data('words')) > ($(a).data('words')) then 1 else -1

  newestFirst = (a, b) ->
    if ($(b).data('date')) < ($(a).data('date')) then 1 else -1

  oldestFirst = (a, b) ->
    if ($(b).data('date')) > ($(a).data('date')) then 1 else -1


  if $(".writes-essays").length
    $essays = $('[data-essays]')
    $essaysList = $essays.find('li')

    # Estimated reading time
    $essaysList.each ->
      $words = $(this).data('words')
      $readingTime = Math.floor($words / 3)

      if $readingTime < 60
        $(this).find('[data-reading-time]').text $readingTime + ' second read'
      else
        $readingTime = Math.floor($readingTime / 60)
        $(this).find('[data-reading-time]').text $readingTime + ' minute read'


    # Fade each essay in
    $delay = 0
    $essaysList.each ->
      $delay += 50
      $(this).css opacity: 0
      $(this).delay($delay).fadeTo 500, 1


    # Essay filtering
    $('[data-essay-filter]').click ->
      filterEssays $(this).data('essay-filter')

      if $(this).find('span').hasClass 'essay-ui-radio'
        $(this).addClass 'selected'
        $(this).siblings().removeClass 'selected'


    # Relative essay time
    $essayDates = $("[data-essay-date]")
    $essayDates.each ->
      $(this).text relativeTime $(this).data("essay-date")


  # Fade each thought in
  $thoughtList = $('[data-thought]')
  $thoughtList.each ->
    $delay += 50
    $(this).css opacity: 0
    $(this).delay($delay).fadeTo 500, 1


relativeTime = do ->
  ints = undefined
  ints =
    second: 1
    minute: 60
    hour: 3600
    day: 86400
    week: 604800
    month: 2592000
    year: 31536000
  (time) ->
    amount = undefined
    gap = undefined
    i = undefined
    measure = undefined
    time = +new Date(time)
    gap = (+new Date - time) / 1000
    amount = undefined
    measure = undefined
    for i of ints
      `i = i`
      if gap > ints[i]
        measure = i
    amount = gap / ints[measure]
    amount = if gap > ints.day then Math.round(amount) else Math.round(amount)
    amount += ' ' + measure + (if amount > 1 then 's' else '') + ' ago'
    amount