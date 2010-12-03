class Byggeweb::FilesController < ApplicationController
  def index
    find_project
    render :json => @project.byggeweb.files(params[:folder_id])
  end

  def download
    find_project
    file = @project.byggeweb.file(params[:id])

    send_data file.read, :type => 'application/octet-stream',
                         :disposition => 'attachment',
                         :filename => file.original_filename
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
