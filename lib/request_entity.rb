class RequestEntity
    def initialize(space_id,requester_id, owner_id, id = nil)
        @space_id = space_id
        @requester_id = requester_id
        @owner_id = owner_id
    end 
    attr_reader :space_id, :requester_id,:owner_id,:id
end 