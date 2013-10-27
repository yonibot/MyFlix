class UpdatePayments < ActiveRecord::Migration
  def up
    change_table :payments do |t|
      t.remove :amount
      t.integer :amount
    end
  end

  def down
    add_column :payments, :amount, :float
  end

end
