class Greenhouse < ActiveRecord::Base
  belongs_to :location
  has_many :beds
end
