$(document).ready(function() {
  toggle()
})



function toggle() {
  $.fn.bootstrapSwitch.defaults.onText = "Join"
  $.fn.bootstrapSwitch.defaults.offText = "Join"
  $.fn.bootstrapSwitch.defaults.size = 'small'
  $.fn.bootstrapSwitch.defaults.onColor= 'success'
  $(".member").bootstrapSwitch()
  $(".member").on('switchChange.bootstrapSwitch', function() {
    if ($(this).parent().parent().hasClass('bootstrap-switch-off')) {
        var member = false
      } else {
          var member = true
      }

    var groupId = $(this).val()

    $.ajax({
       url: '/groups/' + groupId,
       type: 'PATCH',
       data: {member: member}
    })
})}
