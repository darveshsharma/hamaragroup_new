ActiveAdmin.register ConsultationRequest do

  # Remove filters for ActiveStorage attachments to avoid Ransack errors
  remove_filter :mutation_document_attachment
  remove_filter :mutation_document_blob

  # Or define only needed filters
  filter :user
  filter :property
  filter :service_type
  filter :status
  filter :created_at

  # your index, show, form blocks here

end
