class Fileshare::FilesController < ApplicationController
  def index
    find_project
    render :json => @project.fileshare.files(params[:path]).to_json
  end

  def download
    find_project
    file = @project.fileshare.file(params[:key])

    send_data file.read, :type => 'application/octet-stream',
                         :disposition => 'attachment',
                         :filename => file.original_filename
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
