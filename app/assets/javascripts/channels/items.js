App.items = App.cable.subscriptions.create('ItemsChannel', {
  received: function(data) {
    switch (data.action) {
      // data already being sent here multiple times
      case "add-message":
      $("#messages").animate({ scrollTop: $('#messages').prop("scrollHeight")}, 1000);
      return $(data.element).append("<p> <b>" + data.user + ": </b>" + data.message + "</p>");
      break;
      case "add-item":
      setNewAmounts(data);
      checkOrderMinimum(data);
      return this.renderItem(data);
      break;
      case "delete-item":
      setNewAmounts(data);
      checkOrderMinimum(data);
      return $('p#item-' + data.id).remove();
      break;
    }
  },
  renderItem: function(data) {
    $.ajax({
      url: "/current_user_id",
      method: "GET",
      dataType: "json",
      success: function(response) {
        var deleteButton = "<button name='button' type='submit' id='item-delete-" + data.id + "' class='item-delete btn btn-default' style='float: right; transform: translateY(-15%);'>Delete</button>"
        if (data.owner === response.id) {
          $('#item-content-reset input#item-name').val('')
          $('#item-content-reset input#item-cost').val('')
          $("div#item-list").append("<p class='list-group-item list-group-item-success' id='item-" + data.id + "''>" + data.name + " - $" + data.cost + " " + deleteButton + "</p>");
          // This is being called from orders.js
          deleteItemListener();
        } else {
          $("div#item-list").append("<p class='list-group-item list-group-item-info' id='item-" + data.id + "''>" + data.name + " - $" + data.cost + " (" + data.username + ")</p>");
        }
      }
    });
  }
});


function setNewAmounts(data) {

  var currentAmount = Math.round(Number($("#current-order-amount").text().split("$")[1]) *Math.pow(10,2))/Math.pow(10,2).toFixed(2)
  var newAmount = (data.action === "add-item" ? currentAmount + Number(data.cost) : currentAmount - Number(data.cost));
  $("#current-order-amount").text("Current order size: $" + newAmount)

  var minimumNeeded = Math.round(Number($("#minimum-amount-needed").text().split("$")[1]) *Math.pow(10,2))/Math.pow(10,2).toFixed(2)
  var newMinimumNeeded = minimumNeeded - Number(data.cost)
  $("#minimum-amount-needed").text("Minimum Amount Needed: $" + newMinimumNeeded)
}

function checkOrderMinimum(data) {
  var currentAmount = $('#current-order-amount');
  currentAmount.removeClass();
  currentAmount.addClass('list-group-item')
  if (data.cost_remaining <= 0) {
    currentAmount.addClass('list-group-item-success');
    currentAmount.html('Current order size: ' + data.item_total);
  } else {
    currentAmount.addClass('list-group-item-warning');
    currentAmount.html('Current order size: ' + data.item_total);
  }
}

//  ------ below is the original code we had when we had two different channels ----
// App.items = App.cable.subscriptions.create('ItemsChannel', {
//   received: function(data) {
//     return $("div#item-list").append(this.renderItem(data));
//   },
//   renderItem: function(data) {
//     return "<li> " + data.name + " - " + "$" + data.cost + "</li>";
//   }
// });
