function showMyImage(fileInput) {
  var files = fileInput.files;
  for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var imageType = /image.*/;
    if (!file.type.match(imageType)) {
      continue;
    }
    var img = document.getElementById('thumb');
    img.file = file;
    var reader = new FileReader();
    reader.onload = (function(aImg) {
      return function(e) {
        $('.bg').removeClass('bg');
        if (file.width > file.height) {
          $('.img-avatar').css({
            width: '100%',
            height: 'auto'
          });
        } else {
          $('.img-avatar').css({
            width: 'auto',
            height: '100%'
          });
        }
        aImg.src = e.target.result;
      };
    })(img);
    reader.readAsDataURL(file);
  }
}

$(document).ready(function(){
  $('.filterable .btn-filter').click(function(){
    var panel = $(this).parents('.filterable');
    var filters = panel.find('.filters input');
    var tbody = panel.find('.table tbody');;
    if (filters.prop('disabled') == true) {
      $('.btn-filter span').removeClass('glyphicon-filter')
        .addClass('glyphicon-remove');
      filters.prop('disabled', false);
      filters.css('text-align', 'left');
      filters.first().focus();
      $('div.pagination').hide();
    } else {
      $('.btn-filter span').removeClass('glyphicon-remove')
        .addClass('glyphicon-filter');
      filters.css('text-align', 'center');
      filters.val('').prop('disabled', true);
      tbody.find('.no-result').remove();
      tbody.find('tr').show();
      $('div.pagination').show();
    }
  });
  $('.filterable .filters input').keyup(function(e){
    var code = e.keyCode || e.which;
    if (code == '9') return;
    var input = $(this);
    var inputContent = input.val().toLowerCase();
    var panel = input.parents('.filterable');
    var column = panel.find('.filters th').index(input.parents('th'));
    var table = panel.find('.table');
    var rows = table.find('tbody tr');
    var filteredRows = rows.filter(function(){
      var value = $(this).find('td').eq(column).text().toLowerCase();
      return value.indexOf(inputContent) === -1;
    });
    table.find('tbody .no-result').remove();
    rows.show();
    filteredRows.hide();
    if (filteredRows.length === rows.length) {
      table.find('tbody').prepend('<tr class="no-result text-center"><td colspan="'
        + table.find('.filters th').length +'">No result found</td></tr>');
    }
  });
  $(document).on('focus', '#from_day', function(){
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
  });
  $(document).on('focus', '#to_day', function(){
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
  });
  $('#from_day').on('change', function(){
    if ($(this).val() != '') {
      $(this).parent('p').find('i').show();
    } else {
      $(this).parent('p').find('i').hide();
    }
  });
  $('#to_day').on('change', function(){
    if ($(this).val() != '') {
      $(this).parent('p').find('i').show();
    } else {
      $(this).parent('p').find('i').hide();
    }
  });
  $('.date-remove').on('click', function(){
    $(this).parent('p').find('input').val('');
    $(this).hide();
  });
  $('.search-button .glyphicon-search').on('click', function(){
    $('.search-by-button').removeClass('active');
    $('.search-by form #key').val('').hide();
    $('.search-button > div').slideToggle();
    $(this).toggleClass('active');
  });
  $('.search-by-button').on('click', function(){
    $('.search-by-button').removeClass('active');
    $('.search-by form #key').val('').animate({width: 'hide'}, 500);
    $(this).addClass('active');
    $(this).parent('.search-by').find('form #key').animate({width: 'show'}, 700);
  });
  $(document).click(function (e){
    var searchDiv = $('.search-button');
    if (!searchDiv.is(e.target) && searchDiv.has(e.target).length === 0){
      $('.search-by-button').removeClass('active');
      $('.search-by form #key').val('').hide();
      $('.search-button > div').slideUp();
      $('.search-button .glyphicon-search').removeClass('active');
    }
  });
  $('.rd-user').on('click', function(){
    $(this).parents('form').submit();
  });
  $('.rd-activate').on('click', function(){
    $(this).parents('form').submit();
  });
  $('.status-submit').on('click', function(e){
    var arr_status = new Array();
    var url = '/admin/requests?find_by=Status&status='
    if ($('#Processing').is(':checked')) {
      arr_status.push(0);
    }
    if ($('#Accepted').is(':checked')) {
      arr_status.push(1);
    }
    if ($('#Rejected').is(':checked')) {
      arr_status.push(2);
    }
    if ($('#Borrowed').is(':checked')) {
      arr_status.push(3);
    }
    if ($('#Returned').is(':checked')) {
      arr_status.push(4);
    }
    url += arr_status;
    window.location.href = url;
  });
  $('#find_date_by').on('change', function(){
    if ($(this).val() == 0 || $(this).val() == 2) {
      $('p.to-day').css('display', 'none');
    } else {
      $('p.to-day').css('display', 'table-cell');
    }
  })
});
