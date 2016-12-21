class Genre < ActiveRecord::Base
  include SlugifiableInstanceMethods
  extend SlugifiableClassMethods

  has_many :artists, through: :songs
  has_many :songs, through: :song_genres
  has_many :song_genres
end
