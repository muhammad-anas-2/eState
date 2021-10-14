class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :is_authenticated, only: [:create, :confirm]
  before_action :set_class_attributes
  # before_action :set_resource, only: [:update]

  def create
    @resource = User.new resource_params
    @resource.otp_token = "0000" #need to work on it and sms this code to customer
    if @resource.save
      @resource
    else
      render :json => { success: false, errors:  @user.errors.full_messages.to_sentence}, status: 400
    end
  end

  def confirm
    @resource = User.find_by(otp_token: params[:token], id: params[:id])
    if @resource.present?
      @resource.update!(otp_confirmed_at: Time.now)
      @session = @resource.sessions.create(api_token: SecureRandom.hex(32), active: true)
      sign_in @resource
      @resource
    else
      render json: { success: false, errors: "Opss, Invalid token" }, status: 401
    end
  end

  def update
    if @user.update(resource_params)
      @user.cnic_front.attach(data: params[:user][:cnic_front][:data]) if params[:user][:cnic_front].present?
      @user.cnic_back.attach(data: params[:user][:cnic_back][:data]) if params[:user][:cnic_back].present?
      @user
    else
      render :json => { success: false, errors:  @user.errors.full_messages.to_sentence }, status: 400
    end
  end

  private

  def set_class_attributes
    set_resource_class_attributes(User)
  end

  def set_params_attributes
    set_resource_params_attributes resource_params
  end



  def resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :password, :password_confirmation,
                                 :address_attributes => [:id, :street_address, :city, :state, :zip, :country, :country_code] ,
                                  :bank_account_attributes => [:id, :branch_code, :bank_id, :account_number])
  end
end
