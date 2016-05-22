$(document).ready(function() {
  toggle()
})



function toggle() {
  $.fn.bootstrapSwitch.defaults.onText = "Join"
  $.fn.bootstrapSwitch.defaults.offText = "Join"
  $.fn.bootstrapSwitch.defaults.size = 'small'
  $.fn.bootstrapSwitch.defaults.onColor= 'success'
  $(".member").bootstrapSwitch()
}


function switchToggle() {
  $(".member").on('switchChange.bootstrapSwitch', function() {
    
  })
}
