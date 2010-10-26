class Byggeweb < Savon::Model
  client :byggeweb,
    :endpoint => "http://ws.byggeweb.dk/services/Controller",
    :namespace => "http://ws"

  attr_accessor :username, :password, :session_cookie, :project_id

  def log_in
    username && password ? authenticate : false
  end

  def projects
    authenticate or return []
    response = client(:byggeweb).get_projects!

    xml = XML::Parser.string(response.to_xml).parse
    xml.find('//multiRef').map do |project|
      [project.find('name').first.content, project.find('projectNumber').first.content]
    end
  end

  def root_folder
    authenticate or return
    response = client(:byggeweb).get_top_directory! do |soap|
      soap.body = { :_projectNumber => project_id }
    end

    xml = XML::Parser.string(response.to_xml).parse
    name = xml.find('//multiRef/title').first.content
    id = xml.find('//multiRef/id').first.content
    jsonize_folder name, id, true, folder(id)
  end

  def folder(folder_id)
    authenticate or return []
    response = client(:byggeweb).get_sub_directories! do |soap|
      soap.body = { :_projectNumber => project_id, :dirId => folder_id }
    end

    xml = XML::Parser.string(response.to_xml).parse
    xml.find('//multiRef').map do |folder|
      jsonize_folder folder.find('title').first.content, folder.find('id').first.content
    end
  end

  def files(folder_id)
    authenticate or return []
    response = client(:byggeweb).get_files_from_directory! do |soap|
      soap.body = { :_projectNumber => project_id, :dirId => folder_id, :_withAttachment => false }
    end

    xml = XML::Parser.string(response.to_xml).parse
    xml.find("//multiRef[substring(@xsi:type,4)=':FileVW']").map do |file|
      { :name => file.find('name').first.content, :id => file.find('id').first.content }
    end
  end

  private

  def authenticate
    if session_cookie.blank?
      Rails.logger.debug "[BYGGEWEB] Logging in with #{username}..."
      response = nil
      begin
        response = client(:byggeweb).authenticate! do |soap|
          soap.body = { :_userName => username, :_password => password }
        end
      rescue Savon::SOAPFault => e
        Rails.logger.error "[BYGGEWEB] Could not log in with #{username}: #{e.message}"
        return false
      end

      case response.http.code.to_i
      when 200
        self.session_cookie = response.http.header["set-cookie"]
      else
        Rails.logger.error "[BYGGEWEB] Could not log in with #{username} (http response code: #{response.http.code.to_i})"
        return false
      end
    end

    client(:byggeweb).request.headers["cookie"] = session_cookie
    return true
  end

  def jsonize_folder(name, id, open = false, children = [])
    {
      :data => {
        :title => name,
        :attr => { :class => 'tree-node' }
      },
      :attr => { :rel => id },
      :state => (open ? 'open' : 'closed'),
      :children => children
    }
  end
end
