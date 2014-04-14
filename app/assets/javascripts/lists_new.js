$(function(){
  // error catcher for no user location
  if(gon.noLocations) {$('#address-form').show()}
  $('#address_submit').click(function(){
    if($('#address_input').val() && $('#city_input').val() && $('#state_input').val()){
      $.ajax({
        url: "/users/address_input",
        type: "post",
        data: {address: $('#address_input').val(), city: $('#city_input').val(), state: $('#state_input').val()},
        dataType: "json",
        success: function(data){
          gon.noLocations = false;
          window.location.assign('http://www.foodoo.io');
          console.log("success");
        },
        error: function(jqXHR, textStatus, errorThrown){
          console.log("fail");
          console.log(jqXHR);
          console.log(textStatus);
          console.log(errorThrown);
        }
      });
    }
  });
  // add restaurants from search results
  $('.add_button').click(function(){
    $(this).parent().fadeOut(200, function(){
      $(this).html("<p class='orange'>On your List</p>").fadeIn(1000);
    });
  });
  // add restaurants from curated lists
  $('.list-add').click(function(){
    $(this).closest('.curated-info').fadeOut(200, function(){
      if($(this).attr('id') == "zagat"){
        $(this).html("<p class='orange'>9/9 on your list</p><a class='btn btn-warning list-read' href='http://www.zagat.com/l/new-york-city/best-pizza-in-nyc' target='_blank'>Read</a>").fadeIn(1000);
      }else if($(this).attr('id') == "thrillist"){
        $(this).html("<p class='orange'>5/5 on your list</p><a class='btn btn-warning list-read' href='http://www.thrillist.com/eat/new-york/the-best-burgers-in-nyc' target='_blank'>Read</a>").fadeIn(1000);
      }else if($(this).attr('id') == "seriouseats"){
        $(this).html("<p class='orange'>10/10 on your list</p><a class='btn btn-warning list-read' href='http://newyork.seriouseats.com/2013/09/best-ramen-nyc-ippudo-hide-chan-yuji-yebisu-totto-chuko-bassanova.html' target='_blank'>Read</a>").fadeIn(1000);
      }
    });
  });
  // tooltips
  $('#location').tooltip({
    title: "make sure to include city and state",
    placement: 'right',
    container: 'body'
  });
  $('.add_button').tooltip({
    title: "add this restaurant to your list",
    placement: 'right',
    container: 'body'
  });
  $('.yelp_link').tooltip({
    title: "click to visit yelp page",
    placement: 'right',
    container: 'body'
  });
  $('.list-read').tooltip({
    title: "read the article",
    placement: 'left',
    container: 'body'
  });
  $('.list-add').tooltip({
    title: "add all the restaurants to your list",
    placement: 'right',
    container: 'body'
  });
});
