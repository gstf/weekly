
#import <Cocoa/Cocoa.h>

#import "WeekView.h"

@interface WeekViewController : NSViewController <WeekViewDelegate>
{
    NSString        *weekString;
    NSStatusItem    *statusItem;
    NSMenu          *menu;
@private
    NSTimer         *_timer;
    NSUInteger       _fontSize;
}

@property (assign) IBOutlet NSMenu *menu;
@property (retain) NSString *weekString;
@property (retain) NSStatusItem *statusItem;


@end
