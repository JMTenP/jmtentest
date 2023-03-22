class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :body
      t.references :resource, polymorphic: true
      t.references :user, index: true
      t.string :uuid, index: true
      t.timestamps
    end
  end
end
