class PropertyPost < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  self.per_page = 20
  enum property_type: [:residential, :commercial]
  enum status: [:active, :sold]
  enum facing: [:north, :south, :west, :east]

  validates_presence_of :property_type, message: "(property type) must be present"
  validates_presence_of :address, message: "address must be present"

  has_many_base64_attached :visuals
  has_many :visuals_attachment, -> { where(name: "visuals") }, class_name: "ActiveStorage::Attachment", as: :record, inverse_of: :record, dependent: :destroy
  has_many :visuals_blob, through: :visuals_attachment, class_name: "ActiveStorage::Blob", source: :blob

  def visual_urls
    if self.visuals.attached?
      urls = self.visuals.map do |file|
        url =  Rails.application.routes.url_helpers.rails_blob_url(
            file,
            Rails.application.config.action_mailer.default_url_options, disposition: "attachment"
        )
        {visual: url, visual_name: file.blob.filename, visual_id: file.id}
      end
    else
      return []
    end
  end

end
