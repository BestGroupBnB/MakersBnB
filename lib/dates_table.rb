

class DatesTable

  def initialize(db)
    @db = db
    @available_dates_array = []
  end

  def add(space_id, space_entry)
    data = range_to_array(space_entry).map do |date|
      result = @db.run("INSERT INTO dates(space_id,available_date) VALUES($1,$2) RETURNING id;",
[space_id,date])
    end
    return range_to_array(space_entry).map do |date|
      result = @db.run("INSERT INTO dates(space_id,available_date) VALUES($1,$2) RETURNING id;",
[space_id,date])
    end
  end  

  def list(space_id)
    result = @db.run("SELECT available_date FROM dates WHERE space_id = $1;",[space_id])
    return result.to_a.map do |element|
      element["available_date"]
    end
  end

  def range_to_array(space_entry)
    
    date_from = DateTime.parse(space_entry.date_from)
    date_to = DateTime.parse(space_entry.date_to)

    date_next = date_from
    @available_dates_array.push(date_from.strftime("%F"))

    while date_next < date_to do
      date_next = date_next.next
      @available_dates_array.push(date_next.strftime("%F"))
    end

    return @available_dates_array
  end
end
