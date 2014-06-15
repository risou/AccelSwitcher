//
//  RSFAppDelegate.h
//  AccelSwitcher
//
//  Created by risou on 2014/06/14.
//  Copyright (c) 2014年 risou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RSFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *mouse;
@property (weak) IBOutlet NSButton *trackpad;

@property (nonatomic) double mouseAccel;
@property (nonatomic) double trackpadAccel;

@property (weak) IBOutlet NSTextField *mouseStatus;
@property (weak) IBOutlet NSTextField *trackpadStatus;

@end
