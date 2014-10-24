#
# Be sure to run `pod lib lint FCVerticalMenu.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "FCVerticalMenu"
s.version          = "0.1.0"
s.summary          = "A dropdown menu completely customizable"
s.homepage         = "https://github.com/filippocamillo/FCVerticalMenu"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Filippo Camillo" => "hello@filippocamillo.com" }
s.source           = { :git => "https://github.com/filippocamillo/FCVerticalMenu.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pod/Classes'
s.resource_bundles = {
'FCVerticalMenu' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit', 'QuartzCore'

end
