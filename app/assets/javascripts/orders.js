$(document).ready(function(){
  onExpirationTimeChanged()
  itemAddedListener();
})

function onExpirationTimeChanged() {
  $('input#expiration-time').focusout(function() {
    $('span#time-until-expire').html(formatTimeStr())
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

  if (isNaN(userTime)) return 'That is not a valid time'

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

  timeStr = 'Order will be placed at: ' + hours + ':' + newMinutes + ' ' + amPM
  return timeStr
}

function itemAddedListener() {
  $('#item-create-btn').on('click', function(event) {
    event.preventDefault();
    itemAdded(event);
  });
}

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
      $('div#item-list').append("<li>" + response.item_name + " - $" + response.item_cost + "</li>" )
    },
    error: function(response) {
      $('div#item-errors').html(response.responseText).show()
      $('div#item-errors').delay(5000).fadeOut('slow').html(response.responseText)
    }
  });
  // Stop submit from happening
  // Ajaxically check the controller, see if item is valid.
  // If valid, add the item to the html.
  // If invalid, show an error on the page instead.
  // Items need to be in their own div.
}
