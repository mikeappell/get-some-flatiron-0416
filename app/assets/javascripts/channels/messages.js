App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    return $('#messages').append(this.renderMessage(data));
  },
  renderMessage: function(data) {
    $('span#message-content-reset input#message_content').val('');
    $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight")}, 1000);
    return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }
});
