class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
  end
  
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @project = Project.new
    @project.work_processes.build
  end
  
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = "Successfully created project."
        format.html { redirect_to @project }
        format.js
      else
        format.html { render :action => 'new' }
        format.js
      end
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
end
