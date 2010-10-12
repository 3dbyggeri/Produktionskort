class Byggeweb < Savon::Model
  client :byggeweb,
    :endpoint => "http://ws.byggeweb.dk/services/Controller",
    :namespace => "http://ws"

  attr_accessor :username, :password, :session_cookie

  def log_in
    username && password ? authenticate : false
  end

  def projects
    authenticate or return []
    response = client(:byggeweb).get_projects!
    # we cant convert to a hash because the id tag we are looking for is overwritten by the id attribute on the parent tag (this must be a bug in savon) - there we just to a regex scan
    projects = response.to_xml.scan(/<id xsi:type="xsd:int">(\d+)<\/id>\s*<metadataTemplateID xsi:type="xsd:int">\d+<\/metadataTemplateID>\s*<name xsi:type="xsd:string">([^<]*)<\/name>/)
    projects.map &:reverse
  end

  def root_folder
    jsonize_folder "Dummy rod folder", nil, true, folder(nil)
  end

  def folder(folder_id)
    folders = ["Lorem Ipsum", "Vigtig folder", "En underfolder", "Endnu en folder", "Dummy", "Test 123"]
    folders.map! { |name| jsonize_folder name }
    folders.reject! { rand(2) == 0 }
    folders.shuffle
  end

  def files(folder_id)
    files = ['Foobar.pdf', 'Projektoversigt.doc', 'Budget 2010.xls', 'Lorem Ipsum.doc', 'Plantegning.pdf', 'En eller anden fil.txt', 'Readme.doc']
    files.map! { |name| { :name => name, :id => rand(1024) } }
    files.reject! { rand(2) == 0 }
    files.shuffle
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

  # when generating dummy nodes, you can leave the ID blank to get a random ID
  def jsonize_folder(name, id = nil, open = false, children = [])
    {
      :data => {
        :title => name,
        :attr => { :class => 'tree-node' }
      },
      :attr => { :rel => id || rand(1024) },
      :state => (open ? 'open' : 'closed'),
      :children => children
    }
  end
end

class Array
  def shuffle
    sort_by { rand }
  end

  def shuffle!
    self.replace shuffle
  end
end
