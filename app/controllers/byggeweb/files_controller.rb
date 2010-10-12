class Byggeweb::FilesController < ApplicationController
  def index
    find_project
    render :json => @project.byggeweb.files(params[:folder_id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
