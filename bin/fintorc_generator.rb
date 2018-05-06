#!/usr/bin/env ruby
# TODO command line parameters to overwrite ~/.fintorc file
require 'json'
require 'optparse'
accounts_file = "all_accounts.json"
accounts_url = "s3://bamazon-accounts/#{accounts_file}"
fintorc_file = "#{Dir.home}/.fintorc"
team_role = ARGV[0]

options = {:default_account=>'mlbam'}

OptionParser.new do |opts|
  opts.on("-t TEAM_ROLE", "team role") do |t|
    options[:team_role] = t
  end
  opts.on("-d [DEFAULT_ACCOUNT]", "default account") do |d|
    options[:default_account] = d if d
  end
  opts.on("-h", "--help", "help") do |d|
    options[:help] = d
  end
end.parse!

def usage
  puts "Usage: #{$0} -t bamazon-<TeamRole> [-d default_account]"
  puts "Example: #{$0} -t bamazon-TeamFED -d mlbam"
  exit
end

if !options[:team_role] || options[:help]
  usage
end

# prefer not to require sdk for this script, running shell cmd
unless system("aws s3 cp s3://bamazon-accounts/all_accounts.json .")
  puts "ERROR downloading accounts json from s3."
  puts "... Ensure you are running with credentials set for the mlbam identity acct"
  exit
end

fintorc_hash = { 
    "credentials" => {
        "profile" => "identity"
    },
    "default_role" => "#{options[:default_account]}",
    "roles" => { }
}

accounts_hash = JSON.parse(File.read(accounts_file))

accounts_hash["accounts"].each do | account |
    role = "#{account['namespace']}#{"-"+account['team']if account['team']}#{"-"+account['name']if account['name']}"
    fintorc_hash["roles"][role] = "arn:aws:iam::#{account['number']}:role/#{options[:team_role]}"
end

File.write(fintorc_file, JSON.pretty_generate(fintorc_hash))
File.delete(accounts_file)
puts "Wrote #{fintorc_file}"
