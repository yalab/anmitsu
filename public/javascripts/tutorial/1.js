$(function(){
  $("#preferences_link").qtip({
    content: t.first_step,
    style: 'red',
    show: { ready: true },
    position: {
      corner: {
         target: 'topMiddle',
         tooltip: 'bottomRight'
      }
   }
  });
});