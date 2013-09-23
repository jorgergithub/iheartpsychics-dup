class Admin::WebsiteAdminsController < AuthorizedController
  before_filter :find_website_admin

  def index
    @website_admins = WebsiteAdmin.website_admins
      .order("users.first_name, users.last_name")
      .page(params[:page]).per(params[:per])
  end

  def new
    @website_admin = WebsiteAdmin.new(create_as: "website_admin")
  end

  def edit
  end

  def create
    params = website_admin_params.merge(create_as: "website_admin")
    @website_admin = WebsiteAdmin.new(params)
    @website_admin.skip_confirmation!
    if @website_admin.save
      redirect_to admin_website_admins_path,
        notice: "New website admin was successfully created."
    else
      render action: "edit"
    end
  end

  def destroy
    @website_admin.destroy
    redirect_to admin_website_admins_path,
      notice: 'Website Admin was successfully deleted.'
  end

  protected

  def find_website_admin
    @website_admin = WebsiteAdmin.find(params[:id]) if params[:id]
  end

  def website_admin_params
    params.require(:website_admin).permit(:first_name, :last_name, :username,
                                             :email, :password)
  end
end
