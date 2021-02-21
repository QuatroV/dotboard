class Post < ApplicationRecord
    validates :title, :body, :author_id,  presence: true
    paginates_per 5
end
