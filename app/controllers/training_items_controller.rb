class TrainingItemsController < AuthorizedController
  layout "main"

  def index
    @training_items = TrainingItem.all
  end

  def show
    @training_item = TrainingItem.find(params[:id])
    if @training_item.file
      @training_item.reviewed!
      redirect_to @training_item.file
    end
  end
end
