# Uncomment the next line to define a global platform for your project
platform :ios, '14.2'

def appPods
   pod 'RxSwift', '6.2.0'
   pod 'RxCocoa', '6.2.0'
   pod 'Kingfisher', '~> 7.0'
   pod 'SnapKit', '~> 5.0.0'
   pod 'MaterialComponents/ActivityIndicator'
   pod 'RealmSwift'

end

target 'NewsApp' do
   use_modular_headers!
   appPods


  target 'NewsAppTests' do
      inherit! :search_paths
      appPods
   pod 'RxBlocking', '6.2.0'
   pod 'RxTest', '6.2.0'
    
  end

  target 'NewsAppUITests' do
    # Pods for testing
  end

end
