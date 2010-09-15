class WorkProcessesController < ApplicationController
  before_filter :find_active_project

  def index
    @work_processes = @project.work_processes
  end
  
  def show
    @work_process = @project.work_processes.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work_process.to_xml(:include => [ :project,
                                                                      :companies,
                                                                      :equipment,
                                                                      :inspections, 
                                                                      :material_packages,
                                                                      :preconditions,
                                                                      :protections,
                                                                      :qualifications,
                                                                      :requirements,
                                                                      :wasted_times,
                                                                      :activity_referrals,
                                                                      :work_method_referrals,
                                                                      :crew_referrals,
                                                                      :material_referrals,
                                                                      :equipment_referrals ],
                                                        :methods => [  ]) }
    end
  end
  
  def new
    @work_process = @project.work_processes.build
  end
  
  def create
    project_attributes = params[:work_process].delete(:project_attributes)
    project_attributes.delete(:id)
    @work_process = @project.work_processes.build(params[:work_process])
    if @work_process.save && @work_process.project.update_attributes(project_attributes)
      flash[:notice] = "Produktionskort oprettet."
      redirect_to @work_process
    else
      render :action => 'new'
    end
  end
  
  def edit
    @work_process = @project.work_processes.find(params[:id])
  end
  
  def update
    @work_process = @project.work_processes.find(params[:id])
    if @work_process.update_attributes(params[:work_process])
      flash[:notice] = "Produktionskort opdateret."
      redirect_to @work_process
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @work_process = @project.work_processes.find(params[:id])
    @work_process.destroy
    flash[:notice] = "Produktionskort slettet."
    redirect_to work_processes_url
  end

  def find_active_project
    if cookies['active_project'].blank?
      flash[:notive] = "Du har ikke valgt nogen aktiv byggesag."
      redirect_to :controller => 'projects', :action => 'index'
    end

    @project = Project.find(cookies['active_project'])
  end
end
