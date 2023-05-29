import Flutter
import UIKit

public class KeyboardActionPlugin: NSObject, FlutterPlugin {
    let keyEvent = KeyboardEvent()
    let center:NotificationCenter
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "custom_keyboard_action", binaryMessenger: registrar.messenger())
        let instance = KeyboardActionPlugin()
        FlutterEventChannel(name: "custom_keyboard_action_event", binaryMessenger: registrar.messenger()).setStreamHandler(instance.keyEvent)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    override init() {
        self.center = NotificationCenter.default
        super.init()
        self.center.addObserver(self, selector: #selector(didShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        self.center.addObserver(self, selector: #selector(willShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.center.addObserver(self, selector: #selector(didHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    deinit {
        center.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    @objc func didShow(_ notification: Notification){
        self.keyEvent.success(true)
    }
    
    @objc func willShow(_ notification: Notification){
        self.keyEvent.success(true)
    }
    
    @objc func didHide(_ notification: Notification){
        self.keyEvent.success(false)
    }
}

class KeyboardEvent:NSObject,FlutterStreamHandler{
    private var sink:FlutterEventSink? = nil
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }
    func success(_ value:Bool){
        sink?(value)
    }
    
}
