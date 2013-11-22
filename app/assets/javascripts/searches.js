$(function(){
  $('#group_search_btn').click(function(){
    var checked_people = [];
    console.log("clicked");
    $.each($('.cbox'), function(idx, element){
      console.log(element);
      if($(element).is(':checked')){
        console.log('ok');
        checked_people.push(element.value);
      } else {
        console.log('not checked');
      }
    });
    checked_params = checked_people.join(",");
    window.location = "/searches/new?ppl="+checked_params;
  });
});

