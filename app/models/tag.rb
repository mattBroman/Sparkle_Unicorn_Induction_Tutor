class Tag < ApplicationRecord
    has_and_belongs_to_many :questions
    has_and_belongs_to_many :sections
    belongs_to :user
end
