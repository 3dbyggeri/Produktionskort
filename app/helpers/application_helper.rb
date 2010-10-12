module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"
  end

  def group_referrals(ref_arr)
    result = {}
    ref_arr.each do |r|
      index = r.kind.downcase.to_sym
      result[index] ||= []
      result[index] << r
    end
    result
  end

  def attachment_fiels(f)
    existing = !f.object.attachment_file_name.blank?
    s = "".html_safe

    s += f.input :attachment_origin,
                 :collection => ATTACHMENT_ORIGINS,
                 :as => :select,
                 :include_blank => false,
                 :hint => existing ? link_to(f.object.attachment_file_name, f.object.attachment.url) : nil,
                 :input_html => { :class => 'attachment_origin' }
    s += f.input :attachment,
                 :as => :file,
                 :label => '&nbsp;',
                 :wrapper_html => {
                   :style => f.object.attachment_origin == 1 ? nil : 'display:none',
                   :class => 'attachment_upload'
                 }
    s += f.input :attachment_origin_id, :as => :hidden, :input_html => { :class => 'attachment_origin_id' }
    s += f.input :existing_attachment, :as => :hidden, :value => existing ? 1 : 0, :wrapper_html => { :class => 'existing_attachment' }
    s += f.input :new_attachment_import, :as => :hidden, :value => 0, :wrapper_html => { :class => 'new_attachment_import' }
    s += f.input :remove_attachment, :as => :hidden, :value => 0, :wrapper_html => { :class => 'remove_attachment' }
  end
end
