platform :ios, '13.0'

target 'AuthorizationApp(SwiftUI)' do
  use_frameworks!

  # Firebase Pods
  pod 'Firebase/Core'
  pod 'Firebase/Auth'       
  pod 'Firebase/Firestore'  

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

end
