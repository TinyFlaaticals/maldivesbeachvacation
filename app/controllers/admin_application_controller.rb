class AdminApplicationController < ApplicationController
  before_action :authenticate_admin!
end
