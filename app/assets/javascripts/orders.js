$(document).ready(function(){
  onExpirationTimeChanged();

  if ($('#order-expiration').length) {
    createOrderTimer();
    deleteItemListener();
  }
  if ($('button#order-create-btn').length) {
    placeOrderListener();
  }
  if ($('button#alert-users-btn').length) {
    alertUsersListener();
  }

});


function onExpirationTimeChanged() {
  $('input#expiration-time').focusout(function() {
    $('div#time-until-expire').html(formatTimeStringForOrderPlacing());
  });
}

function formatTimeStringForOrderPlacing(){
  var currentTime = new Date()
  var minutes = currentTime.getMinutes()
  var hours = currentTime.getHours()
  var usersTimeInput = parseInt($('input#expiration-time').val())
  var newMinutes = usersTimeInput + minutes
  var amPM
  var timeString

  if (isNaN(usersTimeInput)) {
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

  timeString = hours + ':' + newMinutes + ' ' + amPM
  return timeString
}


function createOrderTimer() {
  var expires = $('#order-expiration').val();
  var myInterval = setInterval(myTimer, 1000);
  displayTimeLeftInOrder(expires)

  function myTimer() {
    displayTimeLeftInOrder(expires)
    expires--
    if (expires < 0) window.clearInterval(myInterval);
  };
}

function displayTimeLeftInOrder(expires) {
  if (expires > 5*60) {
    $('h3#time-remaining-timer').html(renderOrderTimerHtml('success', secondsToTimeStringForOrderTimer(expires)));
  } else if (expires >= 60) {
    $('h3#time-remaining-timer').html(renderOrderTimerHtml('warning', secondsToTimeStringForOrderTimer(expires)));
  } else if (expires > 0) {
    $('h3#time-remaining-timer').html(renderOrderTimerHtml('danger', secondsToTimeStringForOrderTimer(expires)));
  } else {
    $('h3#time-remaining-timer').html(renderOrderTimerHtml('closed', null))
    disableItemElements();
  }
}

function renderOrderTimerHtml(alertType, timeString) {
  if (alertType === 'closed') {
    return "<div class='list-group-item list-group-item-danger'>This order has expired.</div>";
  } else {
    return `<div class='list-group-item list-group-item-${alertType}'>Time until ordered: ${timeString}</div>`
  }
}

function secondsToTimeStringForOrderTimer(seconds) {
  var hours = Math.floor(seconds / (60*60));
  var minutes = Math.floor(seconds / 60) % 60;
  seconds %= 60;
  if (seconds < 10) seconds = "0" + seconds;
  if (hours > 0) {
    return hours + " hours, " + minutes + " minutes";
  } else if (minutes >= 5) {
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
        $('p#item-' + response.id).remove();
      }
    });
  });
}

function placeOrderListener() {
  $('button#order-create-btn').on('click', function() {
    var orderId = $('#order-id').val();
    disableItemElements();
    $.ajax({
      method: "post",
      url: '/orders/' + orderId + '/place_order',
      success: function(response) {
        if (response.success) {

          // second ajax call to send email #1
          $.ajax({
            method: "post",
            url: "/email/" + orderId + "/placed"
          });

          var button = $('button#order-create-btn');
          button.animate({opacity:'0'},"slow");
          button.queue(function() {
            button.html('<strong>Alert Users to Delivery?</strong>');
            button.dequeue();
          });
          button.animate({opacity:'1'},"slow");
          button.animate({left:'0px'},"slow");
          button.attr("id", "alert-users-btn")
          button.off();
          alertUsersListener();
        } else {
        }
      }
    })
  })
}

function alertUsersListener() {
  $('button#alert-users-btn').on('click', function() {
    var orderId = $('#order-id').val();
    var choice = confirm("Send email to all users?");
    if (choice) {
      $.ajax({
        method: "post",
        url: '/orders/' + orderId + '/alert_users',
        success: function(response) {
          if (response.success) {
          // second ajax call to send email #2
          $.ajax({
            method: "post",
            url: "/email/" + orderId + "/arrived",
            success: (function(response) {
              console.log("User alerts sent successfully");
            })
          });
          var button = $('button#alert-users-btn');
          button.off();
          button.prop('disabled', true);
          button.attr("id", "users-alerted")
          button.animate({opacity:'0'},"slow");
          button.queue(function() {
            button.html('<strong>You got some ;)</strong>');
            button.removeClass();
            button.addClass('alert alert-success')
            button.dequeue();
          });
          button.animate({opacity:'1'},"slow");
          button.animate({left:'0px'},"slow");
        }
      }
    });
    }
  });
}

function disableItemElements() {
  $('input#item-name').prop('disabled', true);
  $('input#item-cost').prop('disabled', true);
  $('input#item-create-btn').prop('disabled', true);
  $("button.item-delete").remove();
}


// function itemAddedListener() {
//   $('#item-create-btn').on('click', function(event) {
//     event.preventDefault();
//     itemAdded(event);
//   });
// }

// function itemAdded(event) {
//
//   var itemName = $('#item-name').val();
//   var itemCost = $('#item-cost').val();
//   var orderId = $('#order-id').val();
//   $.ajax({
//     method: "post",
//     dataType: "json",
//     url: "/items",
//     data: {
//       name: itemName,
//       cost: itemCost,
//       order_id: orderId
//     },
//     success: function(response) {
//       debugger;
//       var deleteButton = "<button name='button' type='submit' id='item-delete-" + response.item_id + " class='item-delete' style='float: right; transform: translateY(-15%);'>Delete</button>"
//       $('div#item-list').append("<p>" + response.item_name + " - $" + response.item_cost + " " + deleteButton + "</p>")
//     },
//     error: function(response) {
//       $('div#item-errors').html(response.responseText).show()
//       $('div#item-errors').delay(5000).fadeOut('slow').html(response.responseText)
//     }
//   });
// }
