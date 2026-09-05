require "zip"

class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :require_active_member, only: %i[show new create edit update destroy]
  before_action :set_property, only: %i[show edit update destroy download_documents]

  def index
    scope = if current_user&.admin?
              Property.all
            elsif current_user
              Property.approved.or(Property.where(user: current_user))
            else
              Property.approved
            end

    @property_types = scope.where.not(property_type: [nil, ""]).distinct.order(:property_type).pluck(:property_type)

    if params[:q].present?
      query = "%#{ActiveRecord::Base.sanitize_sql_like(params[:q].strip)}%"
      scope = scope.where("title LIKE :query OR location LIKE :query", query: query)
    end

    scope = scope.where(property_type: params[:property_type]) if params[:property_type].present?
    scope = scope.where("price >= ?", params[:min_price]) if params[:min_price].present?
    scope = scope.where("price <= ?", params[:max_price]) if params[:max_price].present?

    @properties = scope.order(created_at: :desc)
  end

  def show
    @has_paid = current_user.admin? ||
                @property.user_id == current_user.id ||
                current_user.property_payments.exists?(property: @property, payment_status: "paid")
  end

  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)
    attach_uploaded_files

    if @property.save
      redirect_to @property, notice: "Property submitted successfully and is awaiting verification."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_property_owner!
  end

  def update
    authorize_property_owner!
    @property.assign_attributes(property_params)
    attach_uploaded_files

    if @property.save
      redirect_to @property, notice: "Property updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_property_owner!
    @property.destroy!
    redirect_to properties_path, notice: "Property deleted."
  end

  def download_documents
    unless @property.user_id == current_user.id || current_user.admin? ||
           current_user.property_payments.exists?(property: @property, payment_status: "paid")
      return redirect_to property_path(@property), alert: "Please pay to access the verified documents."
    end

    files = [
      @property.title_document_files,
      @property.mutation_document_files,
      @property.aksfard_document_files,
      @property.court_case_document_files,
      @property.supporting_documents
    ].flat_map(&:to_a)

    return redirect_to(property_path(@property), alert: "No documents are available yet.") if files.empty?

    zip = Zip::OutputStream.write_buffer do |zos|
      used_names = Hash.new(0)

      files.each do |file|
        base_name = file.filename.to_s
        used_names[base_name] += 1
        filename = used_names[base_name] == 1 ? base_name : "#{File.basename(base_name, ".*")}-#{used_names[base_name]}#{File.extname(base_name)}"
        zos.put_next_entry(filename)
        zos.write(file.download)
      end
    end

    zip.rewind
    send_data zip.read,
              filename: "property-#{@property.id}-documents.zip",
              type: "application/zip"
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def authorize_property_owner!
    return if current_user.admin? || @property.user_id == current_user.id

    redirect_to property_path(@property), alert: "You are not authorized to modify this property."
  end

  def file_field_keys
    %i[
      images main_image thumbnail
      title_document_files mutation_document_files
      aksfard_document_files court_case_document_files supporting_documents
    ]
  end

  def property_params
    allowed = params.require(:property).permit(
      :title, :description, :property_type, :subtype, :location, :price,
      :dispute_status, :dispute_summary, :ownership_type, :total_area,
      :jamabandi_year, :boundaries, :main_image, :thumbnail,
      images: [], title_document_files: [], mutation_document_files: [],
      aksfard_document_files: [], court_case_document_files: [],
      supporting_documents: []
    )

    if current_user.admin?
      allowed = params.require(:property).permit(
        :title, :description, :property_type, :subtype, :location, :price,
        :dispute_status, :dispute_summary, :ownership_type, :total_area,
        :jamabandi_year, :boundaries, :status, :approved, :featured,
        :main_image, :thumbnail, images: [], title_document_files: [],
        mutation_document_files: [], aksfard_document_files: [],
        court_case_document_files: [], supporting_documents: []
      )
    end

    allowed
  end

  def attach_uploaded_files
    file_field_keys.each do |field|
      uploads = Array(params.dig(:property, field)).compact
      uploads.each do |file|
        @property.public_send(field).attach(file)
      end
    end
  end
end
