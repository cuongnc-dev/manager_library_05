$(document).ready(function(){
  var pathName = window.location.pathname;
  $(function(){
    var level = 0;
    var subCategory = $('.dropdown-submenu.level-' + level);
    loadCategory(level, subCategory);
  });
  function loadCategory(level, subCategory){
    level++;
    subCategory.each(function(){
      var id = $(this).find('.category-menu').attr('id');
      var parent = $(this);
      $.ajax({
        url: '/',
        type: 'get',
        data: {subcategory_id: id, menu_level: level},
        dataType: 'json',
        success: function(result){
          parent.append('<ul class="dropdown-menu"></ul>');
          for (i = 0; i < result.length; i++) {
            parent.find('.dropdown-menu').append('<li class="dropdown-submenu '
              + 'level-' + level + '">' + '<a class="category-menu"'
              + 'href="/books?find_by=Subcategory&key_word='
              + result[i].name +'", id="' + result[i].id + '">'
              + result[i].name + '</a></li>');
          }
        }
      });
    });
    subCategory = $('.dropdown-submenu.level-' + level);
    loadCategory(level, subCategory);
  };
  $('.category-menu').on('mouseover', function(){
    $('.category-menu').removeClass('active');
    $('.dropdown-menu .dropdown-submenu .dropdown-menu').hide();
    $(this).addClass('active');
    $(this).parent('li').find('.dropdown-menu').show();
  });
  $(document).click(function (e){
    var dropdown = $('.dropdown-menu');
    if (!dropdown.is(e.target) && dropdown.has(e.target).length === 0){
      $('.category-menu').removeClass('active');
      $('.dropdown-submenu > .dropdown-menu').hide();
    }
  });
  $(function(){
    var parent = $('.category-menu').parents('ul');
    parent = parent.parent('li');
    if (!parent.hasClass('open')) {
      $('.category-menu').removeClass('active');
      $('.dropdown-submenu > .dropdown-menu').hide();
    }
  })
  $(function(){
    if (window.location.href.indexOf('password_resets') != -1 ||
      window.location.href.indexOf('account_activations') != -1){
      $('.fixed-menu').hide();
      $('.activate-pw').modal('show');
      $('.activate-pw').on('hidden.bs.modal', function(){
        if (!$('#ajax-modal').hasClass('in')){
          window.location.href = '/'
        }
        $('#ajax-modal').on('hide.bs.modal', function(){
          window.location.href = '/'
        });
      });
    }
  });
  $('.btn-search').on('click', function(){
    $('#search-form').show();
  });
  $('#new_book_carousel').carousel({
    interval: 4000
  });
  $('#new_book_carousel').on('slide.bs.carousel', function(evt){
    $('#new_book_carousel .controls li.active').removeClass('active');
    $('#new_book_carousel .controls li:eq('+$(evt.relatedTarget).index()+')').
      addClass('active');
  });
  $('#high_rating_carousel').carousel({
    interval: 4000
  });
  $('#high_rating_carousel').on('slide.bs.carousel', function(evt){
    $('#high_rating_carousel .controls li.active').removeClass('active');
    $('#high_rating_carousel .controls li:eq('+$(evt.relatedTarget).index()+')').
      addClass('active');
  });
  $(function(){
    $('[data-toggle="tooltip"]').tooltip();
  });
  $(document).on('focus', '#request_start_day', function(){
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
  });
  $(document).on('focus', '#request_end_day', function(){
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
  });
});
