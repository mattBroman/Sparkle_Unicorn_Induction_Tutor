

class Question < ApplicationRecord
    validates_presence_of :title, :p_k, :implies, :val, :difficulty
end
