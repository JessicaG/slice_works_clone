Sequel.migration do
  change do
    create_table(:gourmet_pizza_items) do
      primary_key :id
      Integer :fk
      String :name
      Boolean :by_slice
      String :description
      String :price
    end
  end
end

