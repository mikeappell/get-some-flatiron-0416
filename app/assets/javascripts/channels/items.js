App.messages = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    // $("#messages").removeClass('hidden')
    return $("#item-list").append(this.renderItem(data));
  },
  renderItem: function(data) {
    $('span#message-content-reset input#message_content').val('');
    $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight")}, 1000);
    // debugger;
    return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }
});