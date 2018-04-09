function parse2() {
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