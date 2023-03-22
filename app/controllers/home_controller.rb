
require 'fileutils'
require_relative 'DeposifyClasses'

class HomeController < ApplicationController
  before_action :html_Dashboard, only: [:index]

  def index
    current_user="usuariodepruebas" # eliminar esto
    html_file = Rails.root.join('html/'+current_user+ ".html")
    send_file html_file, type: 'text/html', disposition: 'inline'
  end
  
  private

  def html_Dashboard
    payments=Payment.all
    html = DeposifyHtmlDashboardClass.new(payments)
  end
end 

