class User < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sessions, foreign_key: "user_id", class_name: 'Token', dependent: :destroy
  has_one :address, foreign_key: "user_id", class_name: 'Address', inverse_of: 'user',  dependent: :destroy
  has_one :bank_account, class_name: 'UserBankAccount', foreign_key: "user_id", inverse_of: 'user', dependent: :destroy
  has_one_base64_attached :cnic_front
  has_one_base64_attached :cnic_back
  has_one :cnic_front_attachment, -> { where(name: "cnic_front") }, class_name: "ActiveStorage::Attachment", as: :record, inverse_of: :record, dependent: :destroy
  has_one :cnic_front_blob, through: :cnic_front_attachment, class_name: "ActiveStorage::Blob", source: :blob
  has_one :cnic_back_attachment, -> { where(name: "cnic_back") }, class_name: "ActiveStorage::Attachment", as: :record, inverse_of: :record, dependent: :destroy
  has_one :cnic_back_blob, through: :cnic_back_attachment, class_name: "ActiveStorage::Blob", source: :blob

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :bank_account, allow_destroy: true

  def self.is_valid_user(email, password)
    @user = User.find_by(email: email)
    (@user.present? and @user.valid_password?(password)) ? @user : nil
  end

  def image_url type
    image = (type == "cnic_front" ? self.cnic_front : self.cnic_back)
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(
          image,
          Rails.application.config.action_mailer.default_url_options
      )
    else
      return nil
    end
  end

end
