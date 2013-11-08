desc 'Run the app'
task :s do
  system "rackup -p 4567"
end

desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
  uri = URI.parse('http://wedding.scottandalanna.com')
  Net::HTTP.get(uri)
end

