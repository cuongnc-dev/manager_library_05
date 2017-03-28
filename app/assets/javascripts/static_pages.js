$(document).ready(function(){
  var pathName = window.location.pathname;
  var id, timer, left, top;
  var height = $(window).height();
  var width = $(window).width();
  $(function(){
    if (window.location.href.indexOf('password_resets') != -1 ||
      window.location.href.indexOf('account_activations') != -1){
      $('.fixed-menu').fadeOut();
      $('.activate-pw').modal('show');
      $('.activate-pw').on('hidden.bs.modal', function (){
        if (!$('#ajax-modal').hasClass('in')) {
          window.location.href = '/'
        }
        $('#ajax-modal').on('hide.bs.modal', function (){
          window.location.href = '/'
        });
      });
    } else if (pathName == '/') {
      $(window).scroll(function () {
        if ($(this).scrollTop() >= ($(window).height() / 1.4)) {
          $('.fixed-menu').fadeIn();
        }
        else {
          $('.fixed-menu').fadeOut();
          $('#search-form').parent().removeClass('search-form-modal');
        }
      });
    } else {
      $('header').fadeIn();
      $('#search-form').hide();
    }
  });
  $('.btn-search').on('click', function(){
    $('#search-form').show();
  });
  $('#custom_carousel').carousel({
    interval: 4000
  });
  $('#custom_carousel').on('slide.bs.carousel', function(evt){
    $('#custom_carousel .controls li.active').removeClass('active');
    $('#custom_carousel .controls li:eq('+$(evt.relatedTarget).index()+')').
      addClass('active');
  })
  $(function(){
    $('[data-toggle='tooltip']').tooltip();
  });
  $(document).on('mousemove', function(e){
    left = e.clientX;
    top = e.clientY;
  });
  $('.list-book .row .item').hover(function(e){
    id = $(this).attr('id');
    timer = setTimeout(function(){
      if (top < (height / 2)) {
        if (left < (width / 2)) {
          $('.' + id).css({'top': top, 'left': left}).fadeIn();
        } else {
          $('.' + id).css({'top': top, 'right': width - left}).fadeIn();
        }
      } else {
        if (left < (width / 2)){
          $('.' + id).css({'bottom': height - top, 'left': left}).fadeIn();
        } else {
          $('.' + id).css({'bottom': height - top,
            'right': width - left}).fadeIn();
        }
      }
    }, 1000);
  }, function(){
    clearTimeout(timer);
    $('.' + id).fadeOut();
  });
});
