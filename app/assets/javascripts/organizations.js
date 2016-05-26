$(document).ready(function() {
  switchToggle()
  hideNShowOrg()
})


function switchToggle() {
  configureSwitch()
  handleToggling()
}

function configureSwitch() {
  $.fn.bootstrapSwitch.defaults.onText = "Join"
  $.fn.bootstrapSwitch.defaults.offText = "Join"
  $.fn.bootstrapSwitch.defaults.size = 'small'
  $.fn.bootstrapSwitch.defaults.onColor= 'success'
  $(".member").bootstrapSwitch()
}

function handleToggling() {
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

function hideNShowOrg() {
  $('.domain-group').hide()
  var pageDomain = $('input[type="hidden"]').attr("value")

  $('.domains').each(function(index) {
    var domainName = $($('.domains')[index]).html().split(" ")[0].slice(1)
    if (domainName === pageDomain) {
      $(this).parent().show()
    }
  })
}



function hideNShowOnSwitch() {
  var select = $('#user_organization_ids')
  select.on('change', function() {
    var organizationId = parseInt(select.val())

    $.ajax({
	    url: "/groups/" + organizationId,
	    type: 'GET',
      data: { current_org: organizationId },
	    success: function(response) {
        var pageDomain = response.organization
        $('.domains').each(function(index) {
          var domainName = $($('.domains')[index]).html().split(" ")[0].slice(1)
          if (domainName === pageDomain) {
            $('.domain-group').hide()
            $(this).parent().show(500)
          }
        })
      }
    })
  })

}
