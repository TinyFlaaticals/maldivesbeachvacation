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