#import <Foundation/Foundation.h>

@interface HKLoginItem : NSObject

+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;
+ (BOOL)willStartAtLogin:(NSURL *)itemURL;

@end
