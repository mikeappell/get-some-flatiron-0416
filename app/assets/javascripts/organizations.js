$(document).ready(function() {
  $.fn.bootstrapSwitch.defaults.onText = "Join"
  $.fn.bootstrapSwitch.defaults.offText = "Join"
  $.fn.bootstrapSwitch.defaults.size = 'small'
  $.fn.bootstrapSwitch.defaults.onColor= 'success'
  $("#member").bootstrapSwitch()
  $("#member").on('switchChange.bootstrapSwitch', function() {
  })
})
