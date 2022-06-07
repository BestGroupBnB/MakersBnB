require "request_space_entity"
require "request_entity"

class RequestTable
  def initialize(db)
    @db = db
  end
    
    def add(request)
      result = @db.run("INSERT INTO requests(space_id,requester_id,owner_id,booking_date,status) VALUES($1,$2,$3,$4,$5) RETURNING id;",
      [request.space_id,request.requester_id,request.owner_id,request.booking_date,request.status])
      return result[0]["id"]
    end 

  def get(id)
    request = @db.run("SELECT * FROM requests WHERE id=$1;",[id])
    return row_to_object(request[0])    
  end 

  def list
    return @db.run("SELECT * FROM requests ORDER BY id;").map do |row|
             row_to_object(row)
           end
  end 

   def requests_i_have_made(id)
        result = @db.run("SELECT sp.name , sp.description,sp.price, req.booking_date, req.status FROM requests AS req LEFT JOIN spaces AS sp  ON req.space_id = sp.id WHERE req.requester_id = $1",[id])
        return result.to_a.map do |request|
          row_to_object_request_space(request)
        end 
    end 
  end 

    def requests_i_have_received(id)
        result = @db.run("SELECT sp.name , sp.description,sp.price, req.booking_date, req.id FROM requests AS req LEFT JOIN spaces AS sp  ON req.space_id = sp.id WHERE req.owner_id = $1",[id])
        return result.to_a.map do |request|
          row_to_object_request_space(request)
        end 
    end 
  end 

    def get_request_space_entity(id)
      result = @db.run("SELECT sp.name , sp.description,sp.price, req.booking_date, req.id, req.space_id FROM requests AS req LEFT JOIN spaces AS sp  ON req.space_id = sp.id WHERE req.id = $1",[id])
      return row_to_object_request_space(result[0])
    end 


    def row_to_object(row)
      return RequestEntity.new(
          row["space_id"].to_i,
          row["requester_id"].to_i,
          row["owner_id"].to_i,
          row["booking_date"]
      )
    end 

    def row_to_object_request_space(row)
      return RequestSpaceEntity.new(
        row["name"],
        row["description"],
        row["price"].to_i,
        row["booking_date"],
        row["status"],
        row["id"].to_i,
        row["space_id"].to_i
      )

  def row_to_object_request_space(row)
    return RequestSpaceEntity.new(
      row["name"],
      row["description"],
      row["price"].to_i,
      row["booking_date"]
    )

  end

end
