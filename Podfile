source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Facebook-clone.xcworkspace'

def all_pods
  pod 'Firebase/Core'
  pod 'FBSDKLoginKit'
end

target 'Facebook-clone' do
    all_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
