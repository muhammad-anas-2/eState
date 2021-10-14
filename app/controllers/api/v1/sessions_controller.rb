class Api::V1::SessionsController < Api::V1::BaseController
  before_action :is_authenticated, only: [:destroy]

  def create
    @user = User.is_valid_user(params[:email], params[:password])
    if @user.present?
      @session = @user.sessions.create(api_token: SecureRandom.hex(32), active: true)
      sign_in @user
    else
      render json: { success: false, errors: "Email/Password is incorrect." }, :status => 404
    end
  end

  def destroy
    sign_out @user
    if @session.update!(expired_at: DateTime.now, active: false)
      render :json => { success: true, message: "You've logged out successfully" }, status: 200
    else
      render :json => {success: false, errors: @session.errors.full_messages.to_sentence}, status: 400
    end
  end
end