import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    // Example for use custom deep link handler

    // private let DEEP_LINK_CHANNEL: String = "com.example.flutter_test_tdd/channel"
    // private let DEEP_LINK_EVENT: String = "com.example.flutter_test_tdd/event"
    // private let METHOD_DEEP_LINK_INIT: String = "deepLinkInit"
    //
    // private var methodChannel: FlutterMethodChannel?
    // private var eventChannel: FlutterEventChannel?
    //
    // private let linkStreamHandler = LinkStreamHandler()
    // private var initialLink: String?
    //
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // let controller = window.rootViewController as! FlutterViewController
        // methodChannel = FlutterMethodChannel(name: DEEP_LINK_CHANNEL, binaryMessenger: controller.binaryMessenger)
        // methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
        //     guard call.method == self.METHOD_DEEP_LINK_INIT else {
        //         result(FlutterMethodNotImplemented)
        //         return
        //     }
        //     result(self.initialLink)
        // })
        //
        // eventChannel = FlutterEventChannel(name: DEEP_LINK_EVENT, binaryMessenger: controller.binaryMessenger)

        GeneratedPluginRegistrant.register(with: self)
        // eventChannel?.setStreamHandler(linkStreamHandler)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    //
    // override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    //     initialLink = url.absoluteString
    //     eventChannel?.setStreamHandler(linkStreamHandler)
    //     return linkStreamHandler.handleLink(url.absoluteString)
    // }
}

class LinkStreamHandler: NSObject, FlutterStreamHandler {

    var eventSink: FlutterEventSink?

    var queuedLinks = [String]()

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        queuedLinks.forEach({ events($0) })
        queuedLinks.removeAll()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }

    func handleLink(_ link: String) -> Bool {
        guard let eventSink = eventSink else {
            queuedLinks.append(link)
            return false
        }
        eventSink(link)
        return true
    }
}
