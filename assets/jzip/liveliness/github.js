// ========== LOGIN ==========
$('.application.login .github_wrapper form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var indicator = form.find('.indicator');
  var button = form.find('input.submit');
  var wrapper = form.closest('.github_wrapper');
  
  base_ajax_form_post(url, form.serialize(), button, indicator, wrapper);
  
  event.preventDefault();
});

// ========== REPOSITORY ==========
$('.application.login .github_wrapper .repositories_wrapper .repository a.repository_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.repositories');
  var indicator = a.closest('.repositories_wrapper').find('.big_indicator');
  var wrapper = a.closest('.github_wrapper');  
  
  base_ajax_post(url, list, indicator, wrapper);

  event.preventDefault();
});

// ========== COLLABOTRATORS ==========
$('.application.login .github_wrapper .collaborators_wrapper .collaborator a.collaborator_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.collaborators');
  var indicator = a.closest('.collaborators_wrapper').find('.big_indicator');
  var wrapper = a.closest('.github_wrapper');  
  
  show_date_interval(url, list, indicator, wrapper);

  event.preventDefault();
});

// // ========== DATES ==========
// $('.application.login .github_wrapper .dates_wrapper .dates form').live('submit', function(event){
//   var form = $(this);
//   var url = form.attr('action');
//   var list = form.closest('.dates');
//   var indicator = form.closest('.dates_wrapper').find('.big_indicator');
//   var wrapper = form.closest('.github_wrapper');  
//   
//   base_ajax_post(url, list, indicator, wrapper);
// 
//   event.preventDefault();
// });

// ========== GO BACK: REPOSITORIES ==========
function go_back_on_repositories(elt, prefix) {
  var url = elt.attr('href');
  var list = elt.closest('.' + prefix);
  var wrapper = elt.closest('.'+prefix+'_wrapper');
  var indicator = wrapper.find('.big_indicator_repositories');

  base_ajax_get(url, list, indicator, wrapper);
}

$('.collaborators_wrapper .navigation a.repositories_list_link').live('click', function(event){
  go_back_on_repositories($(this), 'collaborators');
  event.preventDefault();
});

$('.dates_wrapper .navigation a.repositories_list_link').live('click', function(event){
  go_back_on_projects($(this), 'dates');
  event.preventDefault();
});

$('.wait_for_wrapper .navigation a.repositories_list_link').live('click', function(event){
  go_back_on_projects($(this), 'wait_for');
  event.preventDefault();
});

// ========== GO BACK: COLLABORATORS ==========
function go_back_on_collaborators(elt, prefix) {
  var url = elt.attr('href');
  var list = elt.closest('.' + prefix);
  var wrapper = elt.closest('.'+prefix+'_wrapper');
  var indicator = wrapper.find('.big_indicator_collaborators');

  base_ajax_get(url, list, indicator, wrapper);
}

$('.dates_wrapper .navigation a.collaborators_list_link').live('click', function(event){
  go_back_on_members($(this), 'dates');
  event.preventDefault();
});

$('.wait_for_wrapper .navigation a.collaborators_list_link').live('click', function(event){
  go_back_on_members($(this), 'wait_for');
  event.preventDefault();
});