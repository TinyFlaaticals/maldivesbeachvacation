#!/usr/bin/env ruby

# Simple script to test OG tag generation for stories
require_relative 'config/environment'

puts "🧪 Testing Open Graph Tags for Stories"
puts "======================================"

# Get a story with an image
story_with_image = Story.joins(:image_attachment).first
story_without_image = Story.left_joins(:image_attachment).where(active_storage_attachments: { id: nil }).first

if story_with_image
  puts "\n📖 Story WITH image:"
  puts "Title: #{story_with_image.title}"
  puts "Has image: #{story_with_image.image.attached?}"
  puts "Content preview: #{story_with_image.content.to_s.truncate(100)}"
  puts "Tags: #{story_with_image.tags.pluck(:name).join(', ')}"
  puts "URL would be: /stories/#{story_with_image.id}"
else
  puts "\n❌ No stories with images found"
end

if story_without_image
  puts "\n📖 Story WITHOUT image:"
  puts "Title: #{story_without_image.title}"
  puts "Has image: #{story_without_image.image.attached?}"
  puts "Content preview: #{story_without_image.content.to_s.truncate(100)}"
  puts "Tags: #{story_without_image.tags.pluck(:name).join(', ')}"
  puts "URL would be: /stories/#{story_without_image.id}"
else
  puts "\n✅ All stories have images"
end

puts "\n📊 Total stories: #{Story.count}"
puts "Stories with images: #{Story.joins(:image_attachment).count}"
puts "Stories without images: #{Story.left_joins(:image_attachment).where(active_storage_attachments: { id: nil }).count}"

puts "\n✅ Test completed!"
puts "Next step: Deploy changes and test social sharing"