class Api::V1::BanksController < Api::V1::BaseController
  skip_before_action :is_authenticated, only: [:index]

  def index
    @resources = Bank.all
    render :json => { success: true, data: @resources }, status: 200
  end

end