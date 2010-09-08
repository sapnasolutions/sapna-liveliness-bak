// ========== LOGIN ==========
$('.application.login .pivotal_tracker_wrapper form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var indicator = form.find('.indicator');
  var button = form.find('input.submit');
  var wrapper = form.closest('.pivotal_tracker_wrapper');
  
  base_ajax_form_post(url, form.serialize(), button, indicator, wrapper);
  
  event.preventDefault();
});

// ========== PROJECT ==========
$('.application.login .pivotal_tracker_wrapper .projects_wrapper .project a.project_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.projects');
  var indicator = a.closest('.projects_wrapper').find('.big_indicator');
  var wrapper = a.closest('.pivotal_tracker_wrapper');  
  
  base_ajax_post(url, list, indicator, wrapper);
    
  event.preventDefault();
});

// ========== MEMBERS ==========
$('.application.login .pivotal_tracker_wrapper .members_wrapper .member a.member_link').live('click', function(event){
  var a = $(this);
  var url = a.attr('href');
  var list = a.closest('.members');
  var indicator = a.closest('.members_wrapper').find('.big_indicator');
  var wrapper = a.closest('.pivotal_tracker_wrapper');  
  
  base_ajax_post(url, list, indicator, wrapper);

  event.preventDefault();
});

// ========== DATES ==========
$('.application.login .pivotal_tracker_wrapper .dates_wrapper .dates form').live('submit', function(event){
  var form = $(this);
  var url = form.attr('action');
  var list = form.closest('.dates');
  var indicator = form.closest('.dates_wrapper').find('.big_indicator');
  var wrapper = form.closest('.pivotal_tracker_wrapper');  
  
  base_ajax_post(url, list, indicator, wrapper);

  event.preventDefault();
});

// ========== GO BACK: PROJECTS ==========
$('.members_wrapper .navigation a.projects_list_link').live('click', function(event){
  var url = $(this).attr('href');
  var list = $(this).closest('.members');
  var wrapper = $(this).closest('.members_wrapper');
  var indicator = wrapper.find('.big_indicator_projects');

  base_ajax_get(url, list, indicator, wrapper);
  
  event.preventDefault();
});

$('.dates_wrapper .navigation a.projects_list_link').live('click', function(event){
  var url = $(this).attr('href');
  var list = $(this).closest('.dates');
  var wrapper = $(this).closest('.dates_wrapper');
  var indicator = wrapper.find('.big_indicator_projects');

  base_ajax_get(url, list, indicator, wrapper);
  
  event.preventDefault();
});

// ========== GO BACK: MEMBERS ==========
$('.dates_wrapper .navigation a.members_list_link').live('click', function(event){
  var url = $(this).attr('href');
  var list = $(this).closest('.dates');
  var wrapper = $(this).closest('.dates_wrapper');
  var indicator = wrapper.find('.big_indicator_members');

  base_ajax_get(url, list, indicator, wrapper);
  
  event.preventDefault();
});