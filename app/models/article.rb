class Article < ActiveRecord::Base
  validates :title, presence:true, length: { minimum: 3, maximum: 40}
  validates :description, presence:true, length: { minimum: 3, maximum: 100}
end
