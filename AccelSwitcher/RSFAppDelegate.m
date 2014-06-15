//
//  RSFAppDelegate.m
//  AccelSwitcher
//
//  Created by risou on 2014/06/14.
//  Copyright (c) 2014年 risou. All rights reserved.
//

#import "RSFAppDelegate.h"
#import <IOKit/hidsystem/IOHIDLib.h>
#import <IOKit/hidsystem/IOHIDParameter.h>
#import <IOKit/hidsystem/event_status_driver.h>

@implementation RSFAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self.mouse setAction:@selector(toggleMouse)];
    [self.trackpad setAction:@selector(toggleTrackpad)];
    
    [self getStatus];
}

- (void)getStatus
{
    NXEventHandle handle = NXOpenEventStatus();
    if (handle) {
        double mouseAccel;
        double trackpadAccel;

        IOHIDGetAccelerationWithKey(handle, CFSTR(kIOHIDMouseAccelerationType), &mouseAccel);
        self.mouseAccel = ((int)mouseAccel >> 15) ? -1.0 : 1.0;
        [self.mouseStatus setStringValue: (self.mouseAccel > 0) ? @"加速：ON" : @"加速：OFF"];

        IOHIDGetAccelerationWithKey(handle, CFSTR(kIOHIDTrackpadAccelerationType), &trackpadAccel);
        self.trackpadAccel = ((int)trackpadAccel >> 15) ? -1.0 : 1.0;
        [self.trackpadStatus setStringValue: (self.trackpadAccel > 0) ? @"加速：ON" : @"加速：OFF"];
    
        NXCloseEventStatus(handle);
    } else {
        NSLog(@"ERROR: no handle");
        exit(-1);
    }
}

- (void)toggleMouse
{
    NSLog(@"mouse button");

    NXEventHandle handle = NXOpenEventStatus();
    if (handle) {
        double accel;
        IOHIDGetAccelerationWithKey(handle, CFSTR(kIOHIDMouseAccelerationType), &accel);
        double newAccel = ((int)accel >> 15) ? 1.0 : -1.0;
        if (IOHIDSetAccelerationWithKey(handle, CFSTR(kIOHIDMouseAccelerationType), newAccel) != KERN_SUCCESS) {
            NSLog(@"ERROR: failed to change mouse accel");
        }
        self.mouseAccel = newAccel;
        [self.mouseStatus setStringValue: (self.mouseAccel > 0) ? @"加速：ON" : @"加速：OFF"];
        NXCloseEventStatus(handle);
    } else {
        NSLog(@"ERROR: no handle");
    }
}

- (void)toggleTrackpad
{
    NSLog(@"trackpad button");
    
    NXEventHandle handle = NXOpenEventStatus();
    if (handle) {
        double accel;
        IOHIDGetAccelerationWithKey(handle, CFSTR(kIOHIDTrackpadAccelerationType), &accel);
        double newAccel = ((int)accel >> 15) ? 1.0 : -1.0;
        NSLog(@"accel: %lf", accel);
        NSLog(@"newAccel: %lf", newAccel);
        if (IOHIDSetAccelerationWithKey(handle, CFSTR(kIOHIDTrackpadAccelerationType), newAccel) != KERN_SUCCESS) {
            NSLog(@"ERROR: failed to change trackpad accel");
        }
        self.trackpadAccel = newAccel;
        [self.trackpadStatus setStringValue: (self.trackpadAccel > 0) ? @"加速：ON" : @"加速：OFF"];
        NXCloseEventStatus(handle);
    } else {
        NSLog(@"ERROR: no handle");
    }
}

@end
