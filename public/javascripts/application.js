function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".inputs").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

var remove_attachment = function(obj) {
  $(obj).closest('li').next().find('input').val('1');
  $(obj).closest('p.inline-hints').remove();
}

var remove_existing_attachment = function(container) {
  if (container.find('.existing_attachment input').val() != '') {
    container.find('.remove_attachment input').val('1');
    container.find('.attachment_origin').next('p.inline-hints').remove();
    container.find('.existing_attachment input').val(''); // no need to do it more than once
  }
}

var undo_byggeweb_attachment = function(container) {
  if (container.find('.attachment_origin').val() == '2')
    container.find('.attachment_origin').val('0');
  container.find('.attachment_origin_id').val('');
  container.find('.attachment_origin_filename').remove();
}

var undo_file_upload = function(container) {
  var field = container.find('.attachment_upload');
  field.hide();
  field.html(field.html()); // clear selected file
}

$.jstree._themes = "/jstree_themes/"

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

  $('#project_form, #work_process_form').FormNavigate("Du har foretaget ændringer!\n\nEr du sikker på du vil fortsætte uden at gemme?");

  $('select.attachment_origin').live('change', function() {
    var container = $(this).closest('ol');
    remove_existing_attachment(container);
    switch(parseInt($(this).val())) {
      case 0:
        undo_file_upload(container);
        undo_byggeweb_attachment(container);
        break;
      case 1:
        undo_byggeweb_attachment(container);
        container.find('.attachment_upload').show();
        break;
      case 2:
        undo_file_upload(container);
        var id = container.find('.attachment_origin_id').attr('id');
        $.facebox('<div id="byggeweb_attachment" rel="' + id + '"><div id="byggeweb_folders"></div><div id="byggeweb_files"><div class="message">Ingen folder valgt</div></div><div class="clear"></div></div>');
        $(document).bind('close.facebox', function() { container.find('.attachment_origin').val('0') });
        $('#byggeweb_folders').jstree({
          json_data: {
            ajax: {
              url: function(n) {
                var path = 'byggeweb/folders' + (n == -1 ? '' : '/' + n.attr('rel')) + '.json';
                return window.location.pathname.replace('edit', path);
              }
            }
          },
          themes: {
            theme: 'apple',
            dots: true,
            icons: true
          },
          plugins: ['themes', 'json_data']
        });
        break;
    }
  });

  $('.tree-node').live('click', function(e) {
    e.preventDefault();
    var id = $(this).parent().attr('rel');
    var url = window.location.pathname.replace('edit', 'byggeweb/folders/' + id + '/files');
    $.getJSON(url, function(data) {
      var names = $.map(data, function(a) { return '<li><a href="#" rel="' + a.id + '">' + a.name + '</a></li>' });
      $('#byggeweb_files').html('<h3>Filer</h3><ul>' + names.join('') + '</ul>');
    });
  });

  $('#byggeweb_files a').live('click', function(e) {
    e.preventDefault();
    var id = $(this).attr('rel');
    var name = $(this).html();
    var attachment_origin_id = $('#' + $('#byggeweb_attachment').attr('rel'));
    var container = attachment_origin_id.closest('ol');
    attachment_origin_id.val(id);
    container.find('.attachment_origin').after('<p class="inline-hints attachment_origin_filename">' + name + '</p>');
    container.find('.new_attachment_import input').val('1');
    $(document).trigger('close.facebox');
    container.find('.attachment_origin').val('2'); // reset select box due to too agressive close.facebox hook
  });
});
