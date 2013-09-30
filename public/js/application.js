$(document).ready(function() {
 $('form').submit(function (event){
  event.preventDefault();
  $('span').append('<img src="/images/ajax-loader.gif">');
  // $('span').text('Processing').show().fadeOut(5000);
  var url = $(this).attr('action');
  var data = $(this).serialize();
  $.post(url, data, function(response){
    $('.hey').append(response);
    $('span').remove();
  });
 });
});
