jQuery(function($){
  var MigemoQuery = {
    Cache: {},
    run: function(e){
      var name = this.value;
      if(name.length === 0){
        $("#client_name_list").html('');
        return;
      }
      if (e.which !== 8  &&
          e.which !== 32 &&
          !(65 <= e.which && e.which <= 65 + 25) &&
          !(97 <= e.which && e.which <= 97 + 25)) {
        return;
      }

      if(MigemoQuery.Cache[name]){
        $("#client_name_list").html('');
        $(MigemoQuery.Cache[name]).each(MigemoQuery.draw);
      }else{
        $.get(uri.root + 'clients.json', {item: {client_name: name}},
           function(json){
             MigemoQuery.Cache[name] = json;
             $("#client_name_list").html('');
             $(json).each(MigemoQuery.draw);
           });
      }
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
      setTimeout(function(){ $("#client_name_list").html(''); }, 150);
    },
    choice: function(){
      $("#item_client_name").val($(this).html());
      $("#client_name_list").html('');
    }
  };
  $("#item_client_name").keyup(MigemoQuery.run);
});
