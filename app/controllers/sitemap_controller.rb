class SitemapController < ApplicationController
  def index
    respond_to do |format|
      format.xml do
        @properties = Property.all
        @stories = Story.all
        render layout: false
      end
    end
  end
end
