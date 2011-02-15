#import "WeeklyAppDelegate.h"
#import "WeekViewController.h"
#import "HKLoginItem.h"

@interface WeeklyAppDelegate (Private)

- (NSURL *)appURL;

@end


@implementation WeeklyAppDelegate

@synthesize weekViewController;
@synthesize startAtLogin;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    if ( !statusItem )
    {
        NSRunAlertPanel( @"Error", @"Timing status bar item could not be created", @"Error", nil, nil );
        [NSApp terminate:self];
    }

    weekViewController.statusItem = statusItem;
    weekViewController.view.frame = NSMakeRect( 0.0f, 0.0f, [weekViewController view].frame.size.width, [weekViewController view].frame.size.height );
}

- (void)dealloc
{
    [weekViewController release];

    [super dealloc];
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
