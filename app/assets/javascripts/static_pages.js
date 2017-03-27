$(document).ready(function () {
  var pathName = window.location.pathname;
  if ($(window).width() <= 700) {
    $(".logo").css("max-width", "100px");
    $(".menu-main ul li a").css("font-size", "1.3em");
  }
  $(function () {
    if (window.location.href.indexOf("password_resets") != -1 ||
      window.location.href.indexOf("account_activations") != -1) {
      $(".fixed-menu").fadeOut();
      $(".activate-pw").modal("show");
      $(".activate-pw").on('hidden.bs.modal', function () {
        if (!$("#ajax-modal").hasClass("in")) {
          window.location.href = "/"
        }
        $("#ajax-modal").on('hide.bs.modal', function () {
          window.location.href = "/"
        });
      });
    } else if (pathName == "/") {
      $(window).scroll(function () {
        if ($(this).scrollTop() >= ($(window).height() / 1.4)) {
          $(".fixed-menu").fadeIn();
        }
        else {
          $(".fixed-menu").fadeOut();
          $("#search-form").parent().removeClass("search-form-modal");
        }
      });
    } else {
      $("header").fadeIn();
      $("#search-form").hide();
    }
  });
});
