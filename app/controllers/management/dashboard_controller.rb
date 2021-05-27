class Management::DashboardController < ManagementController
  def index
    @categories = Category.all
  end
end
