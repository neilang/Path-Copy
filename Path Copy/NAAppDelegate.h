//
//  NAAppDelegate.h
//  Path Copy
//
//  Created by Neil Ang on 7/06/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NAAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, retain) NSStatusItem *statusItem;

-(IBAction)handleStatusItemClick:(id)sender;
-(IBAction)handleSecondaryStatusItemClick:(id)sender;

-(IBAction)quitApp:(id)sender;
-(IBAction)copyPath:(id)sender;

@end
