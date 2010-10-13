class Bips::SectionsController < ApplicationController
  def index
    find_project
    render :json => @project.bips_root_sections
  end

  def show
    find_project
    render :json => @project.bips_section(params[:id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end
end
