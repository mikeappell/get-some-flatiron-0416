$(document).on('ready', function() {
  onOrgSelect()
  // onOrderCreate()
})

function onOrgSelect() {
  $('div#org-select').on('change', function(e) {
    var selected = $('select#user_organization_ids').val()
    var all_orders = $('.org-order')

    if (selected === "") {
      all_orders.show(500)
    } else {
      $(all_orders).each(function() {

        if ($(this).attr('organization-id') === selected){
          $(this).show(500)
        } else {
          $(this).hide(350)
        }
      })
    }
  })
}

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
