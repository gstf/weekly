#import "HKLoginItem.h"

@implementation HKLoginItem

// taken from http://stackoverflow.com/questions/815063/how-do-you-make-your-app-open-at-login/2318004#2318004

+ (BOOL)willStartAtLogin:(NSURL *)itemURL
{
    Boolean foundIt = false;

    LSSharedFileListRef loginItems = LSSharedFileListCreate( NULL, kLSSharedFileListSessionLoginItems, NULL );
    if ( loginItems )
    {
        UInt32 seed = 0U;
        NSArray *currentLoginItems = (__bridge_transfer NSArray *)LSSharedFileListCopySnapshot( loginItems, &seed );

        for ( id itemObject in currentLoginItems )
        {
            LSSharedFileListItemRef item = (__bridge LSSharedFileListItemRef)itemObject;

            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve( item, resolutionFlags, &URL, /*outRef*/ NULL );
            if ( err == noErr )
            {
                foundIt = CFEqual( URL, (__bridge CFTypeRef)(itemURL) );
                CFRelease( URL );

                if ( foundIt )
                    break;
            }
        }
        CFRelease( loginItems );
    }

    return (BOOL)foundIt;
}

+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled
{
    LSSharedFileListItemRef existingItem = NULL;

    LSSharedFileListRef loginItems = LSSharedFileListCreate( NULL, kLSSharedFileListSessionLoginItems, NULL );
    if ( loginItems )
    {
        UInt32 seed = 0U;
        NSArray *currentLoginItems = (__bridge_transfer NSArray *)LSSharedFileListCopySnapshot( loginItems, &seed );

        for ( id itemObject in currentLoginItems )
        {
            LSSharedFileListItemRef item = (__bridge LSSharedFileListItemRef)itemObject;

            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve( item, resolutionFlags, &URL, /*outRef*/ NULL );
            if ( err == noErr )
            {
                Boolean foundIt = CFEqual( URL, (__bridge CFTypeRef)(itemURL) );
                CFRelease( URL );

                if ( foundIt )
                {
                    existingItem = item;
                    break;
                }
            }
        }

        if ( enabled && ( existingItem == NULL ) )
        {
            LSSharedFileListInsertItemURL( loginItems, kLSSharedFileListItemBeforeFirst,
                                          NULL, NULL, (CFURLRef)CFBridgingRetain(itemURL), NULL, NULL );

        }
        else if ( !enabled && ( existingItem != NULL ) )
        {
            LSSharedFileListItemRemove( loginItems, existingItem );
        }

        CFRelease(loginItems);
    }
}

@end
