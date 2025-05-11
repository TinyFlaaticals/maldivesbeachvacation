class PropertyPopularFilter < ApplicationRecord
  belongs_to :property
  belongs_to :popular_filter
end
