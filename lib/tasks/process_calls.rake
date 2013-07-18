namespace :calls do
  desc "Download call information from Twilio"
  task :process => :environment do
    ClientCall.process_calls
  end
end
