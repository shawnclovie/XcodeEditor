#import <Foundation/Foundation.h>

@interface NSStringEmojiHelper : NSObject

+ (BOOL)isIncludingEmojiForString:(NSString *)string;

+ (NSString *)stringByRemovingEmojiForString:(NSString *)source;

@end
