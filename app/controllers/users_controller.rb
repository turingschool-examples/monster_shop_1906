# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def login; end

  def show
    render_404 unless current_user
  end

  def logout; end
end
