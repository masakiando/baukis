コマンド手順
ruby -e 'require "securerandom"; print SecureRandom.hex(64)' > ~/.baukis_secret_key_base

export SECRET_KEY_BASE=`cat ~/.baukis_secret_key_base`

bin/rake db:create RAILS_ENV=production

bin/rake assets:precompile RAILS_ENV=production

bin/rails s -e production
pwd
bin/rails

bin/rails g controller errors

bin/rake db:migrate

bin/rails r 'StaffMember.columns.each{ |c| p [ c.name, c.type ] }'

bin/rspec spec/models/staff_member_spec.rb
