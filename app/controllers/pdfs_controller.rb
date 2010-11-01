# coding: utf-8
class PdfsController < ApplicationController
  def new
    @work_process = WorkProcess.find(params[:work_process_id])
  end

  def create
    t = Tempfile.new "produktionskort"
    t.print "foo"
    send_file t.path, :type => 'text/plan',
                      :disposition => 'attachment',
                      :filename => 'produktionskort.txt'
    t.close
  end

  private

  def process_url(url)
    @used_filenames ||= ['produktionskort.pdf']
    filename = url.split('/').last.sub(/\?\d+$/, '')

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

    return [url, filename]
  end
end