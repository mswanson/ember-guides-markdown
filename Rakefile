namespace :couch do
  desc "Imports a version of the Guides into CouchDB"
  task :import, [:version] do |t, args|
    puts "importing version #{args.version} into couchdb."
    ruby "lib/import_version.rb '#{args.version}'"
  end
end
