$(document).ready(function(){
  onExpirationTimeChanged()
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
  if (hours > 11){
    amPM = 'PM'
    if (hours > 12) hours -= 12
  } else {
    amPM = 'AM'
  }
  if (newMinutes < 10){
    newMinutes = '0' + newMinutes
  }
  if (hours < 10){
    hours = '0' + hours
  }
  timeStr = 'Order will be placed at: ' + hours + ':' + newMinutes + ' ' + amPM
  return timeStr
}
