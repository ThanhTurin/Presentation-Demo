use_frameworks!

def sharable_pods
  pod 'Alamofire', '~> 4.7'
  pod 'SwiftyJSON', '~> 3.1'
end

target 'Demo-iOS' do
  sharable_pods

  target 'Demo-iOSTests' do
    inherit! :search_paths
  end

end

target 'Demo-tvOS' do
  sharable_pods

  target 'Demo-tvOSTests' do
    inherit! :search_paths
  end

end
