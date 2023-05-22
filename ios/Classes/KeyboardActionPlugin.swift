import Flutter
import UIKit

@available(iOS 13.0, *)
public class KeyboardActionPlugin: NSObject, FlutterPlugin {
    let keyEvent = KeyboardEvent()
    var center:NotificationCenter? = nil
    var overlayView = UIView()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "keyboard_action", binaryMessenger: registrar.messenger())
        let instance = KeyboardActionPlugin()
        FlutterEventChannel(name: "keyboard_action_event", binaryMessenger: registrar.messenger()).setStreamHandler(instance.keyEvent)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initial":initial( result: result)
        case "dispose":dispose( result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func initial(result: @escaping FlutterResult){
        if center != nil{
            result(true)
            return
        }
        center = NotificationCenter.default;
        center!.addObserver(self, selector: #selector(didShow), name: UIResponder.keyboardDidShowNotification, object: nil)
//        center!.addObserver(self, selector: #selector(willShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        center!.addObserver(self, selector: #selector(didHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        result(true)
    }
    
    func dispose(result: @escaping FlutterResult){
        center?.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
//        center?.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        center?.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        result(true)
    }
    
    @objc func didShow(_ notification: Notification){
        showOverlay(notification)
    }
    
    @objc func willShow(_ notification: Notification){
        showOverlay(notification)
    }
    
    @objc func didHide(_ notification: Notification){
        hideOverlay()
    }
    
    @available(iOS 13.0, *)
    func showOverlay(_ notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let view = UIApplication.shared.windows.last{
                let size = keyboardSize.height
                if let appDelegate = UIApplication.shared.delegate as? FlutterAppDelegate, let window = appDelegate.window{
                    overlayView.frame = CGRectMake(0, window.frame.height - size - 50, window.frame.width, 50)
                    overlayView.backgroundColor = .white
                    overlayView.alpha = 0.0
                    overlayView.layer.zPosition = CGFloat(MAXFLOAT)
                    overlayView.tag = 100
                    //MARK: - btn done
                    let btnDone:UIButton = UIButton(frame: CGRectMake(window.frame.width - 60, 10, 50, 30))
                    btnDone.backgroundColor = .none
                    btnDone.setTitle("Done", for: .normal)
                    btnDone.setTitleColor(.systemBlue, for: .normal)
                    btnDone.addTarget(self, action: #selector(onTouchDone), for: .touchUpInside)
                    //MARK: - btn up
                    let btnUp = UIButton(type: .custom)
                    btnUp.frame = CGRectMake(20, 10, 40, 30)
                    let imgUp = UIImage(systemName: "chevron.up")
                    btnUp.setImage(imgUp, for: .normal)
                    btnUp.addTarget(self, action: #selector(onTouchUp), for: .touchUpInside)
                    //MARK: - btn down
                    let btnDown = UIButton(type: .custom)
                    btnDown.frame = CGRectMake(60, 10, 40, 30)
                    let imgDown = UIImage(systemName: "chevron.down")
                    btnDown.setImage(imgDown, for: .normal)
                    btnDown.addTarget(self, action: #selector(onTouchDown), for: .touchUpInside)
                    overlayView.addSubview(btnDone)
                    overlayView.addSubview(btnUp)
                    overlayView.addSubview(btnDown)
                    view.addSubview(self.overlayView)
                    UIView.transition(with: view,duration: 0.05, options: .curveLinear, animations: {
                        self.overlayView.alpha = 1.0
                    }, completion: nil)
                }
            }
        }
    }
    
    @objc func onTouchDone(_ sender: UIButton){
        keyEvent.success(.done)
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func onTouchUp(_ sender: UIButton){
        keyEvent.success(.up)
    }
    
    @objc func onTouchDown(_ sender: UIButton){
        keyEvent.success(.down)
    }
    
    func hideOverlay(){
        if let view = UIApplication.shared.windows.last?.viewWithTag(100){
            view.removeFromSuperview()
        }
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
    func success(_ value:ActionKeyboard){
        sink?(value.rawValue)
    }
    
}
