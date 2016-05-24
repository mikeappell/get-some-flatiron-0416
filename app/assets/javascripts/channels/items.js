App.items = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    return this.renderItem(data);
  },
  renderItem: function(data) {
    $.ajax({
      url: "/current_user_id",
      method: "GET",
      dataType: "json",
      success: function(response) {
        console.log("In success");
        var deleteButton = "<button name='button' type='submit' id='item-delete-" + data.id + " class='item-delete'>Delete</button>"
        $('#item-content-reset input#item-name').val('')
        $('#item-content-reset input#item-cost').val('')
        if (data.owner === response.id) {
          $("div#item-list").append("<li>" + data.name + " - $" + data.cost + " " + deleteButton + "</li>");
        } else {
          $("div#item-list").append("<li>" + data.name + " - $" + data.cost + "</li>");
        }
      }
    });

  //   var deleteButton = "<button name='button' type='submit' id='item-delete-" + data.id + " class='item-delete'>Delete</button>"
  //   $('#item-content-reset input#item-name').val('')
  //   $('#item-content-reset input#item-cost').val('')
  //   // debugger;
  //   if (data.owner === currentUser) {
  //     return "<li>" + data.name + " - $" + data.cost + " " + deleteButton + "</li>";
  //   } else {
  //     return "<li>" + data.name + " - $" + data.cost + "</li>";
  //   }
  }
});