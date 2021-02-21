class Comment < ApplicationRecord
    validates :body,:author_id, presence: true
end
