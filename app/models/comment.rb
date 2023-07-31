class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  validates :body, presence: true, length: { minimum: 7 }
end
