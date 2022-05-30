$:.unshift File.join(File.dirname(__FILE__), 'lib')
require "database_connection"

# This file sets up the database tables. If you change any of the contents
# of this file, you should rerun `ruby reset_tables.rb` to ensure that your
# database tables are re-created.

# # Create the databases and set up the tables
# ; createdb bestgroupbnb_dev
# ; createdb bestgroupbnb_test
# ; ruby reset_tables.rb
# ; change in app.rb, reset_tables.rb

def reset_tables(db)
  db.run("DROP TABLE IF EXISTS users;")
  db.run("CREATE TABLE users (id SERIAL PRIMARY KEY, email TEXT NOT NULL, password TEXT NOT NULL);")

  # Add your table creation SQL here
  # Each one should be a pair of lines:
  #   db.run("DROP TABLE IF EXISTS ...;")
  #   db.run("CREATE TABLE ... (id SERIAL PRIMARY KEY, ...);")
end

dev_db = DatabaseConnection.new("localhost", "bestgroupbnb_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "bestgroupbnb_test")
reset_tables(test_db)
