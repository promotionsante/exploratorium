$( document ).ready(function() {

 $(document).on('shiny:connected', function(event) {
    var screen_width = document.documentElement.clientWidth;
    Shiny.setInputValue("screen_width", screen_width)
  });

});

