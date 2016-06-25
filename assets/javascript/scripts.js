(function() {
  var Retina, escapable, parallax, presentation, relativeTime, toggleBiography;

  parallax = function(element, direction, start, stop, rate) {
    return $(window).scroll(function() {
      var position;
      position = document.body.scrollTop;
      if (position >= start && position <= stop) {
        return element.css(direction, $(window).scrollTop() * rate);
      }
    });
  };

  escapable = function() {
    return $('[data-escapable]').fadeOut();
  };

  presentation = function(toggle) {
    var $presentation, $show, $toggle;
    $toggle = $(toggle);
    $show = $toggle.data("toggle-presentation");
    $presentation = $("[data-presentation='" + $show + "']");
    $toggle.click(function() {
      return $presentation.fadeIn();
    });
    return $presentation.click(function() {
      return $(this).fadeOut();
    });
  };

  Retina = function() {
    var $images, pixelRatio;
    pixelRatio = (!!window.devicePixelRatio ? window.devicePixelRatio : 1);
    if (pixelRatio > 1) {
      $images = $('[data-retina]');
      return $images.each(function() {
        var $image;
        $image = $(this);
        return $image.attr('src', $image.data('retina'));
      });
    }
  };

  $(function() {
    var $links, $nav, $parallaxable, $presentationToggles, $trigger;
    $nav = $(".nav-links");
    $links = $(".nav-links-list li");
    $trigger = $(".nav-links-trigger");
    $trigger.click(function() {
      var $delay, $status, $this;
      $this = $(this);
      $status = $this.data("menu");
      $delay = 0;
      switch ($status) {
        case "closed":
          $this.data("menu", "open");
          $nav.addClass("nav-links-expanded");
          return $links.each(function() {
            $(this).css({
              opacity: 0
            });
            $(this).delay($delay).fadeTo(300, 1);
            return $delay += 25;
          });
        case "open":
          $this.data("menu", "closed");
          return $nav.removeClass("nav-links-expanded");
      }
    });
    $(window).keydown(function(event) {
      switch (event.keyCode) {
        case 27:
          return escapable();
      }
    });
    $parallaxable = $('[data-parallax]');
    if ($parallaxable.length) {
      $parallaxable.each(function() {
        var $direction, $rate, $start, $stop, $this;
        $this = $(this);
        $direction = $this.data('parallax-direction');
        $start = $this.data('parallax-start');
        $stop = $this.data('parallax-stop');
        $rate = $this.data('parallax-rate');
        return parallax($this, $direction, $start, $stop, $rate);
      });
    }
    $presentationToggles = $("[data-toggle-presentation]");
    if ($presentationToggles.length) {
      $presentationToggles.each(function() {
        return presentation(this);
      });
    }
    return Retina();
  });

  toggleBiography = function(bio) {
    var position, swap;
    swap = function(bio) {
      var $bio;
      $bio = $('.about-biography');
      return $bio.find('article').fadeOut(function() {
        return $bio.find(bio).fadeIn();
      });
    };
    position = document.body.scrollTop;
    if (position > 200) {
      return $('body').animate({
        scrollTop: 0
      }, {
        duration: 500,
        complete: function() {
          return swap(bio);
        }
      });
    } else {
      return swap(bio);
    }
  };

  $(function() {
    return $('[data-toggle-bio]').click(function() {
      return toggleBiography($(this).data('toggle-bio'));
    });
  });

  $(function() {
    var $delay, $essayDates, $essays, $essaysList, $thoughtList, filterEssays, longestFirst, newestFirst, oldestFirst, shortestFirst;
    filterEssays = function(essayType) {
      var $essays, $essaysList, $favoriteToggle, $nonfavorites;
      $essays = $('.writes-essays-list');
      $essaysList = $essays.find('li');
      $nonfavorites = $essays.find('li:not([data-favorite])');
      $favoriteToggle = $('[data-essay-filter~="favorites"]');
      switch (essayType) {
        case 'favorites':
          if ($favoriteToggle.hasClass('selected')) {
            $nonfavorites.show();
          } else {
            $nonfavorites.hide();
          }
          return $favoriteToggle.toggleClass('selected');
        case 'recent':
          return $essaysList.sort(newestFirst).appendTo($essays);
        case 'shortest':
          return $essaysList.sort(shortestFirst).appendTo($essays);
      }
    };
    shortestFirst = function(a, b) {
      if (($(b).data('words')) < ($(a).data('words'))) {
        return 1;
      } else {
        return -1;
      }
    };
    longestFirst = function(a, b) {
      if (($(b).data('words')) > ($(a).data('words'))) {
        return 1;
      } else {
        return -1;
      }
    };
    newestFirst = function(a, b) {
      if (($(b).data('date')) < ($(a).data('date'))) {
        return 1;
      } else {
        return -1;
      }
    };
    oldestFirst = function(a, b) {
      if (($(b).data('date')) > ($(a).data('date'))) {
        return 1;
      } else {
        return -1;
      }
    };
    if ($(".writes-essays").length) {
      $essays = $('[data-essays]');
      $essaysList = $essays.find('li');
      $essaysList.each(function() {
        var $readingTime, $words;
        $words = $(this).data('words');
        $readingTime = Math.floor($words / 3);
        if ($readingTime < 60) {
          return $(this).find('[data-reading-time]').text($readingTime + ' second read');
        } else {
          $readingTime = Math.floor($readingTime / 60);
          return $(this).find('[data-reading-time]').text($readingTime + ' minute read');
        }
      });
      $delay = 0;
      $essaysList.each(function() {
        $delay += 50;
        $(this).css({
          opacity: 0
        });
        return $(this).delay($delay).fadeTo(500, 1);
      });
      $('[data-essay-filter]').click(function() {
        filterEssays($(this).data('essay-filter'));
        if ($(this).find('span').hasClass('essay-ui-radio')) {
          $(this).addClass('selected');
          return $(this).siblings().removeClass('selected');
        }
      });
      $essayDates = $("[data-essay-date]");
      $essayDates.each(function() {
        return $(this).text(relativeTime($(this).data("essay-date")));
      });
    }
    $thoughtList = $('[data-thought]');
    return $thoughtList.each(function() {
      $delay += 50;
      $(this).css({
        opacity: 0
      });
      return $(this).delay($delay).fadeTo(500, 1);
    });
  });

  relativeTime = (function() {
    var ints;
    ints = void 0;
    ints = {
      second: 1,
      minute: 60,
      hour: 3600,
      day: 86400,
      week: 604800,
      month: 2592000,
      year: 31536000
    };
    return function(time) {
      var amount, gap, i, measure;
      amount = void 0;
      gap = void 0;
      i = void 0;
      measure = void 0;
      time = +new Date(time);
      gap = (+(new Date) - time) / 1000;
      amount = void 0;
      measure = void 0;
      for (i in ints) {
        i = i;
        if (gap > ints[i]) {
          measure = i;
        }
      }
      amount = gap / ints[measure];
      amount = gap > ints.day ? Math.round(amount) : Math.round(amount);
      amount += ' ' + measure + (amount > 1 ? 's' : '') + ' ago';
      return amount;
    };
  })();

}).call(this);
