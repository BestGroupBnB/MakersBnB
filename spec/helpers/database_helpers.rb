require "database_connection"

class DatabaseHelpers
  def self.clear_table(table_name)
    test_db_connection.run("DELETE FROM #{table_name};")
    test_db_connection.run("ALTER SEQUENCE #{table_name}_id_seq RESTART WITH 1;")
  end

  def self.test_db_connection
    $test_connection ||= DatabaseConnection.new("localhost", "bestgroupbnb_test")
  end
end
