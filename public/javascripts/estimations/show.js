$(function(){
    $("#account_submit").click(function(){
                                 var form = $("#new_account");
                                 $.ajax({url: form.attr('action'),
                                         type: 'POST',
                                         data: form.serialize(),
                                         success: function(account){
                                           var tr = $(document.createElement('tr'));
                                           var fields = ['content', 'price'];
                                           for(var n = 0; n < fields.length; n++){
                                             var td = $(document.createElement('td'));
                                             td.html(account[fields[n]]);
                                             tr.append(td);
                                           }

                                           td = $(document.createElement('td'));
                                           td.html("&nbsp;");
                                           tr.append(td);
                                           $("#estimates_table").append(tr);
                                           tr.hide();
                                           tr.fadeIn('slow');
                                         },
                                         error: function(res){
                                           var error = $.parseJSON(res.responseText);
                                         }

                                        });
                                 return false;
                               });
    $("a[data-method=delete]").bind('ajax:success', function(){
                                      var id = this.href.split('/').pop();
                                      var node = $("#account_"+ id);
                                      node.fadeOut('slow', function(){ node.remove(); });
                                    });
});
