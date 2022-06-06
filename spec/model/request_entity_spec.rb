require "request_entity"

RSpec.describe RequestEntity do
    it "creates request and returns the ids" do
        request_entity = RequestEntity.new(1,2,3)
        expect(request_entity.space_id).to eq 1
        expect(request_entity.requester_id).to eq 2
        expect(request_entity.owner_id).to eq 3
    end 
end 