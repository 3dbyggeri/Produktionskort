class Fileshare::FoldersController < ApplicationController
  def index
    find_project
    render :json => @project.fileshare.folders.to_json(true)
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
