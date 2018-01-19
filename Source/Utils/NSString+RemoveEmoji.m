#import "NSString+RemoveEmoji.h"

static NSCharacterSet* VariationSelectors = nil;

@implementation NSStringEmojiHelper

+ (void)load
{
    VariationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
}

+ (BOOL)isEmojiForString:(NSString *)string {
    if ([string rangeOfCharacterFromSet: VariationSelectors].location != NSNotFound) {
        return YES;
    }
    const unichar high = [string characterAtIndex: 0];

    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low = [string characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;

        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);

    // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

+ (BOOL)isIncludingEmojiForString:(NSString *)string {
    BOOL __block result = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        if ([self isEmojiForString:substring]) {
            *stop = YES;
            result = YES;
        }
    }];
    return result;
}

+ (NSString *)stringByRemovingEmojiForString:(NSString *)source {
    __block __auto_type buffer = [NSMutableString stringWithCapacity:source.length];
    [source enumerateSubstringsInRange:NSMakeRange(0, source.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        [buffer appendString:([self isEmojiForString:substring])? @"": substring];
    }];

    return buffer;
}

@end
