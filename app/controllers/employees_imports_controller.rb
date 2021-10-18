class EmployeesImportsController < ApplicationController
  def new
    @employees_import = EmployeesImport.new
  end

  def create
    @employees_import = EmployeesImport.new(params[:employees_import])
    if @employees_import.save
      redirect_to employees_path
    else
      render :new
    end
  end
end
