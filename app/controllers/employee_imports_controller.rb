class EmployeeImportsController < ApplicationController

  def new
    @employee_import = EmployeeImport.new
  end 

  def create
    @employee_import = EmployeeImport.new(params[:employee_import])
    if @employee_import.save
      redirect_to employees_path, notice: 'Imported employees succesfully.'
    else
      render :new
    end
  end
end