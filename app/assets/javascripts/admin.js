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
        aImg.src = e.target.result;
      };
    })(img);
    reader.readAsDataURL(file);
  }
}
