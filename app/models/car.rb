class Car < ActiveRecord::Base

    belongs_to :user

    validates :year, :make, :model, :color, :parts, presence: true
    
end