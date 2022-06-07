class SpaceUserEntity
    def initialize(email, id=nil)
        @email = email
        @id = id
    end 

    attr_reader :email, :id
end 