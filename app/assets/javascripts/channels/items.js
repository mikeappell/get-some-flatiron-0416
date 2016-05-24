
App.items = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    return $(data.element).append(this.renderSwitch(data));
  },
  renderSwitch: function(data) {
    switch (data.action) {
     case "add-message":
       $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight")}, 1000);
       return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
       break;
     case "add-item":
       return "<li> " + data.name + " - " + "$" + data.cost + "</li>";
       break;
    }
   }
});

//  ------ below is the original code we had when we had two different channels ----
// App.items = App.cable.subscriptions.create('ItemsChannel', {
//   received: function(data) {
//     return $("div#item-list").append(this.renderItem(data));
//   },
//   renderItem: function(data) {
//     return "<li> " + data.name + " - " + "$" + data.cost + "</li>";
//   }
// });
