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
end
