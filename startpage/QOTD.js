function ajax_get(url, callback) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            console.log('responseText:' + xmlhttp.responseText);
            try {
                var data = JSON.parse(xmlhttp.responseText);
            } catch(err) {
                console.log(err.message + " in " + xmlhttp.responseText);
                return;
            }
            callback(data);
        }
    };
 
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

function getQOTD() {
  ajax_get('http://quotes.rest/qod.json', function(data) {
    let quoteBase = data["contents"]["quotes"][0];
    let quoteAuthor = quoteBase["author"];
    let quoteQuote = quoteBase["quote"];
    document.getElementById("qotd").innerHTML = quoteQuote + " - ";
    let createE = document.createElement("A");
    createE.setAttribute("class", "author");
    createE.setAttribute("href", "https://en.wikipedia.org/w/index.php?search=" + quoteAuthor);
    var createN = document.createTextNode(quoteAuthor);
    createE.appendChild(createN);
    document.getElementById('qotd').appendChild(createE);
  });
}
