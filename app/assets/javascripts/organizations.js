$(document).ready(function() {
  $.fn.bootstrapSwitch.defaults.onText = "Yes"
  $.fn.bootstrapSwitch.defaults.offText = "No"
  $.fn.bootstrapSwitch.defaults.size = 'small'
  $("#member").bootstrapSwitch()
  $("#member").on('switchChange.bootstrapSwitch', function() {
  })
})
