class Question < ActiveRecord::Base
  has_and_belongs_to_many :polls
  has_many :answers
  
  has_many :active_polls
end
