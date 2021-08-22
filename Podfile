# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SMS-Vietlott' do
  # Comment the next line if you don't want to use dynamic frameworks
   use_frameworks!

	pod 'AFNetworking'
  pod 'SVProgressHUD'
  pod 'SDWebImage'
  pod 'IQKeyboardManager'
  pod 'JVFloatLabeledTextField'
  pod 'CCDropDownMenus'
  pod 'UIBarButtonItem-Badge-Coding'
  pod 'SSKeychain', '~> 1.4'
  pod 'NSHash'
  pod 'JSONModel'
  pod 'AESCrypt-ObjC'

  # Pods for SMS-Vietlott

  target 'SMS-VietlottTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SMS-VietlottUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
  end

end
