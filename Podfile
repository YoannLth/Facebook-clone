source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Facebook-clone.xcworkspace'

def all_pods
  pod 'Bolts'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'FacebookCore', '~> 0.2'
  pod 'FacebookLogin', '~> 0.2'
  pod 'FacebookShare', '~> 0.2'
  pod 'FBSDKCoreKit', '~> 4.22.1'
  pod 'FBSDKLoginKit', '~> 4.22.1'
  pod 'FBSDKShareKit', '~> 4.22.1'
  pod 'Font-Awesome-Swift', '~> 1.6.1'
  pod 'Kingfisher'
  pod 'SwiftKeychainWrapper'
end

target 'Facebook-clone' do
    all_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
