$(function(){
  $("#item_client_name").keyup(function(e){
    var name = this.value;
    if(!name || name.length < 2){
      return;
    }
    if (e.which != 32 &&
        e.which != 8  &&
        !(65 <= e.which && e.which <= 65 + 25) &&
        !(97 <= e.which && e.which <= 97 + 25)) {
      return;
    }
    $.get(uri.root + 'clients.json', {item: {client_name: name}},
         function(json){
           $("#client_name_list").html('');
           $(json).each(function(ix, name){
             var li = $(document.createElement('li'));
             li.html(name);
             li.mouseover(function(){
               $(this).css("background", "#D5E2FF");
             });
             li.mouseout(function(){
               $(this).css("background", "#FFFFFF");
             });
             li.click(function(){
               $("#item_client_name").val($(this).html());
               $("#client_name_list").html('');
             });
             $("#client_name_list").append(li);
           });
         });
  });
});