#import "WeekViewController.h"

@interface WeekViewController (Private)

- (void)updateWeekString;
- (void)setupTimer;

@end


@implementation WeekViewController

@synthesize weekString;
@synthesize menu, statusItem;

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
    [_timer release];

    [weekString release];
    [statusItem release];
    [menu release];
    [super dealloc];
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
    _timer = [timer retain];
}

- (void)updateWeekString
{
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"w"];
    self.weekString = [weekFormatter stringFromDate:[NSDate date]];

    // change font size if there are two numbers in string
    _fontSize = ( [self.weekString length] == 1 ) ? 10 : 9;
    [weekFormatter release];
}

- (void)setStatusItem:(NSStatusItem *)item
{
    if ( item != statusItem )
    {
        [statusItem autorelease];
        statusItem = [item retain];
        [statusItem setView:[self view]];
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
