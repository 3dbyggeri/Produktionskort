class WorkProcessesController < ApplicationController
  ATTACHMENT_KEYS = [:activity_referrals_attributes, :equipment_referrals_attributes, :material_referrals_attributes, :crew_referrals_attributes]

  def index
    @project = Project.find(params[:project_id])
    @work_processes = @project.work_processes

    respond_to do |format|
      format.html
      format.xml { render :xml => @work_processes.to_xml }
    end
  end
  
  def show
    @work_process = WorkProcess.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml do
        render :xml => @work_process.to_xml_deep
      end
    end
  end
  
  def new
    @project = Project.find(params[:project_id])
    @work_process = @project.work_processes.build
  end
  
  def create
    @project = Project.find(params[:project_id])
    process_attachments :work_process, ATTACHMENT_KEYS
    @work_process = @project.work_processes.build(params[:work_process])
    respond_to do |format|
      if @work_process.save
        flash[:notice] = "Produktionskort oprettet."
        format.html { redirect_to @work_process }
        format.xml { render :xml => @work_process.to_xml_deep }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @work_process.errors.to_xml, :status => 400 }
      end
    end
  end
  
  def edit
    @work_process = WorkProcess.find(params[:id])
  end
  
  def update
    @work_process = WorkProcess.find(params[:id])
    process_attachments :work_process, ATTACHMENT_KEYS

    respond_to do |format|
      if @work_process.update_attributes(params[:work_process])
        flash[:notice] = "Produktionskort opdateret."
        format.html { redirect_to @work_process }
        format.xml { render :xml => @work_process.to_xml_deep }
      else
        format.html { render :action => 'edit' }
        format.xml { render :xml => @work_process.errors.to_xml, :status => 400 }
      end
    end
  end
  
  def destroy
    @work_process = WorkProcess.find(params[:id])
    project_id = @work_process.project_id
    @work_process.destroy
    respond_to do |format|
      flash[:notice] = "Produktionskort slettet."
      format.html { redirect_to project_work_processes_url(project_id) }
      format.xml { render :nothing => true }
    end
  end
end
