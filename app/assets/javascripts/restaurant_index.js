$(function(){
  // filter & sort button coloring
  $('.buttonry .btn-info').click(function(){
    if($(this).closest('div').attr('id') == 'sort-by'){
      $('#sort-by .btn-warning').removeClass('btn-warning').addClass('btn-info');
    }
    $(this).removeClass('btn-info').addClass('btn-warning');
    if($(this).html() == 'Reset'){
      $('#filters .btn-warning').removeClass('btn-warning').addClass('btn-info');
    }
  });
  // address selection
  if(gon.noLocations) {$('#address-form').show()}
  $('#address_selector').val(gon.locationId);
  $('#address_selector').change(function(){
    $('.buttonry, #restaurants, #address_selector').hide();
    $('.bubblingG').show();
    var selected = $('#address_selector').val();
    if(selected == "new"){
      $('#index').hide();
      $('#address-form').fadeIn('slow');
    }else{
      $.ajax({
        url: "/address_input",
        type: "post",
        data: {location_id: selected},
        dataType: "json",
        success: function(data){
          console.log("ajax success");
          window.location.reload();
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
  // address input
  $('#address_submit').click(function(){
    if($('#address_input').val() && $('#city_input').val() && $('#state_input').val()){
      $.ajax({
        url: "/users/address_input",
        type: "post",
        data: {address: $('#address_input').val(), city: $('#city_input').val(), state: $('#state_input').val()},
        dataType: "json",
        success: function(data){
          console.log("ajax success");
        },
        error: function(jqXHR, textStatus, errorThrown){
          console.log("ajax fail");
          console.log(jqXHR);
          console.log(textStatus);
          console.log(errorThrown);
        }
      });
    }
  });

  // tooltips
  $('#address_selector').tooltip({
    title: "set your location",
    placement: 'right',
    container: 'body'
  });
  $('#score_button').tooltip({
    title: "based on distance, rating, and hitlist",
    placement: 'right',
    container: 'body'
  });
  $('.reset').tooltip({
    title: "clear the filter",
    placement: 'right',
    container: 'body'
  });
  $('.last_visit').tooltip({
    title: "last visit",
    placement: 'right',
    container: 'body'
  });
  $('.yelp_link').tooltip({
    title: "click to visit yelp page",
    placement: 'left',
    container: 'body'
  });
  $('.fav-button').tooltip({
    title: "click to add or remove from your hit list of restaurants you want to try",
    placement: 'bottom',
    container: 'body'
  });
  $('.del-button').tooltip({
    title: "click to remove this place from your list",
    placement: 'bottom',
    container: 'body'
  });
  $('.go-button').tooltip({
    title: "get directions using google maps",
    placement: 'bottom',
    container: 'body'
  });
  $('.reservations').tooltip({
    title: "get reservations using opentable",
    placement: 'bottom',
    container: 'body'
  });
  $('.dial').tooltip({
    title: "rate this restaurant",
    placement: 'right',
    container: 'body'
  });
});
