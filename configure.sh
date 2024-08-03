#!/usr/bin/env bash

rbenv install 3.3.0 --skip-existing
rbenv local 3.3.0 
rbenv version

gem install bundler

bundle config set path '.bundle'
bundle install
