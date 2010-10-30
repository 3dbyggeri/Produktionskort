class Fileshare::FilesController < ApplicationController
  def index
    find_project
    render :json => @project.fileshare.files(params[:path])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
