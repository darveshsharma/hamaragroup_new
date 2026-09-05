class Document < ApplicationRecord
  has_one_attached :supporting_document
  belongs_to :property
  validates :document_type, :file_url, presence: true

end
