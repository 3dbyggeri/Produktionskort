class ProjectsController < ApplicationController
  ATTACHMENT_KEYS = [:planning_referrals_attributes, :site_referrals_attributes, :approvals_attributes]

  def index
    @projects = Project.all

    respond_to do |format|
      format.html
      format.xml { render :xml => @projects.to_xml }
    end
  end

  def new
    @project = Project.new
    @project.work_processes.build
  end
  
  def create
    process_attachments :project, ATTACHMENT_KEYS
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = "Byggesag oprettet."
        format.html { redirect_to :action => 'index' }
        format.xml { render :xml => @project.to_xml }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @project.errors.to_xml, :status => 400 }
      end
    end
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html { render :nothing => true, :status => 404 }
      format.xml do
        render :xml => @project.to_xml_deep
      end
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    process_attachments :project, ATTACHMENT_KEYS, @project

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "Stamdata for byggesag opdateret."
        format.html { redirect_to :action => 'index' }
        format.xml { render :xml => @project.to_xml }
      else
        format.html { render :action => 'edit' }
        format.xml { render :xml => @project.errors.to_xml, :status => 400 }
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      flash[:notice] = "Byggesag slettet."
      format.html { redirect_to projects_url }
      format.xml { render :nothing => true }
    end
  end

  def switch
    if params[:id] == 'new'
      redirect_to :action => 'new'
    else
      project = Project.find(params[:id])
      cookies['active_project'] = project.id
      redirect_to project_work_processes_path(project)
    end
  end
end
