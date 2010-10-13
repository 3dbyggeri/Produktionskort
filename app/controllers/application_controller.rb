class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def process_attachments(base_key, attachment_keys)
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
            object[:attachment] = File.new File.join(Rails.root.to_s, 'public/favicon.ico')
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
