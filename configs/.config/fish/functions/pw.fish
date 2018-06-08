function pw
  ruby -r securerandom -e 'puts SecureRandom.urlsafe_base64(32, false)'
end
