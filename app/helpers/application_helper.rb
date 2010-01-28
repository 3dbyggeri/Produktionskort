# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_delete) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def link_to_add_fetch_project_form(name)
    projects = Project.all
    
    # form_remote_for :project, :method => get, :url => projects_path, :html => { :id => 'project_form' } do |f|
    #   select('project', :id, ['Byggeweb', 'RamByg', 'Beskrivelsesmateriale', 'Visual Kalkulation', 'you name it'])
    #   f.submit "Hent stamdata"
    # end

#         <form action="/projects/1" id="project_form" method="post" onsubmit="jQuery.ajax({data:jQuery.param(jQuery(this).serializeArray()) + '&amp;authenticity_token=' + encodeURIComponent('RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM='), dataType:'script', type:'get', url:'/projects/' + jQuery('select#project_id option:selected').attr('value')}); return false;"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM=" /></div>

    options = []
    projects.each { |p| options << "<option value='#{p.id}'>#{p.name}</option>" }
    form = <<-EOV
    <form action="/projects/1" id="project_form" method="post" onsubmit="jQuery.ajax({data:jQuery.param(jQuery(this).serializeArray()) + '&amp;authenticity_token=' + encodeURIComponent('RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM='), dataType:'script', type:'get', url:'/projects/'+jQuery('select#project_id option:selected').attr('value')}); return false;"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM=" /></div>
      <label for="import">Vælg sag</label>
      <select id="project_id" name="project[id]">
      #{options.join('')}
      </select>
      <input id="project_submit" name="commit" type="submit" value="Hent stamdata" />
    </form>
    EOV

    link_to_function(name, h("add_fetch_form(this, \"#{escape_javascript(form)}\")"))
  end

  def link_to_add_import_project_form(name)
    # form = form_remote_for :project, :url => projects_path, :html => { :id => 'project_form' } do |f|
    #   label_tag :import, 'Import fra'
    #   select('import', :source, ['Byggeweb', 'RamByg', 'Beskrivelsesmateriale', 'Visual Kalkulation', 'you name it'])
    #   f.label 'bips_ID'
    #   f.text_field 'bips'
    #   f.label :adgangskode
    #   f.password_field :name, :size => 10
    #   f.hidden_field :name, :value => "Mit test projekt"
    #   f.hidden_field :address, :value => "Abildgårdsvej 31"
    #   f.hidden_field :postal_code, :value => "8210"
    #   f.hidden_field :title_number, :value => "1231"
    #   f.submit "Hent stamdata"
    # end
    
    form = <<-EOV
    <form action="/projects" id="project_form" method="post" onsubmit="jQuery.ajax({data:jQuery.param(jQuery(this).serializeArray()) + '&amp;authenticity_token=' + encodeURIComponent('RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM='), dataType:'script', type:'post', url:'/projects'}); return false;"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="RAQycjopc2Gigve7lC9ol29mS0tG8MaL+Pn1Bq0M2mM=" /></div>
      <label for="import">Import fra</label>
      <select id="import_source" name="import[source]"><option value="Byggeweb">Byggeweb</option>

    <option value="RamByg">RamByg</option>
    <option value="Beskrivelsesmateriale">Beskrivelsesmateriale</option>
    <option value="Visual Kalkulation">Visual Kalkulation</option>
    <option value="you name it">you name it</option></select>
      <label for="project_bips_ID">Bips id</label>
      <input id="project_bips" name="project[bips]" size="30" type="text" />
      <label for="project_adgangskode">Adgangskode</label>
      <input id="project_name" name="project[name]" size="10" type="password" />

      <input id="project_name" name="project[name]" type="hidden" value="Mit test projekt" />
      <input id="project_address" name="project[address]" type="hidden" value="Abildgårdsvej 31" />
      <input id="project_postal_code" name="project[postal_code]" type="hidden" value="8210" />
      <input id="project_title_number" name="project[title_number]" type="hidden" value="1231" />
      <input id="project_submit" name="commit" type="submit" value="Hent stamdata" />
    </form>
    EOV

    link_to_function(name, h("add_fetch_form(this, \"#{escape_javascript(form)}\")"))
  end
  
end
