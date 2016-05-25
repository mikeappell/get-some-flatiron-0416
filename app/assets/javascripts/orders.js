$(document).ready(function(){
  onExpirationTimeChanged()
  // itemAddedListener();

  if ($('#order-expiration').length) {
    createOrderTimer();
    deleteItemListener();
  }
});


function onExpirationTimeChanged() {
  $('input#expiration-time').focusout(function() {
    $('div#time-until-expire').html(formatTimeStr())
  })
}

function formatTimeStr(){
  var currentTime = new Date()
  var minutes = currentTime.getMinutes()
  var hours = currentTime.getHours()
  var userTime = parseInt($('input#expiration-time').val())
  var newMinutes = userTime + minutes
  var amPM
  var timeStr

  if (isNaN(userTime)) {
    return 'That is not a valid time'
  }

  if (newMinutes >= 60){
    hours += Math.floor(newMinutes / 60)
    newMinutes = newMinutes % 60
  }
  if (newMinutes < 10){
    newMinutes = '0' + newMinutes
  }
  if (hours > 11){
    amPM = 'PM'
    if (hours > 12) hours -= 12
  } else {
    amPM = 'AM'
  }
  if (hours < 10){
    hours = '0' + hours
  }

  // timeStr = 'Order will be placed at: ' + hours + ':' + newMinutes + ' ' + amPM
  timeStr = hours + ':' + newMinutes + ' ' + amPM
  return timeStr
}

// function itemAddedListener() {
//   $('#item-create-btn').on('click', function(event) {
//     event.preventDefault();
//     itemAdded(event);
//   });
// }

function itemAdded(event) {

  var itemName = $('#item-name').val();
  var itemCost = $('#item-cost').val();
  var orderId = $('#order-id').val();
  $.ajax({
    method: "post",
    dataType: "json",
    url: "/items",
    data: {
      name: itemName,
      cost: itemCost,
      order_id: orderId
    },
    success: function(response) {
      var deleteButton = "<button name='button' type='submit' id='item-delete-" + response.item_id + " class='item-delete'>Delete</button>"
      $('div#item-list').append("<li>" + response.item_name + " - $" + response.item_cost + " " + deleteButton + "</li>")
    },
    error: function(response) {
      $('div#item-errors').html(response.responseText).show()
      $('div#item-errors').delay(5000).fadeOut('slow').html(response.responseText)
    }
  });
}

function createOrderTimer() {
  var expires = $('#order-expiration').val();
  var myInterval = setInterval(myTimer, 1000);
  setItemTimeToOrder(expires)

  function myTimer() {
    setItemTimeToOrder(expires)
    expires--
    // console.log(expires)
    if (expires < 0) window.clearInterval(myInterval);
  };
}

function setItemTimeToOrder(expires) {
  if (expires > 5*60) {
    $('h3#time-remaining-timer').html("<div class='list-group-item list-group-item-success'>Time until ordered: " + secondsToTimeString(expires) + "</div>");
  } else if (expires >= 60) {
    $('h3#time-remaining-timer').html("<div class='list-group-item list-group-item-warning'>Time until ordered: " + secondsToTimeString(expires) + "</div>");
  } else if (expires > 0) {
    $('h3#time-remaining-timer').html("<div class='list-group-item list-group-item-danger'>Time until ordered: " + secondsToTimeString(expires) + "</div>");
  } else {
    $('h3#time-remaining-timer').html("<div class='list-group-item list-group-item-danger'>This order has expired.</div>")
    $('input#item-name').prop('disabled', true);
    $('input#item-cost').prop('disabled', true);
    $('input#item-create-btn').prop('disabled', true);
    $("button.item-delete").remove();
  }
}

function secondsToTimeString(seconds) {
  // var hours = Math.floor(seconds / (60*60));
  var minutes = Math.floor(seconds / 60) % 60;
  seconds %= 60;
  if (seconds < 10) seconds = "0" + seconds;
  if (minutes >= 5) {
    return minutes + " minutes";
  } else {
    return minutes + ":" + seconds;
  }
}

function deleteItemListener() {
  $("button.item-delete").on("click", function() {
    var id = this.id.match(/\d+/);
    $.ajax({
      context: this,
      method: "delete",
      url: "/items/" + id,
      success: function(response) {
        $('li#item-' + response.id).remove();
      }
    });
  });
}
