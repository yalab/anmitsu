jQuery(function($){
  var post_success = function(account){
    $(":text").val('');
    var tr = $(document.createElement('tr'));
    tr.attr('id', 'account_' + account._id);
    $("#tax").html(account['item_tax'] + account['unit']);
    $(".total_with_tax").html(account['item_total_with_tax'] + account['unit']);
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
    $("#tax_row").before(tr);
    tr.hide();
    tr.fadeIn('slow');
  };

  $("#account_submit").click(function(){
    var trigger = $(this);
    if(trigger.attr('disabled') == 'disabled'){
      return false;
    }
    trigger.attr('disabled', 'disabled');
    $(".alert").html('');
    $("#ajax_loader").show();
    var form = $("#new_account");
    $.ajax({url: form.attr('action'),
            type: 'POST',
            data: form.serialize(),
            success: post_success,
            error: function(res){
              var fields = {price: "価格", content: "内容"};
              var errors = $.parseJSON(res.responseText);
              for(k in errors){
                $("#"+k+'_error').html("" + errors[k]);
              }
            },
            complete: function(){
              $("#ajax_loader").hide();
              trigger.removeAttr('disabled');
            }
           });
    return false;
  });
  var delete_success = function(data, account){
        $("#tax").html(account['item_tax'] + account['unit']);
    $(".total_with_tax").html(account['item_total_with_tax'] + account['unit']);
    var id = this.href.split('/').pop();
    var node = $("#account_"+ id);
    node.fadeOut('slow', function(){ node.remove(); });
  };
  $("a[data-method=delete]").bind('ajax:success', delete_success);
  $("#item_state").change(function(){
    if(!confirm(t.confirm_state_change)){
      this.form.reset();
      return;
    }
    this.form.submit();
  });
});
