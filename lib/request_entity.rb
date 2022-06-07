class RequestEntity
  def initialize(space_id,requester_id, owner_id, booking_date,status = "Pending", id = nil)
    @space_id = space_id
    @requester_id = requester_id
    @owner_id = owner_id
    @booking_date = booking_date
    @status = status
    @id = id
  end 
  attr_reader :space_id, :requester_id,:owner_id,:booking_date,:status, :id
end
