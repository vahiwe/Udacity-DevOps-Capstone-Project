## The Makefile includes instructions lint
# HTML will be linted with tidy
# Dockerfile should pass hadolint

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for HTML
	tidy public-html/index.html