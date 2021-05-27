class Management::AdminsController < ManagementController
 before_action :set_admin, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: :new
  after_action :verify_policy_scoped, only: :index

  def index
    all_categories
    #@admins = Admin.all
    #@admins = Admin.where(role: 'restricted_access')
    #@admins = Admin.with_restricted_access
    @admins = policy_scope(Admin)
  end

  def new
    all_categories
    @admin = Admin.new
    authorize @admin
  end

  def create
    all_categories
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to management_admins_path, notice: "Administrador (#{@admin.email}) adicionado com sucesso"
    else
      render :new, notice: "Erro ao cadastrar o Administrador (#{@admin.email}), tente novamente."
    end
  end

  def edit
    all_categories
  end

  def update
    all_categories

    psw = params[:admin][:password]
    psw_confirmation = params[:admin][:password_confirmation]

    if psw.blank? && psw_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end


    if @admin.update(params_admin)
      redirect_to management_admins_path, notice: "Administrador (#{@admin.email}) atualizado com sucesso"
    else
      render :edit, notice: "Erro ao atualizar o Administrador (#{@admin.email}), tente novamente."
    end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
      redirect_to management_admins_path, notice: "Administrador (#{admin_email}) excluído com sucesso"
    else
      render :index, notice: "Erro ao deletar o usuário (#{admin_email}) "
    end
  end

  private
    
    def all_categories
      @categories = Category.all
    end

    
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def params_admin
      params.require(:admin).permit(:email, :name, :password, :password_confirmation)
    end

end
