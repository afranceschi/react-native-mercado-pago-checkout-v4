
Pod::Spec.new do |s|
  s.name         = "RNMercadoPagoCheckoutV4"
  s.version      = "1.0.0"
  s.summary      = "RNMercadoPagoCheckoutV4"
  s.description  = <<-DESC
                  RNMercadoPagoCheckoutV4
                   DESC
  s.homepage     = "https://github.com/afranceschi/react-native-mercado-pago-checkout-v4"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/afranceschi/react-native-mercado-pago-checkout-v4.git", :tag => "master" }
  s.source_files  = "RNMercadoPagoCheckoutV4/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency "MercadoPagoSDK"  
#s.dependency "others"

end

  
