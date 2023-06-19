# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
plugin 'cocoapods-binary'

def install_pods 
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'FirebaseFirestoreSwift'
  pod 'Gallery', '2.4.0', :binary => true
  pod 'InputBarAccessoryView', '5.5.0', :binary => true
  pod 'MessageKit', '3.8.0', :binary => true
  pod 'ProgressHUD', '13.6.2', :binary => true
  pod 'RealmSwift', '10.40.2', :binary => true
  pod 'SKPhotoBrowser', '7.1.0', :binary => true
  pod 'SwiftLint', :binary => true
end

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
enable_bitcode_for_prebuilt_frameworks!
keep_source_code_for_prebuilt_frameworks!
inhibit_all_warnings! 

target 'Messager' do
  install_pods
end
