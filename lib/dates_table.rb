

class DatesTable

  def initialize(db)
    @db = db
  end

  def add(space_id, space_entry)
    return range_to_array(space_entry).map do |date|
      result = @db.run("INSERT INTO dates(space_id,available_date) VALUES($1,$2) RETURNING id;",
[space_id,date])
      result[0]["id"]
    end
  end  

  def delete(space_id, booking_date)
    result = @db.run("DELETE FROM dates WHERE space_id=$1 AND available_date=$2 RETURNING id;",
[space_id,booking_date])
    return result.nil? ? result[0]["id"] : "false"
  end

  def list(space_id)
    result = @db.run("SELECT available_date FROM dates WHERE space_id = $1;",[space_id])
    return result.to_a.map do |element|
      element["available_date"]
    end
  end

  def range_to_array(space_entry)
    date_array = []
    date_from = DateTime.parse(space_entry.date_from)
    date_to = DateTime.parse(space_entry.date_to)

    date_next = date_from
    date_array.push(date_from.strftime("%F"))

    while date_next < date_to do
      date_next = date_next.next
      date_array.push(date_next.strftime("%F"))
    end

    return date_array
  end
end
