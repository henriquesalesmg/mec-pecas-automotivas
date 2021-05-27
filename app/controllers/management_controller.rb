class ManagementController < ApplicationController

  before_action :authenticate_admin!

  layout "management"

  def pundit_user
    current_admin # current_user to Pundit
  end
end