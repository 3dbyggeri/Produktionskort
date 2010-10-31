class Fileshare::FoldersController < ApplicationController
  def index
    find_project
    if params[:path]
      render :json => @project.fileshare.folders(params[:path]).to_json
    else
      render :json => @project.fileshare.folders.to_json('Filbibliotek')
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
