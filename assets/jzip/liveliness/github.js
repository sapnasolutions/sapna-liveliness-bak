$('.application.login .github_wrapper form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var indicator = form.find('.indicator');
  var button = form.find('input.submit');
  var wrapper = form.closest('.github_wrapper');
  
  $.ajax({
    url: url,
    type: 'POST',
    data: form.serialize(),
    beforeSend: function() { button.hide(); indicator.show(); },
    complete: function() { button.hide(); indicator.show(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
  
  event.preventDefault();
});

$('.application.login .github_wrapper .repositories_wrapper .repository a.repository_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.repositories');
  var indicator = a.closest('.repositories_wrapper').find('.big_indicator');
  var wrapper = a.closest('.github_wrapper');  
  
  $.ajax({
    url: url,
    type: 'POST',
    beforeSend: function() { list.hide(); indicator.show(); },
    complete: function() { list.show(); indicator.hide(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
  event.preventDefault();
});
