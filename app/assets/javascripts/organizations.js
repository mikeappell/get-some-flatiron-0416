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

  var memberCount = $(this).parent().parent().parent().find('.member_count')
  var count = parseInt(memberCount.html())

  if ($(this).parent().parent().hasClass('bootstrap-switch-off')) {
      var member = false
      memberCount.html(count -= 1)
  } else {
      var member = true
      memberCount.html(count += 1)
  }

    var groupId = $(this).val()

    $.ajax({
       url: '/groups/' + groupId + '/toggle',
       type: 'PATCH',
       data: {member: member}
    })
})}
