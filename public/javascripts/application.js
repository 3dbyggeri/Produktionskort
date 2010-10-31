function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".inputs").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function getCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
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

var undo_bips_attachment = function(container) {
  if (container.find('.attachment_origin').val() == '3')
    container.find('.attachment_origin').val('0');
  container.find('.attachment_origin_id').val('');
  container.find('.attachment_origin_section').remove();
}

var undo_fileshare_attachment = function(container) {
  if (container.find('.attachment_origin').val() == '4')
    container.find('.attachment_origin').val('0');
  container.find('.attachment_origin_id').val('');
  container.find('.attachment_origin_filename').remove();
}

var undo_file_upload = function(container) {
  var field = container.find('.attachment_upload');
  field.hide();
  field.html(field.html()); // clear selected file
}

var switch_attachment_type = function(type, container) {
  if (type != 1)
    undo_file_upload(container);
  if (type != 2)
    undo_byggeweb_attachment(container);
  if (type != 3)
    undo_bips_attachment(container);
  if (type != 4)
    undo_fileshare_attachment(container);
}

var projects_path = function() {
  var path = window.location.pathname.match('^/projects/[0-9]+')
  return path == null ? '/projects/' + getCookie('active_project') : path[0]
}

var fileshare_path = function(node) {
  var path = $(node).parents('li.jstree-last').map(function() { return $(this).children('a').text().trim(); }).get().reverse();
  return path.slice(1).join('/');
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
    var attachment_type = parseInt($(this).val());
    remove_existing_attachment(container);
    switch_attachment_type(attachment_type, container);
    switch(attachment_type) {
      case 1:
        container.find('.attachment_upload').show();
        break;
      case 2:
        var id = container.find('.attachment_origin_id').attr('id');
        $.facebox('<div id="byggeweb_attachment" rel="' + id + '"><div id="byggeweb_folders"></div><div id="byggeweb_files"><div class="message">Ingen folder valgt</div></div><div class="clear"></div></div>');
        $(document).bind('close.facebox', function() { container.find('.attachment_origin').val('0') }); // should we not unbind this later?
        $('#byggeweb_folders').jstree({
          json_data: {
            ajax: {
              url: function(n) {
                return projects_path() + '/byggeweb/folders' + (n == -1 ? '' : '/' + n.attr('rel'));
              },
              dataType: 'json'
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
      case 3:
        var id = container.find('.attachment_origin_id').attr('id');
        $.facebox('<div id="bips_attachment" rel="' + id + '"><div id="bips_sections"></div><div id="bips_content"><div class="message">Ingen sektion valgt</div></div><div class="clear"></div></div>');
        $(document).bind('close.facebox', function() { container.find('.attachment_origin').val('0') }); // should we not unbind this later?
        $('#bips_sections').jstree({
          json_data: {
            ajax: {
              url: function(n) {
                return projects_path() + '/bips/sections' + (n == -1 ? '' : '/' + n.attr('rel'));
              },
              dataType: 'json'
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
      case 4:
        var id = container.find('.attachment_origin_id').attr('id');
        $.facebox('<div id="fileshare_attachment" rel="' + id + '"><div id="fileshare_folders"></div><div id="fileshare_files"><div class="message">Ingen folder valgt</div></div><div class="clear"></div></div>');
        $(document).bind('close.facebox', function() { container.find('.attachment_origin').val('0') }); // should we not unbind this later?
        $('#fileshare_folders').jstree({
          json_data: {
            ajax: {
              url: projects_path() + '/fileshare/folders',
              dataType: 'json',
              data: function(n) {
                return n == -1 ? null : { path: fileshare_path($(n).find('a')) };
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

  $('#byggeweb_attachment .tree-node').live('click', function(e) {
    e.preventDefault();
    var id = $(this).parent().attr('rel');
    var url = projects_path() + '/byggeweb/folders/' + id + '/files';
    $.getJSON(url, function(data) {
      var names = $.map(data, function(a) { return '<li><a href="#" rel="' + a.id + '">' + a.name + '</a></li>' });
      $('#byggeweb_files').html('<h3>Filer</h3><ul>' + names.join('') + '</ul>');
    });
  });

  $('#bips_attachment .tree-node').live('click', function(e) {
    e.preventDefault();
    var id = $(this).parent().attr('rel');
    var url = projects_path() + '/bips/sections/' + id + '/content';
    $.getJSON(url, function(data) {
      $('#bips_content').html('<h3>' + data.headline + '</h3><p>' + data.body + '</p><p><input type="button" value="Benyt" rel="' + data.id + '" /></p>');
    });
  });

  $('#fileshare_attachment .tree-node').live('click', function(e) {
    e.preventDefault();
    var path = fileshare_path(this);
    var url = projects_path() + '/fileshare/files';
    $.getJSON(url, {path: path}, function(data) {
      if (path != '')
        path += '/';
      var names = $.map(data, function(a) { return '<li><a href="' + path + a.name + '">' + a.name + '</a></li>' });
      $('#fileshare_files').html('<h3>Filer</h3><ul>' + names.join('') + '</ul>');
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

  $('#bips_content input').live('click', function(e) {
    e.preventDefault();
    var id = $(this).attr('rel');
    var name = $(this).closest('div').find('h3').html();
    var attachment_origin_id = $('#' + $('#bips_attachment').attr('rel'));
    var container = attachment_origin_id.closest('ol');
    attachment_origin_id.val(id);
    container.find('.attachment_origin').after('<p class="inline-hints attachment_origin_section">' + name + '</p>');
    container.find('.new_attachment_import input').val('1');
    $(document).trigger('close.facebox');
    container.find('.attachment_origin').val('3'); // reset select box due to too agressive close.facebox hook
  });

  $('#fileshare_files a').live('click', function(e) {
    e.preventDefault();
    var id = $(this).attr('href');
    var name = $(this).html();
    var attachment_origin_id = $('#' + $('#fileshare_attachment').attr('rel'));
    var container = attachment_origin_id.closest('ol');
    attachment_origin_id.val(id);
    container.find('.attachment_origin').after('<p class="inline-hints attachment_origin_filename">' + name + '</p>');
    container.find('.new_attachment_import input').val('1');
    $(document).trigger('close.facebox');
    container.find('.attachment_origin').val('4'); // reset select box due to too agressive close.facebox hook
  });
});
