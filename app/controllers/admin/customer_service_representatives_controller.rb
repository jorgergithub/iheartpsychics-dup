class Admin::CustomerServiceRepresentativesController < AuthorizedController
  before_filter :find_csr

  def index
    @csrs = CustomerServiceRepresentative.includes(:user)
      .order("users.first_name, users.last_name")
      .page(params[:page]).per(params[:per])
  end

  def new
    @user = User.new
    @csr = @user.build_rep
    @csr.user = @user
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params.merge({ create_as: "csr" }))
      @user.localized.update_attributes(user_params)

      @csr = @user.build_rep(csr_params)
      @csr.localized.update_attributes(csr_params)
      @csr.user = @user

      @user.skip_confirmation!

      if @user.save #and @csr.save
        redirect_to admin_customer_service_representatives_path,
          notice: "CSR was successfully created."
      else
        @errors = [@user.errors.full_messages, @csr.errors.full_messages].flatten
        render action: "edit"
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @user = @csr.user
      if @user.update_attributes(user_params)
        if @csr.localized.update_attributes(csr_params)
          redirect_to admin_customer_service_representatives_path,
            notice: "CSR was successfully updated."
        else
          @errors = [@user.errors.full_messages, @csr.errors.full_messages].flatten
          render action: "edit"
        end
      else
        @errors = [@user.errors.full_messages, @csr.errors.full_messages].flatten
        render action: "edit"
      end
    end
  end

  protected

  def find_csr
    @csr = CustomerServiceRepresentative.find(params[:id]).localized if params[:id]
  end

  def user_params
    params.require(:customer_service_representative).permit(:first_name, :last_name, :username, :email, :password)
  end

  def csr_params
    params.require(:customer_service_representative).permit(:phone)
  end
end
