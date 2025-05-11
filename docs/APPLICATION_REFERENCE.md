# Maldives Beach Vacation Resort Booking Application

## Table of Contents
1. [Technology Stack](#technology-stack)
2. [Application Architecture](#application-architecture)
3. [Frontend Components](#frontend-components)
4. [Backend Components](#backend-components)
5. [Database Structure](#database-structure)
6. [Authentication System](#authentication-system)
7. [Core Features](#core-features)
8. [Admin Interface](#admin-interface)
9. [API Endpoints](#api-endpoints)
10. [Asset Management](#asset-management)
11. [Development Setup](#development-setup)
12. [Nested Forms with Cocoon](#nested-forms-with-cocoon)

## Technology Stack

### Backend
- **Framework**: Ruby on Rails 8.0.0.1
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **WebSocket**: Solid Cable
- **Asset Pipeline**: Propshaft
- **JavaScript Bundling**: jsbundling-rails
- **CSS Bundling**: cssbundling-rails
- **Hotwire**: 
  - Turbo Rails
  - Stimulus Rails

### Frontend
- **CSS Framework**: Tailwind CSS
- **JavaScript Framework**: Stimulus.js
- **Asset Management**: Propshaft
- **Icons**: Heroicons
- **Forms**: Turbo Frames
- **Real-time Updates**: Turbo Streams

### Development Tools
- **Debugging**: debug gem
- **Security**: brakeman
- **Code Style**: rubocop-rails-omakase
- **Console**: web-console
- **Documentation**: annotate

### Production
- **Web Server**: Unicorn
- **Deployment**: Kamal
- **Performance**: Thruster
- **Image Processing**: image_processing

## Application Architecture

### MVC Structure
- **Models**: ActiveRecord-based with rich associations
- **Views**: ERB templates with Tailwind CSS
- **Controllers**: RESTful with Turbo support

### Key Components
1. **Property Management System**
   - Property CRUD operations
   - Image management
   - Room category management
   - Pricing system
   - Search and filter capabilities

2. **Booking System**
   - Reservation management
   - Guest information handling
   - Room allocation
   - Booking confirmation

3. **Content Management**
   - Story/blog management
   - Facility management
   - Activity management
   - Filter management

4. **Admin Interface**
   - Dashboard
   - User management
   - Content management
   - Booking management
   - System configuration

## Frontend Components

### Layouts
1. **Application Layout**
   - Header
   - Footer
   - Navigation
   - Flash messages

2. **Admin Layout**
   - Sidebar navigation
   - Top navigation
   - Content area
   - User menu

3. **Devise Layout**
   - Authentication forms
   - Error messages
   - Success messages

### Key Pages
1. **Public Pages**
   - Home
   - Property listings
   - Property details
   - Booking form
   - Contact
   - About
   - Stories

2. **Admin Pages**
   - Dashboard
   - Property management
   - Booking management
   - Content management
   - System settings

## Backend Components

### Models
1. **Property**
   ```ruby
   - has_many :property_images
   - has_many :property_facilities
   - has_many :facilities
   - has_many :property_activities
   - has_many :activities
   - has_many :property_popular_filters
   - has_many :popular_filters
   - has_many :bookings
   - has_many :room_categories
   ```

2. **Booking**
   ```ruby
   - belongs_to :property
   - Validations for guest info
   - Token generation
   ```

3. **Other Models**
   - Story
   - Facility
   - Activity
   - PopularFilter
   - AdminConfig

### Controllers
1. **Public Controllers**
   - PagesController
   - PropertiesController
   - BookingsController
   - StoriesController

2. **Admin Controllers**
   - Admin::PropertiesController
   - Admin::BookingsController
   - Admin::StoriesController
   - Admin::FacilitiesController
   - Admin::ActivitiesController
   - Admin::PopularFiltersController
   - Admin::AdminConfigsController

## Database Structure

### Key Tables
1. **properties**
   - Basic info
   - Location
   - Pricing
   - SEO fields

2. **bookings**
   - Guest info
   - Booking details
   - Status
   - Token

3. **Supporting Tables**
   - property_images
   - property_facilities
   - property_activities
   - property_popular_filters
   - room_categories
   - facilities
   - activities
   - popular_filters
   - stories
   - admin_configs

## Authentication System

### Devise Integration
- Admin authentication
- Session management
- Password recovery
- Remember me functionality

### Security Features
- CSRF protection
- Secure password hashing
- Session management
- Token-based authentication

## Core Features

### Property Management
1. **Basic Operations**
   - Create/Edit/Delete properties
   - Image upload and management
   - Room category management
   - Pricing management

2. **Search and Filter**
   - By facilities
   - By activities
   - By popular filters
   - By price range
   - By location

### Booking System
1. **Reservation Process**
   - Room selection
   - Guest information
   - Payment processing
   - Confirmation

2. **Management**
   - Booking list
   - Status updates
   - Guest communication
   - Reporting

### Content Management
1. **Stories**
   - Create/Edit/Delete
   - Rich text content
   - Image management
   - SEO optimization

2. **Facilities & Activities**
   - Management interface
   - Property associations
   - Filter integration

## Admin Interface

### Dashboard
- Overview statistics
- Recent bookings
- Quick actions
- System status

### Management Sections
1. **Properties**
   - List view
   - Detail view
   - Edit interface
   - Image management

2. **Bookings**
   - List view
   - Detail view
   - Status management
   - Guest information

3. **Content**
   - Story management
   - Facility management
   - Activity management
   - Filter management

4. **Configuration**
   - System settings
   - Global options
   - User management

### Backend Tabs

The backend interface includes the following tabs:

- **Properties**: Manage resort properties, including basic info, images, room categories, and pricing.
- **Bookings**: View and manage guest reservations, including guest details and booking status.
- **Stories**: Manage blog/content about the resort, including rich text content and SEO optimization.
- **Facilities**: Manage resort amenities and associate them with properties.
- **Activities**: Manage resort activities and associate them with properties.
- **Popular Filters**: Manage search/filter categories for quick property filtering.
- **Admin Config**: Manage global admin settings and site-wide configuration.

## API Endpoints

### Public API
- Property listing
- Property details
- Booking creation
- Search and filter

### Admin API
- Property management
- Booking management
- Content management
- System configuration

## Asset Management

### Images
- Property images
- Story images
- Logo and branding
- Icons and UI elements

### Styles
- Tailwind CSS
- Custom components
- Responsive design
- Theme customization

### JavaScript
- Stimulus controllers
- Turbo integration
- Custom functionality
- Third-party integrations

## Development Setup

### Requirements
- Ruby 3.3.4
- PostgreSQL
- Node.js
- Yarn

### Configuration
1. **Environment Variables**
   - Database configuration
   - API keys
   - Service credentials

2. **Development Tools**
   - Debug configuration
   - Testing setup
   - Code quality tools

### Deployment
- Kamal configuration
- Production settings
- Performance optimization
- Security measures

## Git & GitHub: How to Push This Project

### 1. Initialize Git (if not already done)
```sh
git init
```

### 2. Add a .gitignore file (if not present)
- Make sure you have a `.gitignore` file to avoid committing unnecessary files. (See above for a typical Rails .gitignore.)

### 3. Add and Commit Your Changes
```sh
git add .
git commit -m "Initial commit or update"
```

### 4. Add the Remote Repository
Replace the URL with your repository's URL:
```sh
git remote add origin https://github.com/yourusername/yourrepo.git
```

### 5. Fetch Remote Changes (if the repo is not empty)
```sh
git fetch origin
```

### 6. Merge Remote and Local Histories (if needed)
If you see errors about unrelated histories or merge conflicts:
```sh
git pull origin main --allow-unrelated-histories
```
- If you get a conflict (e.g., with `.gitattributes`), resolve it by removing or merging the file, then continue:
```sh
rm -f .gitattributes
# or manually resolve, then:
git add .gitattributes
```

### 7. Push to GitHub
```sh
git push -u origin main
```

### 8. If You See 'rejected' Errors
- This usually means the remote has changes you don't have locally. Always pull and merge first (see step 6), then push again.

### 9. Force Push (Not Recommended)
- Only use this if you are sure you want to overwrite the remote:
```sh
git push -f origin main
```

### 10. Verify on GitHub
- Visit your repository URL to confirm your files are uploaded.

---

**Tip:** For collaborative projects, always pull before you push, and resolve any merge conflicts locally before pushing to avoid overwriting others' work. 

## Stimulus Nested Form Installation

To install the Stimulus nested form component, follow these steps:

1. **Open your terminal** (make sure you are in your Rails project directory).
2. **Run the following command:**
   ```sh
   yarn add @stimulus-components/rails-nested-form
   ```

3. **After installation completes:**
   - Restart your Rails server and your JS bundler (if you use `bin/dev`, stop and start it again).
   - Refresh your browser (clear cache if needed). 

## Nested Forms with Cocoon

### Room Category Implementation

The application supports nested form management using the Cocoon gem, which is particularly useful for managing the relationship between properties and room categories.

#### Setup and Dependencies

1. **Gem Installation**
   ```ruby
   # In Gemfile
   gem "cocoon", "~> 1.2"
   ```

2. **JavaScript Integration**
   ```javascript
   // In app/javascript/application.js
   import 'cocoon-js'
   ```

#### Model Configuration

1. **Property Model**
   ```ruby
   class Property < ApplicationRecord
     # Relationship with room categories
     has_many :room_categories, dependent: :destroy
     
     # Enable nested attributes for cocoon
     accepts_nested_attributes_for :room_categories, allow_destroy: true
     
     # ... other associations and validations
   end
   ```

2. **RoomCategory Model**
   ```ruby
   class RoomCategory < ApplicationRecord
     belongs_to :property
     
     validates :name, presence: true
     validates :normal_price, presence: true
     
     before_save :set_current_price
     
     private
     
     def set_current_price
       self.current_price = discounted_price || normal_price
     end
   end
   ```

#### Controller Configuration

The controller needs to permit the nested attributes in the strong parameters:

```ruby
# In Admin::PropertiesController
def property_params
  params.require(:property).permit(
    :name, :address, :tagline, :short_description,
    :latitude, :longitude, :normal_price, :discounted_price,
    :discount_percent, :discount_text, :offer_text, :overview,
    facility_ids: [], 
    activity_ids: [], 
    popular_filter_ids: [],
    property_images_attributes: [ :id, :image, :_destroy ],
    room_categories_attributes: [
      :id, :name, :normal_price, :discounted_price, :discount_percent, :_destroy
    ]
  )
end
```

#### View Implementation

1. **Main Form Integration**
   ```erb
   <!-- In _form.html.erb -->
   <div class="pt-12 pb-8">
     <h2 class="text-2xl font-bold leading-8 text-gray-900 mb-8">Room Categories</h2>
     <div class="mt-6 space-y-8">
       <div id="room-categories-container">
         <%= form.fields_for :room_categories do |room_category_fields| %>
           <%= render 'room_category_fields', f: room_category_fields %>
         <% end %>
       </div>
       <div>
         <%= link_to_add_association form, :room_categories, 
           class: "mt-2 inline-flex items-center px-4 py-2 border-2 border-indigo-400 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500",
           data: { association_insertion_node: '#room-categories-container', association_insertion_method: 'append' } do %>
           <svg class="-ml-1 mr-2 h-5 w-5 text-indigo-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
             <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
           </svg>
           Add Room Category
         <% end %>
       </div>
     </div>
   </div>
   ```

2. **Room Category Fields Partial**
   ```erb
   <!-- In _room_category_fields.html.erb -->
   <div class="nested-fields grid grid-cols-1 md:grid-cols-4 gap-4 items-end border p-4 rounded-lg relative mb-6">
     <div>
       <%= f.label :name, 'Room Type', class: 'block text-sm font-medium text-gray-900' %>
       <%= f.text_field :name, class: 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6' %>
     </div>
     <div>
       <%= f.label :normal_price, 'Normal Price', class: 'block text-sm font-medium text-gray-900' %>
       <%= f.text_field :normal_price, class: 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6' %>
     </div>
     <div>
       <%= f.label :discounted_price, 'Discounted Price', class: 'block text-sm font-medium text-gray-900' %>
       <%= f.text_field :discounted_price, class: 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6' %>
     </div>
     <div>
       <%= f.label :discount_percent, 'Discount %', class: 'block text-sm font-medium text-gray-900' %>
       <%= f.number_field :discount_percent, class: 'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6' %>
     </div>
     <div class="absolute top-2 right-2">
       <%= link_to_remove_association 'Remove', f, class: 'text-red-600 text-xs' %>
     </div>
   </div>
   ```

### Best Practices for Working with Nested Forms

1. **Form Structure**
   - Keep form partials small and focused on one nested association
   - Use consistent styling across all nested form components
   - Place "Add" buttons outside the container where fields will be inserted

2. **User Experience**
   - Use clear visual hierarchy to distinguish parent and nested elements
   - Implement responsive layouts for nested fields
   - Add appropriate validation feedback for nested fields

3. **Common Issues and Solutions**
   - If the new room category doesn't save, check that all required fields are filled
   - Ensure `room_categories_attributes` is included in the controller's permitted parameters
   - If form submission fails due to validation errors, room categories fields should be preserved

4. **Performance Considerations**
   - Limit the number of nested fields that can be added (if appropriate)
   - Consider adding client-side validation for a better user experience
   - Use database indexes on foreign keys to optimize queries

This nested form implementation provides a seamless experience for managing room categories within the property creation and editing workflow. 