
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-switch
// require jquery.session

// require_tree ./channels
// require jquery-1.11.3.min
//= require bootstrap.min
//= require rebound
//= require jquery.isotope.min
//= require_tree .

$(document).on('ready', function() {
  handleNavChange()
})

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
      $(this).parent().show(500)
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
