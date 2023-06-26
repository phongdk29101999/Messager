# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
plugin 'cocoapods-binary'

def install_pods 
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseStorage'
  pod 'FirebaseAnalytics'
  pod 'FirebaseMessaging'
  pod 'FirebaseFirestoreSwift'
  pod 'Gallery', '~>2.4.0'
  pod 'InputBarAccessoryView', '~>5.5.0'
  pod 'IQKeyboardManagerSwift','6.5.6'
  pod 'MessageKit', '~>3.8.0'
  pod 'ProgressHUD', '~>13.6.2'
  pod 'ReachabilitySwift','5.0.0'
  pod 'RealmSwift', '~>10.40.2'
  pod 'SKPhotoBrowser', '~>7.1.0'
  pod 'SnapKit', '~> 5.0.0'
  pod 'SwiftLint'
end

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
enable_bitcode_for_prebuilt_frameworks!
keep_source_code_for_prebuilt_frameworks!
inhibit_all_warnings! 

target 'Messager' do
  install_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      # for M1 Mac
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end
