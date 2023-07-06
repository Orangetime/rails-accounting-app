class CompensationRequestsController < ApplicationController
  def index
    @compensation_requests = CompensationRequest.all
  end

  def show
    @compensation_request = CompensationRequest.find(params[:id])
  end

  def new
    @compensation_request = CompensationRequest.new
  end

  def edit
  end

  def create
    @compensation_request = CompensationRequest.new(permitted_params)
    @compensation_request.user = current_user
    @compensation_request.status = :pending

    if @compensation_request.save!
      redirect_to compensation_request_url(@compensation_request), notice: ["Compensation request was successfully created."]

      CompensationRequestMailer.with(user: current_user, compensation_request: @compensation_request).send_email.deliver_later
    else
      render :new, status: :unprocessable_entity
    end
  end

  def approve
    @compensation_request = CompensationRequest.find(params[:id])
    @compensation_request.update!(status: 'approved')
  end


  private
    def permitted_params
      params.require(:compensation_request).permit(:amount, :reason, :currency)
    end
end