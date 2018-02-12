import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let batteryChannel = FlutterMethodChannel.init(name: "tk.ravenmessenger/genQR",
                                                   binaryMessenger: controller);
    batteryChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        let parsedDictionary = call.arguments as? [String: Any]
    
        result(self.makeQRCode(encodeString: (parsedDictionary! ["value"] as? String)!, fileName: (parsedDictionary! ["fileName"] as? String)!))
    });
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func makeQRCode(encodeString: String, fileName: String) -> String {
        
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        let qrCode = QRCode(encodeString)
        if let qrimage = qrCode?.image {
            if let data = UIImagePNGRepresentation(qrimage) {
                try? data.write(to: filename)
            }
        }
        
        return filename.path
    }
}
