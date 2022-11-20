# app/models/author.rb
class Author < ApplicationRecord
    has_many :articles
end