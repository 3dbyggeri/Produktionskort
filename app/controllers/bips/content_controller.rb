class Bips::ContentController < ApplicationController
  def index
    find_project
    render :json => @project.bips_content(params[:section_id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
