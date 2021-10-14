class Api::V1::PostsController < Api::V1::BaseController

  def index
    status = params[:status] || "active"
    @resources = PropertyPost.where(status: status)
                     .paginate(page: params[:page])
                     .order('created_at DESC')
  end

end