require 'json'
require 'optparse'

class ClientSearch

  def initialize(file)
    @file = file
    @clients = load_clients
  end

  def load_clients
    JSON.parse(File.read(@file))
  end

  def search(query)
    results = @clients.select { |client| client['full_name'].downcase.include?(query.downcase) }

    if results.empty?
      puts "No clients found matching '#{query}'"
    else
      results.each do |client|
        puts "Client ID: #{client['id']}, Full Name: #{client['full_name']} Email: #{client['email']}"
      end
    end
  end

  def find_duplicates
    email_counts = @clients.each_with_object(Hash.new(0)) { |client, counts| counts[client['email']] += 1}
    duplicates = email_counts.select { |_, count| count > 1}.keys

    if duplicates.empty?
      puts "No duplicate emails found."
    else
      puts "Duplicate emails found:"
      duplicates.each do |email|
        puts "Email: #{email}"
        @clients.select { |client| client['email'] == email}.each do |client|
          puts "  Client ID: #{client['id']}, Full Name: #{client['full_name']}"
        end
      end
    end
  end
end

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: client_search.rb [options]"

  opts.on("-f", "--file FILE", "JSON file with client_data") do |file|
    options[:file] = file
  end

  opts.on("-s", "--search QUERY", "Search clients by full name") do |query|
    options[:search] = query
  end

  opts.on("-d", "--duplicates", "Find clients with duplicate emails") do
    options[:duplicates] = true
  end
end.parse!

if options[:file].nil?
  puts "Error: JSON file is required"
  exit
end

client_search = ClientSearch.new(options[:file])

if options[:search]
  client_search.search(options[:search])
elsif options[:duplicates]
  client_search.find_duplicates
else
  puts "No command provided. Use -s to search or -d to find duplicates"
end