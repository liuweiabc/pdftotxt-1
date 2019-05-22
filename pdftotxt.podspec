#
# Be sure to run `pod lib lint pdftotxt.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'pdftotxt'
  s.version          = '0.1.3'
  s.summary          = 'PDF转文字'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  PDF转文字，基于xpdf
                       DESC

  s.homepage         = 'https://github.com/zhong015/pdftotxt'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wtr0@qq.com' => 'wtr0@qq.com' }
  s.source           = { :git => 'https://github.com/zhong015/pdftotxt.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'WTRpdfLib/*.h'
  s.source_files = 'WTRpdfLib/*.{h,m}'

  s.subspec 'xpdf' do |ss|
    ss.public_header_files = 'WTRpdfLib/Classes/*.h'
    ss.source_files = 'WTRpdfLib/Classes/**/*'
  end

  s.resources    = 'WTRpdfLib/Assets/WTRXPDF.bundle'

  s.frameworks = 'Foundation'

  s.compiler_flags = '-Wno-shorten-64-to-32','-Wno-conditional-uninitialized'

end
