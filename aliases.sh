alias build="docker-compose build"
alias up="docker-compose up"
alias stop="docker-compose stop"

alias bundle="docker-compose run -e --rm app bundle"
alias rails="docker-compose run -e --rm app bundle exec rails"
alias rspec="docker-compose run -e --rm spring spring rspec"
alias rubocop="docker-compose run -e --rm app bundle exec rubocop"
alias ridgepole="docker-compose run -e --rm app bundle exec ridgepole"
