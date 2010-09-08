$('.application.login .github_wrapper form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var indicator = form.find('.indicator');
  var button = form.find('input.submit');
  var wrapper = form.closest('.github_wrapper');
  
  base_ajax_form_post(url, form.serialize(), button, indicator, wrapper);
  
  event.preventDefault();
});

$('.application.login .github_wrapper .repositories_wrapper .repository a.repository_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.repositories');
  var indicator = a.closest('.repositories_wrapper').find('.big_indicator');
  var wrapper = a.closest('.github_wrapper');  
  
  base_ajax_post(url, list, indicator, wrapper);

  event.preventDefault();
});
