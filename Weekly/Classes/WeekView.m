#import "WeekView.h"

@implementation WeekView

- (void)setActive:(BOOL)active
{
    if ( active != _active )
    {
        _active = active;
        [self setNeedsDisplay:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    if ( self.active )
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
