class RequestSpaceEntity
    def initialize(name,description,price,booking_date,id = nil)
        @name = name
        @description = description
        @price = price
        @booking_date = booking_date
        @id = id
    end 

    attr_reader :name, :description, :price, :booking_date, :id
end 