module CommitChamp
  class User < ActiveRecord::Base
    has_many :contributions
  end
end