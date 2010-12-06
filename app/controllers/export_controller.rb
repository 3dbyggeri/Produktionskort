class ExportController < ApplicationController
  def new
    @work_process = WorkProcess.find(params[:work_process_id])
  end

  def create
    @work_process = WorkProcess.find(params[:work_process_id])
    table_of_content = params[:pdf][:table_of_content].split(/\n|\r\n/).map(&:strip).reject(&:blank?)

    produktionskort = WorkProcessReport.new(@work_process, table_of_content).render

    file = Tempfile.new "produktionskort.zip"
    Zip::ZipOutputStream.open(file.path) do |zip|
      # The ZIP file format is not Unicode aware. Filenames are just 8-bit strings
      # internally, with (afaik) no defined charset, or Unicode encoding.
      #
      # That means that the writer and reader of the file have to agree on a mutually
      # comprehensible format.
      #
      # TODO: Could we have issues with chars not compatible with ISO-8859-1 ?
      filename = "#{@work_process.component_type.blank? ? 'Produktionskort' : @work_process.component_type}.pdf"
      zip.put_next_entry "produktionskort/#{filename}".force_encoding('ISO-8859-1')
      zip.print produktionskort
      zip.put_next_entry 'produktionskort/Se produktionskort online.url'.force_encoding('ISO-8859-1')
      zip.print "[InternetShortcut]\nURL=#{work_process_url(@work_process)}\n"
      params[:attachments].try(:each) do |klass, urls|
        urls.each do |url|
          url, filename = process_url(url)
          zip.put_next_entry "produktionskort/bilag/#{klass.constantize.human_name}/#{filename}".force_encoding('ISO-8859-1')
          zip.print open(url) {|f| f.read }
        end
      end
    end
    file.close

    # For some reason send_file sends an empty file on Heroku - hence the hack below
    # send_file file.path, :type => 'application/zip',
    #                      :disposition => 'attachment',
    #                      :filename => 'produktionskort.zip'
    File.open(file.path, 'r') do |f|
      send_data f.read, :type => 'application/zip',
                        :disposition => 'attachment',
                        :filename => 'produktionskort.zip'
    end
  end

  private

  def process_url(url)
    @used_filenames ||= []
    url_segments = url.split('/')
    filename = url_segments.last
    url_segments[url_segments.size-1] = CGI::escape(filename)

    if @used_filenames.include?(filename)
      extname = File.extname(filename)
      basename = File.basename(filename, extname)
      n = 1
      while @used_filenames.include?(filename)
        n =+ 1
        filename = "#{basename}#{n}#{extname}"
      end
    end

    @used_filenames << filename

    return [url_segments.join('/'), filename]
  end
end
