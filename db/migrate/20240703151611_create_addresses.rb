class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :cep, null: false
      t.decimal :latitude, precision: 8, scale: 6, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.text :address, null: false
      t.text :address_complement, null: true

      t.timestamps
    end
  end
end
