SHELL := /bin/bash
.PHONY: help ios update tvos

RUBY := $(shell command -v ruby 2>/dev/null)
HOMEBREW := $(shell command -v brew 2>/dev/null)
BUNDLER := $(shell command -v bundle 2>/dev/null)

default: help

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
## -- Building --

# And add help text after each target name starting with '\#\#'
# A category can be added with @category
## -- Building --

fakesign:
    rm -rf archive.xcarchive/Products/Applications/SideStore.app/Frameworks/AltStoreCore.framework/Frameworks/
    ldid -SAltStore/Resources/ReleaseEntitlements.plist archive.xcarchive/Products/Applications/SideStore.app/SideStore
    ldid -SAltWidget/Resources/ReleaseEntitlements.plist archive.xcarchive/Products/Applications/SideStore.app/PlugIns/AltWidgetExtension.appex/AltWidgetExtension

ipa:
    mkdir -p Payload
    cp -R /Users/runner/work/Counter-Super-Simple-Rewrite/Counter-Super-Simple-Rewrite/build/ios/iphoneos/Runner.app Payload/
    zip -r SideStore.ipa Payload