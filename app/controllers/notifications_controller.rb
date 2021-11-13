# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index; end

  def create
    Notification.create!(user_id: params[:user_id], friendship_id: params[:friendship_id])
    redirect_to users_path
  end
end
