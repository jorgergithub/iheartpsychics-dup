class Admin::PackagesController < AuthorizedController
  before_filter :find_package

  def index
    @packages = Package.all
  end

  def new
    @package = Package.new
  end

  def edit
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      redirect_to admin_packages_path, notice: "New package was successfully created."
    else
      render action: "show"
    end
  end

  def update
    if @package.update_attributes(package_params)
      redirect_to admin_packages_path, notice: "Package was successfully updated."
    else
      render action: "show"
    end
  end

  protected

  def find_package
    @package = Package.find(params[:id]) if params[:id]
  end

  def package_params
    params.require(:package).permit(:name, :minutes, :price, :phone)
  end
end
