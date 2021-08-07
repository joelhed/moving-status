//
//  AppDelegate.swift
//  Moving Status
//
//  Created by Mac on 2021-08-07.
//  Copyright © 2021 Joel Hedtjärn. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var statusItem: NSStatusItem!
    var timer: Timer!
    var position: Int = 0

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        initStatusBar()
    }
    
    func initStatusBar() -> Void {
        // init status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: 10)
        
        // init the timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: self.updateStatusItem)
    }
    
    func updateStatusItem(_: Timer) -> Void {
        let marqueeString = "Dani<3"
        if let button = statusItem.button {
            button.title = String(marqueeString[marqueeString.index( marqueeString.startIndex, offsetBy: position)])
        }
        position = (position + 1) % marqueeString.count
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        NSStatusBar.system.removeStatusItem(statusItem)
        timer.invalidate()
    }


}

