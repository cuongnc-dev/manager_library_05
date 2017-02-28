$(document).ready(function () {
  var search = $("#search-form");
  var leftWidth = ($(window).width() - search.width()) / 2;
  search.css({"left": leftWidth});
  if ($(window).width() <= 700) {
    $(".logo").css("max-width", "100px");
    $(".menu-main ul li a").css("font-size", "1.3em");
  }
  $(window).resize(function () {
    location.reload();
  });
  $(function () {
    if ($(this).scrollTop() == 0) {
      $("header").css("display", "none");
    }
    $(window).scroll(function () {
      if ($(this).scrollTop() >= $(window).height()) {
        $("header").fadeIn();
      }
      else {
        $("header").fadeOut();
        $("#search-form").css({"position": "absolute", "top": "60%", "left": leftWidth});
      }
    });
  });
  $(".btn-search").click(function () {
    $("#search-form").each(function () {
      this.style.setProperty( "position", "fixed", "important" );
    });
  });
  $("html").click(function (e) {
    if (e.target.id !== "search-form" && $(e.target).parents("#search-form").length == 0
      && $(e.target).parents(".fixed-menu").length == 0) {
      $("#search-form").each(function () {
        this.style.setProperty("position", "absolute", "important");
      });
    }
  });
});
