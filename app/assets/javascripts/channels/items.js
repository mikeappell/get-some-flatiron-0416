
// App.items = App.cable.subscriptions.create('ItemsChannel', {
//   received: function(data) {
//     switch (data.action) {
//       case "add-message":
//       $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight")}, 1000);
//       return $(data.element).append("<p> <b>" + data.user + ": </b>" + data.message + "</p>");
//       break;
//       case "add-item":
//       return this.renderItem(data);
//       break;
//     }
//   },
//   renderItem: function(data) {
//     $.ajax({
//       url: "/current_user_id",
//       method: "GET",
//       dataType: "json",
//       success: function(response) {
//         console.log("In success");
//         var deleteButton = "<button name='button' type='submit' id='item-delete-" + data.id + "' class='item-delete'>Delete</button>"
//         if (data.owner === response.id) {
//           $('#item-content-reset input#item-name').val('')
//           $('#item-content-reset input#item-cost').val('')
//           $("div#item-list").append("<li id='item-" + data.id + "''>" + data.name + " - $" + data.cost + " " + deleteButton + "</li>");
//           // This is being called from orders.js
//           deleteItemListener();
//         } else {
//           $("div#item-list").append("<li>" + data.name + " - $" + data.cost + "</li>");
//         }
//       }
//     });
//   }
// });
//  ------ below is the original code we had when we had two different channels ----
// App.items = App.cable.subscriptions.create('ItemsChannel', {
//   received: function(data) {
//     return $("div#item-list").append(this.renderItem(data));
//   },
//   renderItem: function(data) {
//     return "<li> " + data.name + " - " + "$" + data.cost + "</li>";
//   }
// });
