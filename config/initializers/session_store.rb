# Be sure to restart your server when you modify this file.
if Rails.env.production?
    Rails.application.config.session_store :cookie_store, key: '_patternapp_session', domain: '.patternapp.net', expire_after: 1.month, secure: Rails.env.production?
else
    Rails.application.config.session_store :cookie_store, key: '_patternapp_session', domain: '.patternapp-yu23ki14.c9users.io', expire_after: 1.month, secure: Rails.env.production?
end