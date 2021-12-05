require 'rails_helper'

RSpec.describe Post, 'validations' do
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body) }

  # 5 characters min
  it { is_expected.to allow_value('12345').for(:body) }

  # 1000 characters max
  it do
    is_expected.to_not allow_value(
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N.'
    ).for(:body)
  end
end

RSpec.describe User, '#acceptable_image' do
  it 'adds errors if image is too big' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    post = create(:post, user: user)
    post.post_image.attach(
      io: File.open(Rails.root + 'spec/fixtures/too_big.png'),
      filename: 'too_big.png'
    )

    expect(post.errors.full_messages).to include('Post image is too big')
  end

  it 'adds errors if image is wrong type' do
    user = create(:user, first_name: 'Joe', last_name: 'Picket')
    post = create(:post, user: user)
    post.post_image.attach(
      io: File.open(Rails.root + 'spec/fixtures/wrong_type.fig'),
      filename: 'wrong_type.fig'
    )

    expect(post.errors.full_messages).to include(
      'Post image must be a JPEG or PNG'
    )
  end
end
