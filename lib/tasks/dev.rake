namespace :dev do
  desc "Update ubike data"
  task ubike: :environment do
    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"
    response = RestClient.get(url)
    raw_data = JSON.parse(response)
    raw_data["result"]["results"].each do |u|
      existing_ubike = UbikeStation.find_by_iid(u["iid"])
      if existing_ubike
        puts "Update #{existing_ubike.iid} data"
        existing_ubike.update(
          :station => u["sna"],
          :description => u["ar"],
          :number_of_bikes => u["sbi"]
        )
      else
        puts "Create new data"
        UbikeStation.create(
          :iid => u["iid"],
          :station => u["sna"],
          :description => u["ar"],
          :number_of_bikes => u["sbi"]
        )
      end
    end
  end

end