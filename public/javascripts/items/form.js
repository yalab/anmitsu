$(function(){
  var MigemoQuery = {
    run: function(e){
      var name = this.value;
      var invoke_ready = 1;
      if(!name || name.length < invoke_ready){
        return;
      }
      if (e.which != 32 &&
          e.which != 8  &&
          !(65 <= e.which && e.which <= 65 + 25) &&
          !(97 <= e.which && e.which <= 97 + 25)) {
        return;
      }
      $.get(uri.root + 'clients.json', {item: {client_name: name}},
           MigemoQuery.refresh);
    },
    refresh: function(json){
      $("#client_name_list").html('');
      $(json).each(MigemoQuery.draw);
    },
    draw: function(ix, name){
      var li = $(document.createElement('li'));
      li.html(name);
      li.mouseover(MigemoQuery.mouseover);
      li.mouseout(MigemoQuery.mouseout);
      li.click(MigemoQuery.choice);
      $("#item_client_name").blur(MigemoQuery.blur);
      $("#client_name_list").append(li);
    },
    mouseover: function(){
      $(this).css("background", "#D5E2FF");
    },
    mouseout: function(){
      $(this).css("background", "#FFFFFF");
    },
    blur: function(){
      setTimeout(function(){ $("#client_name_list").html(''); }, 200);
    },
    choice: function(){
      $("#item_client_name").val($(this).html());
      $("#client_name_list").html('');
    }
  };
  $("#item_client_name").keyup(MigemoQuery.run);
});
