require 'uri'

class NotesController < ApplicationController
    
  before_action :resource_data

    def index
      note = Note.where(resource_type: @table, resource_id: @id) .sort_by(&:created_at).reverse

      render json: JSONAPI::Serializer.serialize(
        note,
        is_collection: true,
        namespace: Api::Lts
      )
    end

    def create
      note = Note.create!(
        user: current_user,
        body: params[:data][:body],
        resource_type: @table,
        resource_id: @id,
        uuid: SecureRandom.uuid
      )
      render json: JSONAPI::Serializer.serialize(note, namespace: Api::Lts)
    end
    
    def show
      note = Note.find_by(resource_type: @table, resource_id: @id, id: params[:id])
      render json: JSONAPI::Serializer.serialize(note, namespace: Api::Lts)
    end

    def update
      note = Note.find_by(resource_type: @table, resource_id: @id, id: params[:id])
      note.update(note_params)
      render json: JSONAPI::Serializer.serialize(note, namespace: Api::Lts)
    end
    
    def destroy
      note = Note.find_by(resource_type: @table, resource_id: @id, id: params[:id]).destroy
      render json: {data: []}, status: 201
    end
  
    private

    def note_params
      params.require(:data).permit(:body)
    end
    
    def resource_data
      @table=URI.parse(request.original_url).path.split('/')[3]
      @table_name = @table.tableize.capitalize.singularize.constantize
      @uuid=URI.parse(request.original_url).path.split('/')[4]
      @id=@table_name.find_by_uuid!(@uuid).id
    end 

end
