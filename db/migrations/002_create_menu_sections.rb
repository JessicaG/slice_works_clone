Sequel.migration do
  change do
    create_table(:menu_sections) do
      primary_key :id
      String :name
    end
  end
end
