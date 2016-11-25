class FilesController < ApplicationController
  before_action :require_signin!

  def show
    asset = Asset.find params[:id]
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path, filename: asset.asset_identifier, content_type: asset.content_type
    else
      flash[:alert] = 'You are not authorized to view the asset'
      redirect_to root_path
    end
  end
end
