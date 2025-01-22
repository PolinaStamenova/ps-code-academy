class SharedController < ApplicationController
  before_action :set_path

  def modal_delete_button
    render partial: 'shared/modal_delete_button', layout: false, locals: { path: @path }
  end

  private

  def set_path
    @path = params[:path]
  end
end
