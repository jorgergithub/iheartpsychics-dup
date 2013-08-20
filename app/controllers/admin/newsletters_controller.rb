class Admin::NewslettersController < AuthorizedController
  before_action :find_newsletter

  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def update
    if @newsletter.update_attributes(newsletter_params)
      redirect_to admin_newsletters_path, notice: "Newsletter was successfully updated."
    else
      render action: "edit"
    end
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      redirect_to admin_newsletters_path, notice: "Newsletter was successfully created."
    else
      render action: "edit"
    end
  end

  def destroy
    @newsletter.destroy

    redirect_to admin_newsletters_path, notice: 'Newsletter was successfully deleted.'
  end

  protected

  def newsletter_params
    params.require(:newsletter).permit(:title, :body, :deliver_by)
  end

  def find_newsletter
    @newsletter = Newsletter.find(params[:id]) if params[:id]
  end
end
