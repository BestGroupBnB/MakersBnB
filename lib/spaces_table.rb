require "space_entity"
require "space_user_entity"

class SpacesTable
  def initialize(db)
    @db = db
  end

  def list
    return @db.run("SELECT * FROM spaces ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def add(space)
    result = @db.run("INSERT INTO spaces (name, description, price, date_from, date_to, user_id) 
    VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;",
    [space.name, space.description, space.price, space.date_from, space.date_to, space.user_id])
    return result[0]["id"]
  end

  def remove(index)
    @db.run("DELETE FROM spaces WHERE id = $1;", [index])
  end

  def update(index, new_space_entry)
    @db.run("UPDATE spaces SET name = $1, description = $2, price = $3, date_from = $4, date_to = $5 WHERE id = $6;",
    [new_space_entry.name, new_space_entry.description, new_space_entry.price, 
new_space_entry.date_from, new_space_entry.date_to, index])
  end

  def get(index)
    result = @db.run("SELECT * FROM spaces WHERE id = $1;", [index])
    return row_to_object(result[0])
  end

  def get_owner_by_spaceID(id)
    result = @db.run("SELECT us.email FROM spaces AS sp LEFT JOIN users AS us ON sp.user_id = us.id WHERE sp.id = $1",[id])
    return row_to_object_space_user(result[0])
  end 

  private

  def row_to_object(row)
    return SpaceEntity.new(
      row["name"],
      row["description"],
      row["price"].to_i,
      row["date_from"],
      row["date_to"],
      row["user_id"].to_i,
      row["id"]
    )
  end

  def row_to_object_space_user(row)
    return SpaceUserEntity.new(
      row["email"],
      row["id"]
    )
  end 


end
