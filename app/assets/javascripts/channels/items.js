App.items = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    return $("div#item-list").append(this.renderItem(data));
  },
  renderItem: function(data) {
    return "<li> " + data.name + " - " + "$" + data.cost + "</li>";
  }
});