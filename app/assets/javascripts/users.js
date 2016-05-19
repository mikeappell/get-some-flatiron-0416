$(document).on('ready', function() {
  onOrgSelect()
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