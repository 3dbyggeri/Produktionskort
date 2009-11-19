class WorkProcessesController < ApplicationController
  # GET /work_processes
  # GET /work_processes.xml
  def index
    @work_processes = WorkProcess.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @work_processes }
    end
  end

  # GET /work_processes/1
  # GET /work_processes/1.xml
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

  # GET /work_processes/new
  # GET /work_processes/new.xml
  def new
    @work_process = WorkProcess.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work_process }
    end
  end

  # GET /work_processes/1/edit
  def edit
    @work_process = WorkProcess.find(params[:id])
  end

  # POST /work_processes
  # POST /work_processes.xml
  def create
    @work_process = WorkProcess.new(params[:work_process])

    respond_to do |format|
      if @work_process.save
        flash[:notice] = 'Process was successfully created.'
        format.html { redirect_to(@work_process) }
        format.xml  { render :xml => @work_process, :status => :created, :location => @work_process }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work_process.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /work_processes/1
  # PUT /work_processes/1.xml
  def update
    @work_process = WorkProcess.find(params[:id])

    respond_to do |format|
      if @work_process.update_attributes(params[:work_process])
        flash[:notice] = 'Process was successfully updated.'
        format.html { redirect_to(@work_process) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work_process.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /work_processes/1
  # DELETE /work_processes/1.xml
  def destroy
    @work_process = WorkProcess.find(params[:id])
    @work_process.destroy

    respond_to do |format|
      format.html { redirect_to(work_processes_url) }
      format.xml  { head :ok }
    end
  end
end
