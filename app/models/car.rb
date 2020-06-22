class Car < ActiveRecord::Base

    belongs_to :user
    has_many :parts

    validates :year, :make, :model, :color, presence: true
    
end