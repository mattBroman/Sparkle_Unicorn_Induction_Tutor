// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= requrie jquery_ujs
//= require turbolinks
//= require_tree .


var data = 'default';

window.onkeyup = function parse() {
  let text = document.getElementById('plain_text').value;
  try {
    let result = JSON.stringify(PARSER.parse(text));
    document.getElementById('pretty_page').value = result;
    document.getElementById('hidden').value = result;
    console.log('here')
  }
  catch(error) {
    console.log(error)
    document.getElementById('pretty_page').value = 'Bad'
    document.getElementById('hidden').value = '{\"parse\":\"Bad!\"}';
  }
}
/*
$('submit').on(onclick, function() {
  let test = 'working?'
  $.ajax( {
    url : 'induction_index_path',
    method : 'POST',
    data : {working : test},
    datatype : "json",
    success : function(data) {
      alert('good');
    }
  });
});
*/

window.onkeydown = function(event) {
  if (event.keyCode === 9) { //user entered a tab
    event.preventDefault();
    
    let text_area = document.getElementById('plain_text');
    let cursor_pos_begin = text_area.selectionStart;
    let cursor_pos_end = text_area.selectionEnd;
    text_area.value = text_area.value.substr(0, cursor_pos_begin) + '  ' + text_area.value.substr(cursor_pos_begin);
    text_area.selectionEnd = cursor_pos_end + 2;
  }
}