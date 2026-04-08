class SitemapController < ApplicationController
  def index
    @properties = Property.all
    @stories = Story.all

    respond_to do |format|
      format.xml {
        response.headers["Content-Type"] = "application/xml; charset=utf-8"
        render layout: false
      }
    end
  end
end
