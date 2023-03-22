require_relative 'DeposifyClasses'

class EmployeesController < ApplicationController
  
  before_action :set_employee, only: [:show, :activate, :deactivate]
  before_action :html_file

  def index
    if params[:params].blank?
      employees=Employee.all
    else
      employees = Employee.where("user_id LIKE ?", params[:search_term])
    end
    html = DeposifyHtmlDashboardClass.new(employees)
    render file: @file_html_user, search_term: params[:search_term]
  end

  def show
    render json: JSONAPI::Serializer.serialize(@employee, namespace: Api::Lts)
  end

  def create
    employee = EmployeeService.create()
    render json: JSONAPI::Serializer.serialize(employee, namespace: Api::Lts)
  end

  def update

  end

  def activate
    @employee.update(status: 'active')
    render json: JSONAPI::Serializer.serialize(@employee, namespace: Api::Lts)
  end

  def deactivate
    @employee.update(status: 'inactive')
    render json: JSONAPI::Serializer.serialize(@employee, namespace: Api::Lts)
  end

  private
  def create_params
    params.require(:data).permit(:email, :wallet_address, :wallet_network,
      :salary, :salary_currency, :status, :title, :name)
  end

  def set_employee
    @employee = Employee.find_by_uuid(params[:id])
  end

  def html_file
    @current_user="usuariodepruebas"
    @file_html_user= Rails.root.join('html/'+@current_user+'.html')
  end
end
