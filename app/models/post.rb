class Post < ApplicationRecord
    validates :title, :body, :author_id,  presence: true
    has_many :comments
    paginates_per 5
end
