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
end