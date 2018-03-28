document.onkeyup = function parse() {
  let entry1 = document.getElementById('pk').value;
  let entry2 = document.getElementById('implies').value;
  try {
    let result = JSON.stringify(PARSER.parse(entry1));
    result = JSON.stringify(PARSER.parse(entry2));
    console.log('here')
  }
  catch(error) {
    console.log(error)
    document.getElementById('hidden').value = '{\"proof\":\"Bad!\"}';
  }
}