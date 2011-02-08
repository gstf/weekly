#import <Cocoa/Cocoa.h>

@class WeekViewController;

@interface WeeklyAppDelegate : NSObject <NSApplicationDelegate>
{
    WeekViewController *weekViewController;
    BOOL startAtLogin;
}

@property (assign) IBOutlet WeekViewController *weekViewController;
@property (assign) BOOL startAtLogin;

@end
