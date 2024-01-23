$(document).ready(function(){
  $('#blindfoldtxt').hide();
  window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        $('#blindfold').show();
      } else if (event.data.action == 'close') {
        $('#blindfold').hide();
      }
      if (event.data.action == 'txtshow') {
        document.getElementById('blindfoldtxt').textContent = event.data.txt;
        $('#blindfoldtxt').show();
      } else if (event.data.action == 'txthide') {
        $('#blindfoldtxt').hide();
      }
  });
});
