class RoomCategory < ApplicationRecord
  belongs_to :property

  # Serialize array fields as JSON (Rails 8.0 syntax)
  serialize :comfort_amenities, type: Array, coder: JSON
  serialize :convenience_features, type: Array, coder: JSON

  validates :name, presence: true
  validates :normal_price, presence: true

  # Ensure amenities are handled correctly
  before_save :ensure_arrays_are_arrays
  before_save :set_current_price

  # Default values for arrays if nil
  after_initialize :set_default_values

  # Scopes
  scope :with_pool, -> { where(has_pool: true) }
  scope :with_beach_access, -> { where(has_beach_access: true) }
  scope :with_ocean_view, -> { where(has_ocean_view: true) }

  # Helper methods
  def display_size
    if size_sqm.present? && size_sqft.present?
      "#{size_sqm} sq.m / #{size_sqft} sq.ft"
    elsif size_sqm.present?
      "#{size_sqm} sq.m"
    elsif size_sqft.present?
      "#{size_sqft} sq.ft"
    else
      nil
    end
  end

  def max_occupancy
    (max_adults || 0) + (max_children || 0)
  end

  def display_occupancy
    result = []
    result << "#{max_adults} adults" if max_adults.to_i > 0
    result << "#{max_children} children" if max_children.to_i > 0
    result.join(" and ")
  end

  private

  def set_current_price
    self.current_price = discounted_price.presence || normal_price
  end

  def set_default_values
    self.comfort_amenities ||= []
    self.convenience_features ||= []
  end

  def ensure_arrays_are_arrays
    # Ensure comfort_amenities is always an array
    if comfort_amenities.is_a?(String)
      if comfort_amenities.start_with?("[") && comfort_amenities.end_with?("]")
        begin
          self.comfort_amenities = JSON.parse(comfort_amenities)
        rescue JSON::ParserError
          self.comfort_amenities = [ comfort_amenities ]
        end
      elsif comfort_amenities.present?
        self.comfort_amenities = [ comfort_amenities ]
      else
        self.comfort_amenities = []
      end
    elsif !comfort_amenities.is_a?(Array)
      self.comfort_amenities = []
    end

    # Ensure convenience_features is always an array
    if convenience_features.is_a?(String)
      if convenience_features.start_with?("[") && convenience_features.end_with?("]")
        begin
          self.convenience_features = JSON.parse(convenience_features)
        rescue JSON::ParserError
          self.convenience_features = [ convenience_features ]
        end
      elsif convenience_features.present?
        self.convenience_features = [ convenience_features ]
      else
        self.convenience_features = []
      end
    elsif !convenience_features.is_a?(Array)
      self.convenience_features = []
    end

    # Filter out any empty or nil values
    self.comfort_amenities = comfort_amenities.compact.reject(&:blank?)
    self.convenience_features = convenience_features.compact.reject(&:blank?)
  end
end
