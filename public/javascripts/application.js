function add_fetch_form(link, content) {
  $(link).parent().before(content);
  $('#fetch_project').hide()
  $('#import_project').hide()
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".inputs").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}