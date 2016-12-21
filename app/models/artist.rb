class Artist < ActiveRecord::Base
  include SlugifiableInstanceMethods
  extend SlugifiableClassMethods

  has_many :songs
  has_many :genres, through: :songs
end
