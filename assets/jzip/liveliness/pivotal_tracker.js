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
  
  show_date_interval(url, list, indicator, wrapper);

  event.preventDefault();
});

// // ========== DATES ==========
// $('.application.login .pivotal_tracker_wrapper .dates_wrapper .dates form').live('submit', function(event){
//   var form = $(this);
//   var url = form.attr('action');
//   var list = form.closest('.dates');
//   var indicator = form.closest('.dates_wrapper').find('.big_indicator');
//   var wrapper = form.closest('.pivotal_tracker_wrapper');  
//   
//   base_ajax_post(url, list, indicator, wrapper);
// 
//   event.preventDefault();
// });

// ========== GO BACK: PROJECTS ==========
function go_back_on_projects(elt, prefix) {
  var url = elt.attr('href');
  var list = elt.closest('.' + prefix);
  var wrapper = elt.closest('.'+prefix+'_wrapper');
  var indicator = wrapper.find('.big_indicator_projects');

  base_ajax_get(url, list, indicator, wrapper);
}

$('.members_wrapper .navigation a.projects_list_link').live('click', function(event){
  go_back_on_projects($(this), 'members');
  event.preventDefault();
});

$('.dates_wrapper .navigation a.projects_list_link').live('click', function(event){
  go_back_on_projects($(this), 'dates');
  event.preventDefault();
});

$('.wait_for_wrapper .navigation a.projects_list_link').live('click', function(event){
  go_back_on_projects($(this), 'wait_for');
  event.preventDefault();
});

// ========== GO BACK: MEMBERS ==========
function go_back_on_members(elt, prefix) {
  var url = elt.attr('href');
  var list = elt.closest('.' + prefix);
  var wrapper = elt.closest('.'+prefix+'_wrapper');
  var indicator = wrapper.find('.big_indicator_members');

  base_ajax_get(url, list, indicator, wrapper);
}

$('.dates_wrapper .navigation a.members_list_link').live('click', function(event){
  go_back_on_members($(this), 'dates');
  event.preventDefault();
});

$('.wait_for_wrapper .navigation a.members_list_link').live('click', function(event){
  go_back_on_members($(this), 'wait_for');
  event.preventDefault();
});