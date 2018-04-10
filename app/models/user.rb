class User < ApplicationRecord
    has_many :questions
    has_and_belongs_to_many :sections
end
