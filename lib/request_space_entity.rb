class RequestSpaceEntity
  def initialize(name,description,price,booking_date, status, id = nil,sp_id = nil)
    @name = name
    @description = description
    @price = price
    @booking_date = booking_date
    @status = status
    @id = id
    @sp_id = sp_id
  end 

  attr_reader :name, :description, :price, :booking_date, :status, :id, :sp_id
end
