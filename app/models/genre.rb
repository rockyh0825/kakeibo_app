class Genre < ApplicationRecord
    has_many :outgos
    belongs_to :user
end
