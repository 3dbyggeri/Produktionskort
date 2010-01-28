class PageController < ApplicationController
  def index
    @work_processes = WorkProcess.all(:order => 'created_at', :limit => 5)
  end
end
