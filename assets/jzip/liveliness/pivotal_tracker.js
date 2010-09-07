$('.application.login .pivotal_tracker_wrapper form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var indicator = form.find('.indicator');
  var button = form.find('input.submit');
  var wrapper = form.closest('.pivotal_tracker_wrapper');
  
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


$('.application.login .pivotal_tracker_wrapper .projects_wrapper .project a.project_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var indicator = a.closest('.project').find('.indicator');
  var wrapper = a.closest('.pivotal_tracker_wrapper');
  
  $.ajax({
    url: url,
    type: 'POST',
    beforeSend: function() { a.hide(); indicator.show(); },
    complete: function() { a.show(); indicator.hide(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
  event.preventDefault();
});