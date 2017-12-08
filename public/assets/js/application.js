var scheme = "ws://";
var uri = scheme + window.document.location.host + "/";
var ws = new WebSocket(uri);


// with an open websocket the browser recieves messages: a json response with two keys.
//the json data is then inserted into a the page
ws.onmessage = function(message) {
  var data = JSON.parse(message.data);
  $("#chat-text").append("div class='panel panel-default'><div class 'panel-heading'>" + data.handle + "</div><div class='panel-body'>" + data.text + "</div></div>");
  $("#chat-text").stop().animate({
    scrollTop: $('#chat-text')[0].scrollHeight
  }, 800);
};

// grabs the values from the form and sends them as a json message over to the websocket to the server
$("input-form").on("submit", function(event) {
  event.preventDefault();
  var handle = $("input-handle")[0].value;
  var text = $("#input-text")[0].value;
  ws.send(JSON.stringify({handle: handle, text: text}));
  $("#input-text")[0].value = "";
});
