class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :user_id
      t.float :amount
      t.string :reference
      t.timestamps
    end
  end
end
