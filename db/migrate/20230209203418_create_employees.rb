class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.references :account, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
