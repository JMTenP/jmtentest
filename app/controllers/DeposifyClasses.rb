require 'fileutils'
require 'nokogiri'
require 'json'

# crea un fichero html del typo recibido en el parametro (dashboard,form....)
class DeposifyHtmlUserClass  
  def initialize(html_type)
    @html_type=html_type
    @current_user="usuariodepruebas" # eliminar esto 
    remove_user_html
    create_user_html
  end

  def remove_user_html
    @file_html_user= Rails.root.join('html/'+@current_user+'.html')
    if File.exist?(@file_html_user) 
      then 
      FileUtils.rm(@file_html_user)
    end
  end

  def create_user_html
    html_file_type = Rails.root.join('html/'+@html_type+'.html') 
    FileUtils.copy(html_file_type, @file_html_user)
  end

  def file_html_user
    @file_html_user
  end

end

# Personaliza los datos a un Dashboard
class DeposifyHtmlDashboardClass
   
  def initialize(data)
    @data=data
    @current_user="usuariodepruebas" # eliminar esto 
    newhtml=DeposifyHtmlUserClass.new('dashboard')
    @file_html_user=newhtml.file_html_user
    from_json_file
  end

  def from_json_file
    json_data = File.read(Rails.root.join('app/depasifyjson/dashboard.json'))
    @data_json = JSON.parse(json_data)
    @file_contents = File.read(@file_html_user)
    dashboard_titles
    route_titles
    create_list 
    File.write(@file_html_user,@file_contents)
  end

  def dashboard_titles
    @file_contents = @file_contents.sub("CabDashboard¿",@data.table_name.capitalize)
    @file_contents = @file_contents.sub("SearchDashboard¿",@data.table_name)
    @file_contents = @file_contents.sub("CreateNew¿",@data.table_name.capitalize.singularize)
    @file_contents=@file_contents.sub("EditRout¿",@data.table_name)
    linking='onclick="htpp://localhost:3000/'+@data.table_name+'/'
    @file_contents=@file_contents.sub("EditRout¿",linking)
    @data_json['dashboard'].each do |value|
      @file_contents = @file_contents.sub("TitleDashboard¿",value)
    end
    @file_contents=@file_contents.gsub("TitleDashboard¿",'')
    @data.first.attributes.each do |name, data|  
      @file_contents=@file_contents.sub("FieldHeader¿",name)
    end
    @file_contents=@file_contents.gsub("FieldHeader¿",'') 
  end

  def route_titles
    @data_json['routedashboard'].each do |value|
      @file_contents=@file_contents.sub("RouteDashboard¿",value)
    end
    @file_contents=@file_contents.gsub("RouteDashboard¿",'')
  end
  
  def create_list
    if @data.none? 
      then
      @file_contents=@file_contents.sub("Records¿",'No records found')
      return
    end 
    td=''
    @data.each do |record|
      td=td+'<tr>'
      record.attributes.each do |name, data|   
        case data
        when String
        td=td+'<td>'+data+'</td>' 
        when Integer
        td=td+'<td>'+data.to_s+'</td>' 
        when Float
        td=td+'<td>'+sprintf("%.2f", data)+'</td>' 
        when Array
        td=td+'<td>'+data.join(", ")+'</td>' 
        when Hash
        td=td+'<td>'+data.to_query+'</td>' 
        when ActiveSupport::TimeWithZone
        td=td+'<td>'+data.strftime("%Y-%m-%d %H:%M:%S")+'</td>' 
        else
        td=td+'<td>'+"-"+'</td>' 
        end
      end
      td=td+'<td><button onclick="redirectToEditPage('+record.id.to_s+')">Edit</button></td>'
    end
    @file_contents=@file_contents.sub("Records¿",td)  
    @file_contents = @file_contents.sub("RouteCreate¿/Create",@data.table_name)
  end
end

# Personaliza los datos a un form
class DeposifyHtmlFormClass
   
  def initialize(data)
    @data=data
    @current_user="usuariodepruebas" # eliminar esto 
    newhtml=DeposifyHtmlUserClass.new('form')
    @file_html_user=newhtml.file_html_user
    from_json_file
  end

  def from_json_file
    #json_data = File.read(Rails.root.join('app/depasifyjson/dashboard.json'))
    #@data_json = JSON.parse(json_data)
    @file_contents = File.read(@file_html_user)
    form_titles
    create_inputs
    File.write(@file_html_user,@file_contents)
  end

  def form_titles
    if !@data.nil? 
      then
      @file_contents = @file_contents.sub("CabForm¿",@data.class.name.capitalize)
      @file_contents = @file_contents.sub("display¿",'')
    else
      @file_contents = @file_contents.sub("CabForm¿",'Error acceding to the record.')
      @file_contents = @file_contents.sub("display¿",'''style="display: none;"''')
    end
  end

  def create_inputs
    if @data.nil? 
      then
      @file_contents=@file_contents.sub("Records¿",'No record found please cancel the action')
      return
    end 
    div=''
    @data.attributes.each do |name, data| 
      div=div+'<div class="form-group">'
      case data
        when String
          div=div+'''<label for="string-field">'''+name+':</label>'
          div=div+'''<input type="text" class="form-control"''' 
          div=div+'id="'+name+'" value="'+data+'">'
          div=div+'</input>'
        when Integer
          div=div+'''<label for="integer-field">'''+name+':</label>'
          div=div+'''<input type="integer-field" class="form-control"''' 
          div=div+'id="'+name+'" value="'+data.to_s+'">'
          div=div+'</input>'
        when Float
          div=div+'''<label for="float-field">'''+name+':</label>'
          div=div+'''<input type="float-field" class="form-control"''' 
          div=div+'id="'+name+'" value="'+sprintf("%.2f", data)+'">'
          div=div+'</input>'
        when Array
          div=div+'''<label for="string-field">'''+name+':</label>'
          div=div+'''<input type="text" class="form-control"''' 
          div=div+'id="'+name+'" value="'+data.join(", ")+'">'
          div=div+'</input>'
        when Hash
          div=div+'''<label for="hash-field">'''+name+':</label>'
          div=div+'''<input type="hash-field" class="form-control"''' 
          div=div+'id="'+name+'" value="'+data.to_query+'">'
          div=div+'</input>'
        when ActiveSupport::TimeWithZone
          div=div+'''<label for="datetime-local">'''+name+':</label>'
          div=div+'''<input type="datetime-local" class="form-control"''' 
          div=div+'id="'+name+'" value="'+data.strftime("%Y-%m-%d %H:%M:%S")+'">'
          div=div+'</input>'
        else
      end
      div=div+'</div>'
    end
    @file_contents=@file_contents.sub("Records¿",div)
  end
end

