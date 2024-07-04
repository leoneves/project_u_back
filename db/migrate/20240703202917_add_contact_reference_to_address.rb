class AddContactReferenceToAddress < ActiveRecord::Migration[7.1]
  def change
    change_table :addresses do |t|
      t.references :contact, null: true, foreign_key: true, type: :uuid
    end
  end
end
