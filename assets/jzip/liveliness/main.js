function base_ajax_form_post(url, data, button, indicator, wrapper) {
  $.ajax({
    url: url,
    type: 'POST',
    data: data,
    beforeSend: function() { button.hide(); indicator.show(); },
    complete: function() { button.hide(); indicator.show(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
}

function base_ajax_post(url, button, indicator, wrapper) {
  $.ajax({
    url: url,
    type: 'POST',
    beforeSend: function() { button.hide(); indicator.show(); },
    complete: function() { button.hide(); indicator.show(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
}

function base_ajax_get(url, button, indicator, wrapper) {
  $.ajax({
    url: url,
    beforeSend: function() { button.hide(); indicator.show(); },
    complete: function() { button.hide(); indicator.show(); },
    success: function(s) { wrapper.html(s); },
    error: function(e) { 
      json = JSON.parse(e.responseText);
      wrapper.html(json.form);
      show_error_message(json.error_message);
    }
  });
}

function init_date_picker(class, hidden_input_field) {
  $(function() {
    Date.format = 'yyyy/mm/dd';
    var hiddenInput = $(hidden_input_field);        
  	$(class)
  		.datePicker({
  		  inline:true,
  		  startDate:'1996-01-01'
  		})
  		.bind('dateSelected', function(e, selectedDate, $td) {
  				hiddenInput.val(selectedDate.asString());          
  			});
  });
}

function show_date_interval(url, list, indicator, wrapper) {
  $.ajax({
    url: url,
    type: 'POST',
    beforeSend: function() { list.hide(); indicator.show(); },
    complete: function() { list.show(); indicator.hide(); },
    error: function(e) { wrapper.html(e.responseText); },
    success: function(s) { $('body').find('.wrapper').slideUp(); $('body').find('#date_interval').html(s); }
  });
}