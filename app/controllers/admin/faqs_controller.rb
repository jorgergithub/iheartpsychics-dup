class Admin::FaqsController < AuthorizedController
  before_action :find_faq

  def index
    @faqs = Faq.all
  end

  def new
    @faq = Faq.new
  end

  def edit
  end

  def create
    @faq = Faq.new(faq_params)
    if @faq.save
      redirect_to admin_faqs_path, notice: "FAQ was successfully created."
    else
      render action: "edit"
    end
  end

  def update
    if @faq.update_attributes(faq_params)
      redirect_to admin_faqs_path, notice: "FAQ was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @faq.destroy

    redirect_to admin_faqs_path, notice: 'FAQ was successfully deleted.'
  end

  protected

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end

  def find_faq
    @faq = Faq.find(params[:id]) if params[:id]
  end
end
