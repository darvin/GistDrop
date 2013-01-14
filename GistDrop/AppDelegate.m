//
//  AppDelegate.m
//  GistDrop
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate {
    NSMenu* _dockMenu;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSApp setServicesProvider:self];
}


- (BOOL)application:(NSApplication *)app openFile:(NSString *)filename {
    NSLog(@"FILE %@", filename);
    return YES;
}

- (NSMenu*)dockMenu {
    if (!_dockMenu) {
        _dockMenu = [[NSMenu alloc] initWithTitle:@"Dock Menu"];
        NSMenuItem *menuScreenshot = [[NSMenuItem alloc] initWithTitle:@"Screenshot" action:@selector(menuScreenshot) keyEquivalent:@""];
        NSMenuItem *menuAreaScreenshot = [[NSMenuItem alloc] initWithTitle:@"Area screenshot" action:@selector(menuAreaScreenshot) keyEquivalent:@""];
        NSMenuItem *menuWindowScreenshot = [[NSMenuItem alloc] initWithTitle:@"Window shot" action:@selector(menuWindowScreenshot) keyEquivalent:@""];
        NSMenuItem *menuWebpageShot = [[NSMenuItem alloc] initWithTitle:@"Page shot" action:@selector(menuWebpageShot) keyEquivalent:@""];
        NSMenuItem *menuTextShot = [[NSMenuItem alloc] initWithTitle:@"Text shot" action:@selector(menuTextShot) keyEquivalent:@""];
        NSMenuItem *menuLatest = [[NSMenuItem alloc] initWithTitle:@"Latest..." action:@selector(menuLatest) keyEquivalent:@""];
        
        for (NSMenuItem* menuItem in
             @[
             menuScreenshot,
             menuAreaScreenshot,
             menuWindowScreenshot,
             menuWebpageShot,
             menuTextShot,
             menuLatest
             ]) {
            [_dockMenu addItem:menuItem];
            [menuItem setTarget:self];
        }
        NSLog(@"created");

    }
    return _dockMenu;
}



- (NSMenu*)applicationDockMenu:(NSApplication *)sender {
    return self.dockMenu;
}

/*
- (void)application:(NSApplication *)app openFiles:(NSArray *)filenames {
    NSLog(@"FILES %@", filenames);
}*/


#pragma mark -- services

- (void)selectionService:(NSPasteboard *)pboard userData:(NSString *)data error:(NSString **)error {
    NSLog(@"pboard: %@, userdata: %@", pboard,data);
    
    NSArray *types = [pboard types];
    if ([types containsObject:NSStringPboardType]){
        NSString* selection = [pboard stringForType:NSStringPboardType];
        NSLog(@"buffer: %@", selection);
        
        
        [pboard clearContents];
        [pboard writeObjects:@[@"http://google.com"]];
    }

}
#pragma mark -- menu actions
-(void)menuScreenshot{
    
}

-(void)menuLatest {
    
}

-(void)menuTextShot {
    
}

@end
