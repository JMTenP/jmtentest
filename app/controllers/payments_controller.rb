require_relative 'DeposifyClasses'

class PaymentsController < ApplicationController
 
  before_action :generate_html

  def index
    if params[:search_term].blank?
      payments=Payment.all
    else
      payments = Payment.where("description LIKE ?", "%#{params[:search_term]}%")
    end
    html = DeposifyHtmlDashboardClass.new(payments)
    render file: @file_html_user, search_term: params[:search_term]
  end

  def edit
    payments = Payment.find(params[:id])
    html = DeposifyHtmlFormClass.new(payments)
    render file: @file_html_user
  end
  
  def update
    1/0
    payments = Payment.find(params[:id])
    html = DeposifyHtmlFormClass.new(payments)
    if payments.update(payments_params)
      redirect_to my_model_path(@payments), notice: 'Record updated successfully.'
    else
      render file: @file_html_user
    end
  
  private
    
  def payments_params
    params.require(:payments).permit(:all)
  end

  end
  
  def create
    1/0
    payments = Payment.create()
    html = DeposifyHtmlFormClass.new(payments)
    render file: @file_html_user
  end

  def generate_html
    @current_user="usuariodepruebas"
    @file_html_user= Rails.root.join('html/'+@current_user+'.html')
  end
 
end