#import <Cocoa/Cocoa.h>

@interface WeekView : NSView
{
    IBOutlet id delegate;
    BOOL active;
}

@property (assign) id delegate;
@property (assign) BOOL active;

@end


@protocol WeekViewDelegate

@optional
- (void)view:(WeekView *)theView mouseDown:(NSEvent *)theEvent;

@end

