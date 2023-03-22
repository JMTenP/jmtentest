class CreateAccount < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid
      t.integer :role
      t.string :referral_id
      t.string :referred_by
      t.string :name
      t.string :surname
      t.string :gender
      t.date :birthdate
      t.string :country
      t.string :language
      t.string :status
      t.timestamps null: false
    end
  end
end
