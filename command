コマンド手順
ruby -e 'require "securerandom"; print SecureRandom.hex(64)' > ~/.baukis_secret_key_base

export SECRET_KEY_BASE=`cat ~/.baukis_secret_key_base`

bin/rake db:create RAILS_ENV=production

bin/rake assets:precompile

bin/rails s -e production
