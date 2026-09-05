#!/usr/bin/env bash
set -euo pipefail

echo "==> Ruby: $(ruby -v)"
echo "==> Bundler: $(bundle -v)"

echo "==> Configuring Bundler"
bundle config set --local deployment true
bundle config set --local without "development:test"
bundle config set --local jobs 1
bundle config set --local retry 3
bundle config set --local force_ruby_platform false

echo "==> Installing gems (native Linux gems enabled)"
BUNDLE_FORCE_RUBY_PLATFORM=false bundle install --verbose

echo "==> Migrating database"
bundle exec rails db:migrate

echo "==> Precompiling assets"
SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

echo "==> Build completed successfully"
