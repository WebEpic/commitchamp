$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'

module Commitchamp
  class App
    def initialize
      if OAUTH_TOKEN == nil
        prompt
      end
      @github = Github.new
    end

    def prompt(message)
      puts "Please enter a valid GitHub access token:"
      OAUTH_TOKEN = gets.chomp
    end

    def import_contributors(repo_name)
      repo = Repo.first_or_create(name: repo_name)
      results = @github.get_contributions('WebEpic', repo_name)
      results.each do |contribution|
        user = User.first_or_create(name: contribution['author']['login'])
        lines_added = contribution['weeks'].map { |x| x['a'] }.sum
        lines_deleted = contribution['weeks'].map { |x| x['d'] }.sum
        commits_made = contribution['weeks'].map { |x| x['c'] }.sum

        user.contributions.create(lines_added: lines_added, 
                                  lines_deleted: lines_deleted, 
                                  commits_made: commits_made, 
                                  repo_id: repo.id)
      end
    end
  end
end

# def prompt(token_request, valid_token)
#   puts token_request
#   input = gets.chomp
#   until input =~ valid_token
#     puts "Thats not a valid token."
#     puts token_request
#     input = gets.chomp
#   end
#   input
# end

# def valid_token_request
#   # not sure how to define a valid token here.
#   token_request = prompt("Please enter an access token:,(regex)")
#   contributors_data = @github.get_contributions(owner, repo, page=1)

# end

# app = Commitchamp::App.new
# binding.pry
