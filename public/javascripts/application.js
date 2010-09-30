function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".inputs").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

var remove_referral = function(obj) {
  $(obj).parents('li').next().find('input').val('1');
  $(obj).parents('p.inline-hints').remove();
}

$(document).ready(function() {
  $('#switch_project').change(function() {
    if ($(this).val() != '')
      $(this).parents('form:first').submit();
  });

  $('.tab').click(function(e) {
    e.preventDefault();
    $('.tab').removeClass('active');
    $(this).addClass('active');
    var pane = $(this).attr('rel');
    $('.pane').hide();
    $('#' + pane).show();
  });

  $('#form_submitter').click(function() {
    var form = $(this).attr('rel');
    $('#' + form).submit();
  });
});