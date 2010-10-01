module ByggewebHelper
  class Byggeweb
    class << self
      SOAP_ACTIONS = [:get_file, :get_hierarchy, :authenticate, :get_projects, :get_file_with_preview, :get_file_directory, :set_metadata, :get_metadata, :search_files, :search_dirs, :get_xrefs, :get_files_from_directory, :get_files_from_directory_with_preview, :set_directory, :save_files, :get_distribution_files, :get_distribution_file, :make_directory, :update_directory, :get_sub_directories, :get_top_directory, :get_directory, :get_user_language]
      SOAP_NAMESPACE = "http://ws"

      def authenticate(current_user)
        # unless session[:byggeweb_session]
          @client = Savon::Client.new "http://ws.byggeweb.dk/services/Controller"

          response = @client.authenticate! do |soap|
            soap.namespace = SOAP_NAMESPACE
            soap.body = { :_userName => current_user.byggeweb_username, :_password => current_user.byggeweb_password }
          end

          case response.http.code.to_i
          when 200 then
            # session[:byggeweb_session] = response.http.header["set-cookie"]
            @session_cookie = response.http.header["set-cookie"]
          else
            raise "Could not log in to Byggeweb - HTTP error code: #{response.http.code.to_i}"
          end
        # end

        # @client.request.headers["cookie"] = session[:byggeweb_session]
        @client.request.headers["cookie"] = @session_cookie
      end

      def method_missing(method, *args, &block)
        if SOAP_ACTIONS.include? method.to_sym
          raise "The current implementation of method_missing does not work when given a block - write a custom method instead (or find a way to make this work)" if block_given?
          authenticate
          response = @client.__send__("#{method}!", *args) { |soap| soap.namespace = SOAP_NAMESPACE }
          response.to_hash
        else
          super
        end
      end

      def get_projects(user)
        authenticate(user)
        response = @client.get_projects! { |soap| soap.namespace = SOAP_NAMESPACE }
        # we cant convert to a hash because the id tag we are looking for is overwritten by the id attribute on the parent tag (this must be a bug in savon) - there we just to a regex scan
        projects = response.to_xml.scan(/<id xsi:type="xsd:int">(\d+)<\/id>\s*<metadataTemplateID xsi:type="xsd:int">\d+<\/metadataTemplateID>\s*<name xsi:type="xsd:string">([^<]*)<\/name>/)
        projects.map &:reverse
      end

      def get_hierachy(project)
        authenticate(nil)
        response = @client.get_projects! do |soap|
          soap.namespace = SOAP_NAMESPACE
          soap.body = { :_projectNumber => project }
        end
        response
      end
    end
  end
end