class Byggeweb
  attr_accessor :project_id

  def initialize(user, password, project_id = nil)
    Rails.logger.debug "[BYGGEWEB] Using project ID #{project_id}..."
    self.project_id = project_id

    Rails.logger.debug "[BYGGEWEB] Logging in with #{user}..."
    response = nil
    begin
      @client = Savon::Client.new do
        wsdl.endpoint = 'http://ws.byggeweb.dk/services/Controller'
        wsdl.namespace = 'http://ws'
      end
      response = @client.request :authenticate do
        soap.body = { :_userName => user, :_password => password }
      end
    rescue Savon::SOAP::Fault => e
      Rails.logger.error "[BYGGEWEB] Could not log in with #{user}: #{e.message}"
    end

    case response.http.code.to_i
    when 200
      @client.http.headers["cookie"] = response.http.headers["Set-Cookie"]
    else
      Rails.logger.error "[BYGGEWEB] Could not log in with #{user} (http response code: #{response.http.code.to_i})"
    end
  end

  def logged_in?
    !@client.http.headers["cookie"].blank?
  end

  def projects
    logged_in? or return []
    response = @client.request :get_projects

    xml = XML::Parser.string(response.to_xml).parse
    xml.find('//multiRef').map do |project|
      [project.find('name').first.content, project.find('projectNumber').first.content]
    end
  end

  def root_folder
    logged_in? or return
    response = @client.request :get_top_directory do
      soap.body = { :_projectNumber => project_id }
    end

    xml = XML::Parser.string(response.to_xml).parse
    name = xml.find('//multiRef/title').first.content
    id = xml.find('//multiRef/id').first.content
    jsonize_folder name, id, true, folder(id)
  end

  def folder(folder_id)
    logged_in? or return []
    response = @client.request :get_sub_directories do
      soap.body = { :_projectNumber => project_id, :dirId => folder_id }
    end

    xml = XML::Parser.string(response.to_xml).parse
    xml.find('//multiRef').map do |folder|
      jsonize_folder folder.find('title').first.content, folder.find('id').first.content
    end
  end

  def files(folder_id)
    logged_in? or return []
    response = @client.request :get_files_from_directory do
      soap.body = { :_projectNumber => project_id, :_dirId => folder_id, :_withAttachment => false }
    end

    xml = XML::Parser.string(response.to_xml).parse
    xml.find("//multiRef[substring(@xsi:type,4)=':FileVW']").map do |file|
      { :name => file.find('name').first.content, :id => file.find('id').first.content }
    end
  end

  def file(file_id)
    logged_in? or return []
    response = @client.request :get_file do
      soap.body = { :_projectNumber => project_id, :_fileId => file_id, :_withAttachment => true }
    end

    raise "No attachment found!" if response.http.attachments.empty?

    xml = XML::Parser.string(response.to_xml).parse
    file = xml.find("//multiRef[substring(@xsi:type,4)=':FileVW']").first
    id = file.find('id').first.content
    filename = file.find('name').first.content

    Rails.logger.debug "[BYGGEWEB] Importing attachment #{filename} with id #{id} from project #{project_id}"
    attachment = response.http.attachments.select{ |a| a.id == id }.first.data
    attachment.instance_eval <<-RUBY
      def original_filename
        '#{filename}'
      end
    RUBY
    return attachment
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
