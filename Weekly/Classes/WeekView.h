#import <Cocoa/Cocoa.h>

@protocol WeekViewDelegate;

@interface WeekView : NSView

@property (weak) id<WeekViewDelegate> delegate;
@property (assign, nonatomic) BOOL active;

@end


@protocol WeekViewDelegate<NSObject>

@optional
- (void)view:(WeekView *)theView mouseDown:(NSEvent *)theEvent;

@end

