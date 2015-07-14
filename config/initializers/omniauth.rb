Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, ENV['STEAM_WEB_API_KEY'], request_path: '/login', callback_path: '/login/callback'
end
