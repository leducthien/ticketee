require 'spec_helper'

feature 'Seed data' do
  scenario 'The basic' do
    load Rails.root + 'db/seeds.rb'
    user = User.where(email: 'admin@example.com').first!
    project = Project.where(name: 'Ticketee').first!
  end
end
