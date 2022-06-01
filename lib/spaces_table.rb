require "space_entity"

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
    result = @db.run("INSERT INTO spaces (name, description, price, date_from, date_to) 
    VALUES ($1, $2, $3, $4, $5) RETURNING id;",
    [space.name, space.description, space.price, space.date_from, space.date_to])
    return result[0]["id"]
  end


  private

  def row_to_object(row)
    return SpaceEntity.new(
      row["name"],
      row["description"],
      row["price"].to_i,
      row["date_from"],
      row["date_to"],
      row["id"]
    )
  end

end