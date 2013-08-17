class Admin::NewslettersController < AuthorizedController
  before_action :find_newsletter

  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  protected

  def find_newsletter
    @newsletter = Newsletter.find(params[:id]) if params[:id]
  end
end
