class JobsController < ApplicationController


  def index
  	@jobs =Job.page(params[:page]).per(25) # au lieu de Job.all, pour la pagination avec Kaminari
  end

  def show
	@job = Job.find(params[:id])
  end

  def new
  	@job = Job.new
  end

  def create
  	@job = Job.new(job_params)
  	if @job.save
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end
  
  def edit
  @job = Job.find(params[:id])
  end

  def update
  @job = Job.find(params[:id])
  if @job.update_attributes(job_params)
  	redirect_to(:action =>'show', :id => @job.id)
  else
  	render ('index')
  end
  end

def delete
	@job = Job.find(params[:id])
end

def destroy
	@job = Job.find(params[:id]).destroy
	redirect_to root_path

end



private 

def job_params
params.require(:job).permit(:title,:company,:url)
end



end
