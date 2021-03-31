class TimesheetController < ApplicationController
  def new
  end

  def create
    form_params = timesheet_params_new

    @timesheet = Timesheet.new(form_params)
    if @timesheet.save
      redirect_to timesheet_index_path
      flash[:success] = format('Successfully added timesheet with id %d.', @timesheet.id)
    else
      render :new
    end
  end
  

  def index
    @timesheets = Timesheet.all
  end

  # Metoda folosita la popularea paginii cu datele unui singur timesheet
  # GET /timesheet/:id/show
  def show
    @timesheet = Timesheet.find(params[:id])
  end

=begin
Metoda folosita la populare paginii de editare timesheet
GET /timesheet/:id/edit
=end
  def edit
    @timesheet = Timesheet.find(params[:id])
  end

  # Metoda folosita pentru a salva campurile editate a unui timesheet
  # POST /timesheet/:id/edit
  def update
    form_params = timesheet_params_edit

    @timesheet = Timesheet.update(params[:id], form_params)
    if @timesheet.save
      redirect_to timesheet_index_path
      flash[:success] = format('Successfully saved timesheet with id %d.', @timesheet.id)
    else
      render 'edit'
    end
  end

  #Metoda folosita pentru a sterge un timesheet
  # DELETE /timesheet/:id/delete
  def destroy
    Timesheet.delete(params[:id])
    redirect_back fallback_location: root_path
    flash[:success] = format('Successfully deleted timesheet with id %d.', params[:id])
  end

  #https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
  def approve
    @timesheet = Timesheet.update(params[:timesheet_id], approved: 1)
    if @timesheet.save(:validate => false)
      redirect_back fallback_location: root_path
      flash[:success] = format('Successfully approved timesheet with id %d.', @timesheet.id)
    else
      redirect_back fallback_location: root_path
      flash[:danger] = format('Cannot approve timesheet with id %d.', @timesheet.id)
    end
  end

  def unapprove
    @timesheet = Timesheet.update(params[:timesheet_id], approved: 0)
    if @timesheet.save(:validate => false)
      redirect_back fallback_location: root_path
      flash[:success] = format('Successfully unapproved timesheet with id %d.', @timesheet.id)
    else
      redirect_back fallback_location: root_path
      flash[:danger] = format('Cannot unapprove timesheet with id %d.', @timesheet.id)
    end
  end

  private
  def timesheet_params_new
    params.permit(:employee_id, :budget_id, :hours, :date_of_service)
  end

  def timesheet_params_edit
    params.require(:timesheet).permit(:employee_id, :budget_id, :hours, :date_of_service)
  end
end
