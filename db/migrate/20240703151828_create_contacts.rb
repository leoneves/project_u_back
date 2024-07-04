class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :phone, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :contacts, :cpf, unique: true
  end
end
