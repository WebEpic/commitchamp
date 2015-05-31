$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'

module Commitchamp
  class App
    def initialize
      @github = Github.new
    end

    def prompt(token_request, valid_token)
      puts token_request
      input = gets.chomp
      until input =~ valid_token
        puts "Thats not a valid token."
        puts token_request
        input = gets.chomp
      end
      input
    end

    def valid_token_request
      # not sure how to define a valid token here.
      access_token = prompt("Please enter an access token:,(regex)")
      contributors_data = @github.get_contributions(owner, repo, page=1)

    end

  end
end

# app = Commitchamp::App.new
# binding.pry
