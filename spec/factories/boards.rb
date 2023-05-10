# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { 'Test' }
    email { 'test@email.com' }
    width { 3 }
    height { 3 }
    mines_count { 4 }
  end
end
