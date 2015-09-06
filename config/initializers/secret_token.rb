if ENV['SECRET_KEY_BASE']
  ApiMvp::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']
end
