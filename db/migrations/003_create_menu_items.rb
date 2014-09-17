Sequel.migration do
  change do
    create_table(:menu_items) do
      primary_key :id
      Integer :fk, unique: true, null: false
      String :name
      String :description
      String :price
    end
  end
end
