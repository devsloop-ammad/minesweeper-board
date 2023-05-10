# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    width { 3 }
    height { 3 }
    mines_count { 4 }
  end
end
