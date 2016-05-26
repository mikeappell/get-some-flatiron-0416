$(document).on('ready', function() {
  handleNavChange()
  onGroupSelect()
})

function onGroupSelect() {
  $('div#group-select').on('change', function(e) {
    var selected = $('select#user_group_ids').val()
    var all_orders = $('.group-order')
    if (selected === "") {
      all_orders.show(500)
    } else {
      $(all_orders).each(function() {
        if ($(this).attr('group-id') === selected){
          $(this).show(500)
        } else {
          $(this).hide(350)
        }
      })
    }
  })
}

function handleNavChange() {
  $(".dropdown-menu.organizations").on("ajax:success",function(data, response, xhr){
    var pageUrl = document.URL
    var string = response.organization + '<span class="caret"></span>'
    $('#dropdownMenu1').html(string)

    if (pageUrl.match(/users\/\d+$/)) {
      userPageNav(response)
    } else if (pageUrl.match(/organizations$/)) {
      groupPageNav(response)
    }
  })
}

function groupPageNav(response) {
  var pageDomain = response.organization
  $('.domains').each(function(index) {
    var domainName = $($('.domains')[index]).html().split(" ")[0].slice(1)
    if (domainName === pageDomain) {
      $('.domain-group').hide()
      $(this).parent().show()
    }
  })
}

function userPageNav(response) {
    var htmlString = '<option value="">All Groups</option>'

    $.each(response.groups, function(index, group) {
      htmlString += '<option value="' + group.id + '">' + group.name + '</option>'
    })

    $('#user_group_ids').html(htmlString)
    location.reload()
}

// function onOrganizationSelect() {
//   var select = $('#user_organization_ids')
//   select.on('change', function() {
//     var organizationId = parseInt(select.val())
//     $.ajax({
// 	    url: "/groups/" + organizationId,
// 	    type: 'GET',
//       data: { current_org: organizationId },
// 	    success: function(response) {
//         var htmlString = '<option value="">All Groups</option>'
//
//         $.each(response.groups, function(index, group) {
//           htmlString += '<option value="' + group.id + '">' + group.name + '</option>'
//         })
//         $('#user_group_ids').html(htmlString)
//         location.reload()
//     	}
//     })
//   })
// }

// function setOrganizationToDefault() {
//   var orgId = $.session.get("current_org")
//   if (orgId) {
//     // var groupName =
//     // var option = "<option value='" + orgId + '">' + ernserprosacco.name + "</option>"
//     $("#user_organization_ids option[value='" + orgId + "']").attr('selected', true)
//   }
// }


// function emailOrganizations() {
//   var emailInput = $('#user_email_addresses_attributes_0_email_address')
//
//   emailInput.focusout(function() {
//     var email = $(this).val()
//     var domain = email.split('@')[1]
//
//     $.ajax({
//       url: '/find_org_names',
//       type: 'POST',
//       data: { domain: domain },
//       success: function(response) {
//
//         if (response.organizations !== false) {
//           var htmlString = `<select name="organization_id">`
//           var organizations = response.organizations
//           for (var id in organizations) {
//               htmlString += `<option value="${id}"> ${organizations[id]} </option>`
//           }
//           htmlString += `</select>`
//
//           $('#organization_select').append(htmlString)
//         }
//       }
//     })
//   })
// }
