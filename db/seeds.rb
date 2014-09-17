require 'sequel'

db = Sequel.connect(ENV["DATABASE_URL"])

db.run "insert into menu_sections (location, number) values
              ('Capitol Hill', '(303) 993-8127')
              ('LODO', '(303) 297-3464')"


db.run "insert into menu_sections (name) values
                                        ('Pizza'),
                                        ('Gourmet Pizza'),
                                        ('Slices & Specialty Breads'),
                                        ('Sub Sandwiches'),
                                        ('Appetizers'),
                                        ('Soups'),
                                        ('Salads'),
                                        ('Pasta'),
                                        ('Entrees')"

db.run "insert into gourmet_pizza_items (fk, name, by_slice, description, price) values
  ('2', 'Buffalo Chicken', true, 'grilled chicken, mozzarella and a special spicy buffalo wing sauce', '20'),
  ('2', 'Green Chile', true, 'housemade green chili sauce and mozzarella', 17),
  ('2', 'White Pizza', true, 'seasoned ricotta, parmigiano, and mozzarella', 17),
  ('2', 'Tomato Pesto', true, 'fresh tomato, pesto, garlic, mozzarella and parmigiano', 17),
  ('2', 'Stuffed Meat', true, 'ham, salami, pepperoni, sausage, meatball and mozzarella', 26),
  ('2', 'Stuffed Veggie', true, 'zucchini, broccoli, eggplant spinach, garlic and mozzarella', 26),
  ('2', 'Bacon Cheeseburger', true, 'hamburger, bacon, cheddar & mozzarella in a special sweet tomato sauce', 20),
  ('2', 'Pizza alla Vodka', true, 'vodka cream marinara sauce & mozzarella', 18),
  ('2', 'Chicken Veggie', true, 'grilled chicken, tomato, red onions, scallions, broccoli, garlic,
  basil & mozzarella', 19),
  ('2', 'Margherita', false, 'pizza sauce, basil, fresh mozzarella and parmigiano', 18),
  ('2', 'The Works', true, 'pepperoni, sausage, meatballs, mushrooms, onions, peppers & mozzarella', 20),
  ('2', 'Baked Potato Pizza', true, 'sliced potato, scallions, mozzarella, cheddar, bacon & ranch', 20),
  ('2', 'White Clam', false, 'fresh chopped clams, garlic, oregano & parmigiano', 18),
  ('2', 'White Veggie', false, 'tomato, red onions, scallions, broccoli, garlic, basil & mozzarella', 17),
  ('2', 'White Spinach', false, 'seasoned ricotta, spinach, mozzarella, garlic and parmigiano', 18),
  ('2', 'Hawaiian', true, 'ham, pineapple, pizza sauce and mozzarella', 17),
  ('2', 'BBQ Chicken', false, 'grilled chicken, BBQ sauce, red onion, scallions, mozzarella & cheddar', 20)"
