class WorkProcessesController < ApplicationController
  def index
    @work_processes = WorkProcess.all
  end
  
  def show
    @work_process = WorkProcess.find(params[:id])
    
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
    @work_process = WorkProcess.new
    @work_process.project = Project.new
  end
  
  def create
    project_attributes = params[:work_process].delete(:project_attributes)
    @work_process = WorkProcess.new(params[:work_process])
    unless project_attributes[:id].blank?
      @work_process.project = Project.find(project_attributes.delete(:id))
    else
      @work_process.project = Project.new(project_attributes)
    end
    if @work_process.save && @work_process.project.update_attributes(project_attributes)
      flash[:notice] = "Successfully created work process."
      redirect_to @work_process
    else
      render :action => 'new'
    end
  end
  
  def edit
    @work_process = WorkProcess.find(params[:id])
  end
  
  def update
    @work_process = WorkProcess.find(params[:id])
    if @work_process.update_attributes(params[:work_process])
      flash[:notice] = "Successfully updated work process."
      redirect_to @work_process
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @work_process = WorkProcess.find(params[:id])
    @work_process.destroy
    flash[:notice] = "Successfully destroyed work process."
    redirect_to work_processes_url
  end
end
