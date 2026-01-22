class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
    @popular_properties = Property.order(created_at: :desc).limit(4)
    @related_stories = Story.where.not(id: @story.id).limit(3)
    @story_tags = @story.tags.presence || Tag.where(name: [ "Travel", "Maldives", "Holiday", "Beach", "Luxury" ]).limit(5)
    
    # Set up meta tags for social sharing
    set_story_meta_tags
  end

  private

  def set_story_meta_tags
    # Set the page title
    @page_title = @story.title
    
    # Set description from story content (first 160 characters)
    @page_description = ActionController::Base.helpers.strip_tags(@story.content.to_s).truncate(160)
    
    # Set OG type for articles
    @og_type = 'article'
    
    # Set OG image - use story image if available, otherwise default logo
    @og_image = if @story.image.attached?
      # Generate full URL for the story image
      url_for(@story.image)
    else
      # Use absolute URL for the logo
      request.base_url + asset_path('logo.png')
    end
    
    # Set story-specific keywords
    story_keywords = @story.tags.pluck(:name).join(', ')
    @page_keywords = "#{story_keywords}, Maldives travel, vacation stories, travel blog"
  end
end
