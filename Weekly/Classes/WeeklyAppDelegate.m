
#import "WeeklyAppDelegate.h"
#import "WeekViewController.h"
#import "HKLoginItem.h"

@interface WeeklyAppDelegate (Private)

- (NSURL *)appURL;

@end


@implementation WeeklyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    if ( !statusItem )
    {
        NSRunAlertPanel( @"Error", @"Timing status bar item could not be created", @"Error", nil, nil );
        [NSApp terminate:self];
    }

    self.weekViewController.statusItem = statusItem;
    self.weekViewController.view.frame = NSMakeRect( 0.0f, 0.0f, [self.weekViewController view].frame.size.width, [self.weekViewController view].frame.size.height );
}


#pragma mark Overriden synthesized

- (BOOL)startAtLogin
{
    return [HKLoginItem willStartAtLogin:[self appURL]];
}

- (void)setStartAtLogin:(BOOL)enabled
{
    [self willChangeValueForKey:@"startAtLogin"];
    [HKLoginItem setStartAtLogin:[self appURL] enabled:enabled];
    [self didChangeValueForKey:@"startAtLogin"];
}

#pragma mark Private methods

- (NSURL *)appURL
{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
}

@end
