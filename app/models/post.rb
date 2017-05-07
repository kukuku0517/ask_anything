class Post < ActiveRecord::Base
     has_and_belongs_to_many :hashtags
     has_many :replys
     belongs_to :user
     
end
