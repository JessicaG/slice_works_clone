Sequel.migration do
  change do
    create_table(:contacts) do
      primary_key :id
      String :location
      String :number
    end
  end
end
