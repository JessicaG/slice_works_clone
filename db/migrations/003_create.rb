puts "here"
Sequel.migration do
  up do
    create_table(:people) do
      primary_key :id
      String :name
    end
  end

  down do
    puts "dropping"
    drop_table :people
  end
end
