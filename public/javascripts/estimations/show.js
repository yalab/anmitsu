$(function(){
    $("#account_submit").click(function(){
                                 $(this).hide();
                                 $("#ajax_loader").show();
                                 var form = $("#new_account");
                                 $.ajax({url: form.attr('action'),
                                         type: 'POST',
                                         data: form.serialize(),
                                         success: function(account){
                                           $(":text").val('');
                                           $(".alert").val('');
                                           $("#ajax_loader").hide();
                                           $("#account_submit").show();
                                           var tr = $(document.createElement('tr'));
                                           tr.attr('id', 'account_' + account._id);
                                           var fields = ['content', 'price'];
                                           for(var n = 0; n < fields.length; n++){
                                             var td = $(document.createElement('td'));
                                             td.html(account[fields[n]]);
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
                                           link.click(function(e){
                                                        $(this).callRemote();
                                                        e.preventDefault();
                                                      });
                                           td.append(link);
                                           tr.append(td);
                                           $("#estimates_table").append(tr);
                                           tr.hide();
                                           tr.fadeIn('slow');
                                         },
                                         error: function(res){
                                           var errors = $.parseJSON(res.responseText);
                                           for(k in errors){
                                             $("#"+k+'_error').html(errors[k].replace(/^./, ''));
                                           }
                                         }
                                        });
                                 return false;
                               });
    var delete_success = function(){
      var id = this.href.split('/').pop();
      var node = $("#account_"+ id);
      node.fadeOut('slow', function(){ node.remove(); });
    };
    $("a[data-method=delete]").bind('ajax:success', delete_success);
  });
