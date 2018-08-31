FactoryBot.define do
  factory :item do
    title 'Socks'
  end

  factory :invalid_item, class: 'Item' do
    title nil
  end

  factory :new_item, class: 'Item' do
    description "It's socks"
  end

  factory :item_with_image, class: 'Item' do
    title 'Socks'
    description "It's socks"
    attachments { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/avatar.jpg'), 'image/jpg'),
                   Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/photo1.jpg'), 'image/jpg')] }
  end
end
