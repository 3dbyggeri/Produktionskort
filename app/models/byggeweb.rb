class Byggeweb
  include Savon::Model

  endpoint 'http://ws.byggeweb.dk/services/Controller'
  namespace 'http://ws'

  actions :authenticate,            # log in
          :get_projects,            # get list of projects available to the logged in user
          :get_top_directory,       # get top directory in the selected project
          :get_sub_directories,     # get list of sub-directories in specified directory
          :get_files_from_directory # get list of files in specified directory

  class << self
    attr_accessor :project_id

    def log_in(username, password)
      logged_in? ? true : log_in!(username, password)
    end

    def log_in!(username, password)
      Rails.logger.debug "[BYGGEWEB] Logging in with #{username}..."
      response = nil
      begin
        response = authenticate :_userName => username, :_password => password
      rescue Savon::SOAP::Fault => e
        Rails.logger.error "[BYGGEWEB] Could not log in with #{username}: #{e.message}"
        return false
      end

      case response.http.code.to_i
      when 200
        client.http.headers["cookie"] = response.http.headers["Set-Cookie"]
      else
        Rails.logger.error "[BYGGEWEB] Could not log in with #{username} (http response code: #{response.http.code.to_i})"
        return false
      end

      return true
    end

    def logged_in?
      !client.http.headers["cookie"].blank?
    end

    def projects
      logged_in? or return []
      response = get_projects

      xml = XML::Parser.string(response.to_xml).parse
      xml.find('//multiRef').map do |project|
        [project.find('name').first.content, project.find('projectNumber').first.content]
      end
    end

    def root_folder
      logged_in? or return
      response = get_top_directory(:_projectNumber => project_id)

      xml = XML::Parser.string(response.to_xml).parse
      name = xml.find('//multiRef/title').first.content
      id = xml.find('//multiRef/id').first.content
      jsonize_folder name, id, true, folder(id)
    end

    def folder(folder_id)
      logged_in? or return []
      response = get_sub_directories :_projectNumber => project_id, :dirId => folder_id

      xml = XML::Parser.string(response.to_xml).parse
      xml.find('//multiRef').map do |folder|
        jsonize_folder folder.find('title').first.content, folder.find('id').first.content
      end
    end

    def files(folder_id)
      logged_in? or return []
      response = get_files_from_directory :_projectNumber => project_id, :dirId => folder_id, :_withAttachment => false

      xml = XML::Parser.string(response.to_xml).parse
      xml.find("//multiRef[substring(@xsi:type,4)=':FileVW']").map do |file|
        { :name => file.find('name').first.content, :id => file.find('id').first.content }
      end
    end

    private

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
end
