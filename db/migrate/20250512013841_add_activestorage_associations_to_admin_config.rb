class AddActivestorageAssociationsToAdminConfig < ActiveRecord::Migration[8.0]
  # This migration doesn't actually change the database schema,
  # but we're using it to indicate that we're adding has_one_attached
  # associations to the AdminConfig model:
  # - about_image
  # - hero_image
  # - middle_image
  def up
    # These are added to the model, not the database
  end

  def down
    # No database changes to revert
  end
end
