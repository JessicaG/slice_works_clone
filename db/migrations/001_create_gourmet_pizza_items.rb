Sequel.migration do
  change do
    create_table(:gourmet_pizza_items) do
      primary_key :id
      Integer :fk, unique: true, null: false
      String :name
      Boolean :by_slice
      String :description
      String :price
    end
  end
end

