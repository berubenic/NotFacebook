OmniAuth.config.test_mode = true
OmniAuth.config.logger = Rails.logger

def set_omniauth(provider)
  OmniAuth.config.mock_auth[provider.to_sym] =
    OmniAuth::AuthHash.new(
      provider: provider.to_s,
      uid: '1234',
      info: {
        email: 'email@email.com',
        name: 'Joe Picket'
      }
    )
end
