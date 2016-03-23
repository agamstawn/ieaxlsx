class Comment < ActiveRecord::Base
  belongs_to :article
  validates :content,
    presence: true
  def to_s
    content
  end
end
