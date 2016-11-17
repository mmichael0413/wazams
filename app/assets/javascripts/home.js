$(document).ready(function() {

  $('#message_submit').on('click', function() {
    var selectedImageUrl = $('#results span img.selected')[0].src;
    var phone = $('#phone')[0].value;

    $.ajax({
      type: 'POST',
      data: { 'phone': phone, 'url': selectedImageUrl },
      url: '/messages',
      success: function(response) {
        $('.form_success').fadeIn(200).delay(3000).fadeOut(200);
        resetValues();
      },
      error: function(xhr, status, error) {
        $('.form_error').fadeIn(200).delay(3000).fadeOut(200);
      }
    });
  });

});

function resetValues() {
  $('#results').html('');
  $('#search')[0].value = '';
  $('#phone')[0].value = '';
}