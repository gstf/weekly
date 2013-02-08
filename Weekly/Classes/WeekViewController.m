
#import "WeekViewController.h"

#import "WeekView.h"

@interface WeekViewController()<WeekViewDelegate>

- (void)updateWeekString;
- (void)setupTimer;

@end

@implementation WeekViewController
{
@private
    NSTimer         *_timer;
    NSUInteger       _fontSize;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ( self = [super initWithCoder:coder] )
    {
        [self setupTimer];
    }

	return self;
}

- (void)dealloc
{
    [_timer invalidate];
}

#pragma mark Private


- (void)setupTimer
{
    [self updateWeekString];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                      target:self
                                                    selector:@selector(updateWeekString)
                                                    userInfo:nil
                                                     repeats:YES];
    _timer = timer;
}

- (void)updateWeekString
{
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"w"];
    self.weekString = [weekFormatter stringFromDate:[NSDate date]];

    // change font size if there are two numbers in string
    _fontSize = ( [self.weekString length] == 1 ) ? 10 : 9;
}

- (void)setStatusItem:(NSStatusItem *)item
{
    if ( item != _statusItem )
    {
        _statusItem = item;
        [_statusItem setView:[self view]];
    }
}

#pragma mark WeekViewDelegate methods

- (void)view:(WeekView *)theView mouseDown:(NSEvent *)theEvent
{
    theView.active = !theView.active;
    [self.statusItem popUpStatusItemMenu:self.menu];
}

#pragma mark NSMenu delegate

- (void)menuDidClose:(NSMenu *)menu
{
    WeekView *v = (WeekView *)self.view;
    [v setActive:NO];
}

@end
