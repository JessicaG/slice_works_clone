Sequel.migration do
  up do
    create_table(:menu_sections) do
      primary_key :id
      String :name
    end
  end

  down do
    drop_table :menu_sections
  end
end
