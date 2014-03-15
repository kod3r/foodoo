$(function(){
  $("#brand").click(function(){
    $('.settings').fadeToggle();
  });
  $('.pick_nav').tooltip({
    title: "top 3 recommendations",
    placement: 'bottom',
    container: 'body'
  });
  $('.list_nav').tooltip({
    title: "see your restaurants",
    placement: 'bottom',
    container: 'body'
  });
  $('.add_nav').tooltip({
    title: "add new places",
    placement: 'bottom',
    container: 'body'
  });
  $('.friend_nav').tooltip({
    title: "see what everyone else likes",
    placement: 'bottom',
    container: 'body'
  });
  $('.settings').hide();
});
