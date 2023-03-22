class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :uuid
      t.float :amount
      t.string :currency
      t.string :description
      t.datetime :operation_date
      t.string :status
      t.string :kind
      t.timestamps null: false
    end
  end
end
