require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'time'
require 'yaml'
require 'sanitize'
require 'stringex'

feed_file = "assets/friends_file/rss_feeds.yml"
output_location = "_friends_link"

count = 0
feeds = YAML.load_file(feed_file)
feeds.each do |feeditem|
  feed_url = feeditem["feed"]
  name = feeditem["name"]

  rss = SimpleRSS.parse(open(feed_url))

  rss.items.each do |entry|
    title = entry.title.encode('utf-8', invalid: :replace, undef: :replace, replace: '-').gsub(":", " -")
    body = entry.content_encoded || entry.description
    authors = entry.author || ''
    entry_url = entry.link
    dateadded = Time.new
    date = entry.pubDate || entry.published || entry.updated
    date = dateadded if date.nil?

    filename = "#{output_location}/#{title.to_url}.md"
    description = Sanitize.fragment(entry.description)
    if File.exist?(filename)
      next
    else
      File.open(filename, "w+") do |file|
        file.puts "---"
        file.puts "title: \"#{title}\""
        file.puts "date: #{date}"
        file.puts "dateadded: #{dateadded}"
        file.puts "description: \"#{description}\""
        file.puts "link: \"#{entry_url}\""
        file.puts "category: [#{name}]"
        file.puts "---"
      end

      count += 1
    end
  end  
  puts "added #{count} files from #{name}"
end
