App.items = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    return $("div#item-list").append(this.renderItem(data));
  },
  renderItem: function(data) {
    var deleteButton = "<button name='button' type='submit' id='item-delete-" + data.id + " class='item-delete'>Delete</button>"
    $('#item-content-reset input#item-name').val('')
    $('#item-content-reset input#item-cost').val('')
    return "<li>" + data.name + " - $" + data.cost + " " + deleteButton + "</li>";
  }
});