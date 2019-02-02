//
//  AppDelegate.swift
//  RadyoEksen
//
//  Created by Cem Olcay on 28/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var popover : NSPopover?
    
    let icon: IconView;
    
    override init() {
      let bar = NSStatusBar.system;
      let item = bar.statusItem(withLength: -1);
        
        self.icon = IconView(imageName: "eksen16", item: item);
        item.view = icon;
        
        super.init();
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    override func awakeFromNib() {
        //NSRectEdge is not enumerated yet; NSMinYEdge == 1
        //@see NSGeometry.h
        let edge = 1
        let icon = self.icon
        let rect = icon.frame
        
        icon.onMouseDown = {
            if (icon.isSelected)
            {
              self.popover!.show(
                relativeTo: rect,
                of: icon,
                preferredEdge: NSRectEdge(rawValue: UInt(edge))!)
                return
            }
            self.popover!.close()
        }
    }

}

