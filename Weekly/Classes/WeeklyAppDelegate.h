#import <Cocoa/Cocoa.h>

@class WeekViewController;

@interface WeeklyAppDelegate : NSObject<NSApplicationDelegate>

@property (weak) IBOutlet WeekViewController *weekViewController;
@property (assign) BOOL startAtLogin;

@end
