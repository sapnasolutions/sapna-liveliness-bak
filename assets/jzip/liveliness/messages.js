function show_message(type, message) {
  $('.messages.'+type).html(message);
  $('.messages.'+type).addClass('padding');
  $('.messages.'+type).show();
  setTimeout(function(){
    $('.messages.'+type).fadeOut();
  }, 3000);
}

function show_error_message(message) { show_message('error', message); }
function show_notice_message(message) { show_message('notice', message); }