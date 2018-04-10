class User < ApplicationRecord
    has_many :questions
    has_many :tags
    has_and_belongs_to_many :sections
end
