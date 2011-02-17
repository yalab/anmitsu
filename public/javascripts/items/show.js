$(function(){
    $("#account_submit").click(function(){
      $(this).attr('disabled', 'disabled');
      $(".alert").html('');
      $("#ajax_loader").show();
      var form = $("#new_account");
      $.ajax({url: form.attr('action'),
              type: 'POST',
              data: form.serialize(),
              success: function(account){
                $(":text").val('');
                $("#ajax_loader").hide();
                $("#account_submit").attr('disabled', '');
                var tr = $(document.createElement('tr'));
                tr.attr('id', 'account_' + account._id);
                var price_fields = ['total', 'total_with_tax'];
                var n;
                for(n = 0; n< price_fields.length; n++){
                  var k = price_fields[n];
                  $("#" + k).html(account['item_' + k] + account['unit']);
                }
                
                var fields = ['content', 'price'];
                for(n = 0; n < fields.length; n++){
                  var td = $(document.createElement('td'));
                  var k = fields[n];
                  if(k == 'price'){
                    td.css('text-align', 'right');
                    account[k] = account[k] + account['unit'];
                  }
                  td.html(account[k]);
                  tr.append(td);
                }
                td = $(document.createElement('td'));
                var link = $(document.createElement('a'));
                var href = [location.pathname, "accounts", account._id].join('/');
                link.attr({'href'       : href,
                           'data-method': "delete",
                           'data-remote': "true",
                           'rel'        : "nofollow"});
                link.html("[削除]");
                link.bind('ajax:success', delete_success);
                td.append(link);
                tr.append(td);
                $("#total_row").before(tr);
                tr.hide();
                tr.fadeIn('slow');
              },
              error: function(res){
                var fields = {price: "価格", content: "内容"};
                var errors = $.parseJSON(res.responseText);
                for(k in errors){
                  $("#"+k+'_error').html(fields[k] + "を" + errors[k]);
                }
                $("#ajax_loader").hide();
                $("#account_submit").attr('disabled', '');
              }
             });
      return false;
    });
  var delete_success = function(data, response_body){
    var account;
    try{
      eval("account = " + response_body);
    } catch (x) {
      alert("Errror " + x);
      return;
    }
    var fields = ['total', 'total_with_tax'];
    for(var n=0; n < fields.length; n++){
      var k = fields[n];
      if(account){
        $("#" + k).html(account['item_' + k] + account['unit']);
      }
    }
    
    var id = this.href.split('/').pop();
    var node = $("#account_"+ id);
    node.fadeOut('slow', function(){ node.remove(); });
  };
  $("a[data-method=delete]").bind('ajax:success', delete_success);
});
