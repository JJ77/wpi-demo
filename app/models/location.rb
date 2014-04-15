class Location < ActiveRecord::Base
	has_many :greenhouses
	has_many :beds
end
