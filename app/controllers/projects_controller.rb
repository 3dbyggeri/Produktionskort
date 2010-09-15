class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
  end

  def new
    @project = Project.new
    @project.work_processes.build
  end
  
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = "Byggesag oprettet."
        format.html { redirect_to :action => 'index' }
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
      flash[:notice] = "Stamdata for byggesag opdateret."
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Byggesag slettet."
    redirect_to projects_url
  end

  def switch
    if params[:id] == 'new'
      redirect_to :action => 'new'
    else
      project = Project.find(params[:id])
      cookies['active_project'] = project.id
      redirect_to root_path
    end
  end
end
