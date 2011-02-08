#import "WeekView.h"

@implementation WeekView

@synthesize delegate;
@synthesize active;

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}

- (void)setActive:(BOOL)a
{
    active = a;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    if ( active )
    {
        [[NSColor selectedMenuItemColor] setFill];
        NSRectFill(dirtyRect);
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if ( self.delegate && [self.delegate respondsToSelector:@selector(view:mouseDown:)] )
    {
        [self.delegate view:self mouseDown:theEvent];
    }
}

@end
