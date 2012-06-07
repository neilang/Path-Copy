//
//  NAAppDelegate.m
//  Path Copy
//
//  Created by Neil Ang on 7/06/12.
//  Copyright (c) 2012 neilang.com. All rights reserved.
//

#import <ScriptingBridge/ScriptingBridge.h>
#import "Finder.h"

#import "NAAppDelegate.h"

@implementation NAAppDelegate

@synthesize statusItem = _statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:30.0f];
    [self.statusItem setTitle:@"ಠ_ಠ"];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setTarget:self];
    [self.statusItem setAction:@selector(handleStatusItemClick:)];

}

#pragma mark - Actions

-(IBAction)handleStatusItemClick:(id)sender{
    NSEvent *event = [NSApp currentEvent];
    if([event modifierFlags] & NSControlKeyMask) {
        [self handleSecondaryStatusItemClick:sender];
    } else {
        [self copyPath:sender];
    }
}

-(IBAction)handleSecondaryStatusItemClick:(id)sender{
    NSZone *menuZone = [NSMenu menuZone];
    NSMenu *menu     = [[NSMenu allocWithZone:menuZone] init];
    
    [[menu addItemWithTitle:@"Copy path" action:@selector(copyPath:) keyEquivalent:@""] setTarget:self];    
    [menu addItem:[NSMenuItem separatorItem]];
    [[menu addItemWithTitle:@"Quit" action:@selector(quitApp:) keyEquivalent:@""] setTarget:self];

    [self.statusItem popUpStatusItemMenu:menu];
}

-(IBAction)quitApp:(id)sender{
    [NSApp terminate:sender];
}

-(IBAction)copyPath:(id)sender{
    
    NSMutableArray * paths = [[NSMutableArray alloc] init];
    
    FinderApplication * finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.finder"];
    SBElementArray * selection = [[finder selection] get];
    
    NSArray * items = [selection arrayByApplyingSelector:@selector(URL)];
    for (NSString * item in items) {
        NSURL * url = [NSURL URLWithString:item];
        [paths addObject:[url path]];
    }
    
    NSString *pbPaths = [paths componentsJoinedByString:@"\n"];
    
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeObjects:[NSArray arrayWithObject:pbPaths]];
}


@end
