class ApplicationController < ActionController::Base
  # protect_from_forgery

  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic('Produktionskort') do |username, password|
      md5_of_username = Digest::MD5.hexdigest(username)
      md5_of_password = Digest::MD5.hexdigest(password)
      md5_of_username == '21232f297a57a5a743894a0e4a801fc3' && md5_of_password == '28b17a9a76659fae8b968a71510d001e'
    end
    warden.custom_failure! if performed?
  end

  def process_attachments(base_key, attachment_keys, current_project = nil)
    attachment_keys.each do |attachment_key|
      next unless params[base_key].has_key? attachment_key
      params[base_key][attachment_key].each_value do |object|
        object.delete :existing_attachment # input field only used client-side

        case object[:attachment_origin].to_i
        when 1
          # manual upload requested by user
          if !object.has_key?(:attachment)
            # no file selected
            object[:attachment_origin] = '0'
          end
        when 2
          # import from Byggeweb requested by user
          if object[:new_attachment_import] == '1'
            raise ArgumentError, "Unable to connect to Byggeweb unless current_project is given" if current_project.nil?
            object[:attachment] = current_project.byggeweb.file(object[:attachment_origin_id])
          end
        when 3
          if object[:new_attachment_import] == '1'
            object[:attachment] = Tempfile.new 'bips-beskrivelse.txt'
          end
        end

        # remove existing attachment if requested by user (only relevant when updating)
        if object[:remove_attachment] == '1' && !object.has_key?(:attachment)
          object[:attachment] = nil
        end
      end
    end
  end

  def fix_nested_attribute_structure(data = nil, model = nil)
    unless data
      # guess data based on current controller
      data = params[self.class.to_s.match(/^(.*)Controller$/)[1].singularize.underscore.to_sym]
    end
    unless model
      # guess model based on current controller
      model = eval(self.class.to_s.match(/^(.*)Controller$/)[1].singularize)
    end

    # iterate over the nested attribute keys for the given model
    model.nested_attributes_options.keys.each do |key|
      # skip if current data-set doesn't contain this key
      next unless data.has_key? key

      # When recieving the XML all nested attributes are "doubble-nested".
      # We need to remove this doubble-nesting and also ensure that the
      # content is wrapped inside an array (e.g. if the orignal XML only
      # contained a single sub-node, the XML->Hash conversion would not
      # have done this
      raise "More than one sub-key found inside a nested attribute key" if data[key].keys.size > 1
      sub_key = data[key].keys[0]
      data[key] = [ data[key].delete(sub_key) ].flatten

      # Recursively fix nested attributes
      fix_nested_attribute_structure data[key], eval(key.to_s.classify)

      # Renamed the nested attribute name by appending '_attributes' to
      # the key-name
      data["#{key.to_s}_attributes".to_sym] = data.delete(key)
    end
  end
end
