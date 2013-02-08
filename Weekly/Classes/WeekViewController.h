
#import <Cocoa/Cocoa.h>

@interface WeekViewController : NSViewController

@property (weak) IBOutlet NSMenu *menu;
@property (strong, nonatomic) NSString *weekString;
@property (strong, nonatomic) NSStatusItem *statusItem;


@end
