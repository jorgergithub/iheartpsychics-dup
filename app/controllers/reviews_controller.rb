class ReviewsController < AuthorizedController
  before_filter :find_review

  def mark_as_featured
    if @review.mark_as_featured!
      redirect_to edit_psychic_path, notice: "Review successfully marked as featured."
    else
      redirect_to :back, error: "Could not mark as featured."
    end
  end

  def unmark_as_featured
    if @review.unmark_as_featured!
      redirect_to edit_psychic_path, notice: "Review successfully unmarked as featured."
    else
      redirect_to :back, error: "Could not unmark as featured."
    end
  end

  protected

  def find_review
    redirect_to :root unless current_psychic

    @review = current_psychic.reviews.find(params[:id])
  end
end
