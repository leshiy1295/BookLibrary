class Bibl < ActiveRecord::Base
	validates_presence_of :title, :source, :publisher, :format
end
