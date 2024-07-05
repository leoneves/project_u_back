class AddUfColumnToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :uf, :string, null: false 
  end
end
