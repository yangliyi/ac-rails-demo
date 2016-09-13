require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /api/v1/events/:id" do

    before do
      @event = Event.create(:name => "xxx", :description => "yyy")
    end

    it "should have 200 status code" do
      data = JSON.parse(@event.to_json)
      byebug
      get "/api/v1/events/#{@event.id}"

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)
    end
  end

  describe "POST /api/v1/events" do

    it "should succefully create new event" do

      params = {:name => "xxx", :description => "yyy"}
      post "/api/v1/events", :params => params

      expect(response).to have_http_status(200)
      expect(Event.count).to eq(1)
    end
  end
end
