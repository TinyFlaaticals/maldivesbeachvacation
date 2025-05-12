class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @popular_properties = Property.order(created_at: :desc).limit(4)
    @related_stories = Story.where.not(id: @story.id).limit(3)
    @story_tags = @story.tags.presence || Tag.where(name: ['Travel', 'Maldives', 'Holiday', 'Beach', 'Luxury']).limit(5)
  end
end
