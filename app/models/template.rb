class Template < ApplicationRecord
  validates :name, :content, presence: true
  validates :name, length: { maximum: 200 }
  validates :content, length: { maximum: 1_000_000 }
end
