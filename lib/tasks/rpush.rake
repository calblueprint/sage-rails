task :rpush => :environment do
  puts "Initializing GCM..."

  unless Rpush::Gcm::App.find_by_name(ENV["GCM_NAME"])
    app = Rpush::Gcm::App.new
    app.name = ENV["GCM_NAME"]
    app.auth_key = ENV["GCM_API_KEY"]
    app.connections = 1
    app.save!
  end

  puts "Successfully initialized GCM"

  puts "Initializing APNS..."

  unless Rpush::Apns::App.find_by_name(ENV["APNS_NAME"])
    app = Rpush::Apns::App.new
    app.name = ENV["APNS_NAME"]
    app.certificate = File.read(ENV["APNS_PEM"])
    app.environment = "production" # APNs environment.
    app.password = ENV["APNS_PASSWORD"]
    app.connections = 1
    app.save!
  end

  puts "Successfully initialized APNS"
end
