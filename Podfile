# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MyStoreApp' do
  use_frameworks!
  
  # Pods for MyStoreApp
  pod 'Alamofire', '5.6.2'
  pod "PromiseKit", "~> 6.8"
  pod 'Kingfisher', '~> 7.0'
  pod 'SDWebImage'
  pod 'Cosmos', '~> 25.0'
  
  target 'MyStoreAppTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'MyStoreAppUITests' do
    # Pods for testing
  end
  
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']) < Gem::Version.new('13.0')
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          config.build_settings['WATCHOS_DEPLOYMENT_TARGET'] = '6.2'
        end
      end
    end
    
    installer.aggregate_targets.each do |target|
      target.xcconfigs.each do |variant, xcconfig|
        xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
    
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
          xcconfig_path = config.base_configuration_reference.real_path
          IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
        end
      end
    end
  end
end
