Sequel.migration do
  change do
    create_table(:pizza_toppings) do
      primary_key :id
      String :name
    end
  end
end
