require 'rubygems'
require 'couchrest'
require 'yaml'

# setup the server & database
@server = CouchRest.new("http://127.0.0.1:5984")
@db = @server.database('ember-guides-test')
@db.delete! rescue nil
@db = @server.create_db('ember-guides-test')

# import the table of contents
@pages = YAML.load_file('data/pages.yml')

# grabs the content from the markdown files
def get_content(file_path)
  puts "getting markdown for: #{file_path}.md\n\n"
  file = File.open("data/pages/#{file_path}.md", "r")
  return file.read
end

# pushes the page to couchdb
def import_page(page, parent_slug=nil)
  @db.save_doc({
    :title => page['title'],
    :version => ARGV[0],
    :language => 'en-us',
    :path => "#{parent_slug}/#{page['url']}",
    :text => get_content("#{parent_slug}/#{page['url']}"),
  })
  puts "saving #{page.inspect} to couchdb...\n"
end

# loop through all the pages
@pages.each do |page|
  # index is a snowflake
  if page['url'] == 'index'
    import_page(page)
  else
    page['pages'].each do |subpage|
      if !subpage['url'].empty?
        import_page(subpage, page['url'])
      end
    end
  end
end
