class Property < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :consultation_requests, dependent: :destroy
  has_many :property_payments, dependent: :destroy

  has_many_attached :images
  has_one_attached :main_image
  has_one_attached :thumbnail

  has_many_attached :title_document_files
  has_many_attached :mutation_document_files
  has_many_attached :aksfard_document_files
  has_many_attached :court_case_document_files
  has_many_attached :supporting_documents

  validates :title, :property_type, :location, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  with_options if: :document_validation_required? do
    validates :title_document_files, presence: { message: "must be attached" }
    validates :mutation_document_files, presence: { message: "must be attached" }
    validates :aksfard_document_files, presence: { message: "must be attached" }
    validates :court_case_document_files, presence: { message: "must be attached" }
  end

  scope :featured, -> { where(featured: true) }
  scope :approved, -> { where(approved: true) }

  def images_table_records
    Image.where(property_id: id)
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user consultation_requests]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id user_id title description property_type subtype location price dispute_status
      dispute_summary status approved ownership_type total_area jamabandi_year boundaries
      featured created_at updated_at
    ]
  end

  private

  def document_validation_required?
    new_record? || will_save_change_to_user_id?
  end
end
