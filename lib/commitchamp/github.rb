require 'httparty'

module Commitchamp

  OAUTH_TOKEN = ENV['OAUTH_TOKEN']

  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @headers = { "Authorization" => "token #{OAUTH_TOKEN}",
                   "User-Agent" => "HTTParty" }
    end

    def get_user(username)
      self.class.get("/users/#{username}", headers: @headers)
    end

    def get_contributions(owner, repo)
      self.class.get("/repos/#{owner}/#{repo}/stats/contributors", headers: @headers)
    end
  end
end
