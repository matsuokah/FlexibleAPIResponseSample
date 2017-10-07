#
# Functions
#

#
# Build Target Environments
#

.PHONY: all
all: setup_tools install_dependency

.PHONY: bundle_install
bundle_install: 
	bundle install --path vendor/bundle

.PHONY: bundle_update
bundle_update: 
	bundle update

.PHONY: install_dependency 
install_dependency:
	carthage update --platform iOS

.PHONY: update_dependency
update_dependency:
	carthage update --platform iOS

.PHONY: synx
synx:
	bundle exec synx FlexibleAPIResponseSample.xcodeproj

.PHONY: format
format: format_swift_all

.PHONY: format_swift_all
format_swift_all:
	swimat -r .
