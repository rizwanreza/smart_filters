ActiveRecord::Schema.define(:version => 0) do
  create_table :address_books, :force => true do |t|
    t.string :name
    t.text :address
    t.integer :zipcode
    t.string :company
    t.string :email
    t.string :phone
    t.string :domain

    t.timestamps
  end
end
