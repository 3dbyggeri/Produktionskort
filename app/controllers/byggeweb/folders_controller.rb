class Byggeweb::FoldersController < ApplicationController
  def index
    find_project
    render :json => @project.byggeweb.root_folder
  end

  def show
    find_project
    render :json => @project.byggeweb.folder(params[:id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
