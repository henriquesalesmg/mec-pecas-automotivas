class Management::CategoriesController < ManagementController
  before_action :set_category, only: [:edit, :update]

  def index
    all_categories
  end

  def new
    all_categories
    @category = Category.new
  end

  def create
    all_categories
    @category = CategoryService.create(params_category)

    unless @category.errors.any?
      redirect_to management_categories_path, notice: "Categoria (#{@category.description}) cadastrada com sucesso"
    else
      render :new, notice: "Erro ao cadastrar a categoria (#{@category.description}), tente novamente."
    end
  end

  def edit
    all_categories
  end

  def update
    all_categories
    if @category.update(params_category)
      redirect_to management_categories_path, notice: "Categoria (#{@category.description}) atualizada com sucesso"
    else
      render :edit, notice: "Erro ao atualizar a categoria (#{@category.description}), tente novamente."
    end
  end

  private
    
    def all_categories
      @categories = Category.all
    end

    
    def set_category
      @category = Category.find(params[:id])
    end

    def params_category
      params.require(:category).permit(:description)
    end

end
