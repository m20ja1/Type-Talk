class Admin::ApplicationController < ActionController::Base
  include AdminAuthentication
  
  before_action :authenticate_admin!
  layout "admin"
end