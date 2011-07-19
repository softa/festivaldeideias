require 'nokogiri'
require 'open-uri'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  rest_server = 'http://api.facebook.com/restserver.php?method=links.getStats&urls='
  include Rails.application.routes.url_helpers

  # Run task every hour
  puts "Updating likes count for each idea"
  Idea.all.each do |idea|
    idea_url = idea.site.full_url(idea_path(idea))
    puts idea_url
    url = "#{rest_server}#{idea_url}"
    res = Nokogiri::XML(open(url))
    idea.likes = res.search('total_count').children[0].content.to_i
    idea.save
  end
end