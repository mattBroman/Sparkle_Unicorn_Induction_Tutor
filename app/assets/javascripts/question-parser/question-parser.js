var data = 'default';

document.onkeyup = function parse() {
  let text = document.getElementById('plain_text').value;
  try {
    let result = JSON.stringify(PARSER.parse(text));
    console.log(result);
    document.getElementById('pretty_page').value = jsontolatex(JSON.parse(result));
    document.getElementById('hidden').value = result;
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