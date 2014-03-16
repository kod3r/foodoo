$(function(){
  // buddies select
  $('.selectpicker').selectpicker({
    size: 8,
    title: "Eating with...",
    selectedTextFormat: 'count>3',
    width: '300px'
  });
  $('.selectpicker').selectpicker('val', gon.buddies);
  $('.selectpicker').selectpicker('render');
  $('#search_button').click(function(){
    $('#results').hide();
    $('.bubblingG').show();
    var buddies = $('.selectpicker').val();
    $.ajax({
      url: '/searches/new',
      type: 'post',
      data: {buddies: buddies},
      dataType: 'json',
      success: function(data){
        console.log("success");
        window.location.reload();
      },
      error: function(a,b,c){
        console.log('error');
        window.location.reload();
      }
    });
  });
  // location select
  $('#address_selector').val(gon.locationId);
  $('#address_selector').change(function(){
    $('#results').hide();
    $('.bubblingG').show();
    var selected = $('#address_selector').val();
    if(selected == "new"){
      $('.bubblingG').hide();
      $('#address_form').fadeIn('slow');
    }else{
      $.ajax({
        url: "/address_input",
        type: "post",
        data: {location_id: selected},
        dataType: "json",
        success: function(data){
          window.location.reload();
          console.log("success");
        },
        error: function(jqXHR, textStatus, errorThrown){
          window.location.reload();
          console.log("fail");
          console.log(jqXHR);
          console.log(textStatus);
          console.log(errorThrown);
        }
      });
    }
  });
  // add location
  if(gon.noLocations) {$('#address-form').show()}
  $('#address_submit').click(function(){
    if($('#address_input').val() && $('#city_input').val() && $('#state_input').val()){
      $.ajax({
        url: "/users/address_input",
        type: "post",
        data: {address: $('#address_input').val(), city: $('#city_input').val(), state: $('#state_input').val()},
        //contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data){
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
  // hover styling
  $('.pick').mouseenter(function(){
    $(this).find('.name').addClass('orange');
  });
  $('.pick').mouseleave(function(){
    $(this).find('.name').removeClass('orange');
  });
  // tooltips
  $('#address_selector').tooltip({
    title: "where",
    placement: 'left',
    container: 'body'
  });
  $('#search_button').tooltip({
    title: "find the top 3 places for your group",
    placement: 'right',
    container: 'body'
  });
  $('.group_score').tooltip({
    title: "total score for the group, based on each person's individual preferences",
    placement: 'right',
    container: 'body'
  });
  $('.yelp_link').tooltip({
    title: "click to visit yelp page",
    placement: 'top',
    container: 'body'
  });
  $('.go_btn').tooltip({
    title: "get directions using google maps",
    placement: 'right',
    container: 'body'
  });
  $('.reservations').tooltip({
    title: "get reservations using opentable",
    placement: 'right',
    container: 'body'
  });
});
