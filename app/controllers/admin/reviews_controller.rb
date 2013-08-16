class Admin::ReviewsController < AuthorizedController
  before_action :find_review

  def show
  end

  protected

  def find_review
    @review = Review.find(params[:id]) if params[:id]
  end
end
