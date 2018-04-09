

class Question < ApplicationRecord
    validates_presence_of :title, :p_k, :implies, :val, :difficulty
    has_and_belongs_to_many :tags
    belongs_to :user
end
