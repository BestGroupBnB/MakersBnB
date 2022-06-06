class RequestTable
    def initialize(db)
        @db = db
    end
    
    def add(request)
      result = @db.run("INSERT INTO requests(space_id,requester_id,owner_id) VALUES($1,$2,$3) RETURNING id;",
      [request.space_id,request.requester_id,request.owner_id])
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

   # def requests_i_have_received(id)
    #    result = @db.run("SELECT sp.name FROM requests AS req LEFT JOIN spaces AS sp  ON req.space_id = sp.id WHERE req.owner_id = $1",[id])
    #    puts result.to_a
    #end 

    #def requests_i_have_made(id)
    #    @db.run("SELECT ")
    #end 

    def row_to_object(row)
      return RequestEntity.new(
          row["space_id"].to_i,
          row["requester_id"].to_i,
          row["owner_id"].to_i
      )
    end 
end 