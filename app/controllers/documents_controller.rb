class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property
  before_action :authorize_property_access!
  before_action :set_document, only: :destroy

  def create
    @document = @property.documents.build(document_params)

    if @document.save
      redirect_to @property, notice: "Document uploaded successfully."
    else
      redirect_to @property, alert: @document.errors.full_messages.to_sentence
    end
  end

  def destroy
    @document.destroy!
    redirect_to @property, notice: "Document deleted."
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def set_document
    @document = @property.documents.find(params[:id])
  end

  def authorize_property_access!
    return if current_user.admin? || @property.user_id == current_user.id

    redirect_to properties_path, alert: "You are not authorized to manage this property."
  end

  def document_params
    params.require(:document).permit(:document_type, :file_url)
  end
end
