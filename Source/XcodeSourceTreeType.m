////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "XcodeSourceTreeType.h"

static NSString* const kPBXSourceTreeSKRoot= @"SDKROOT";
static NSString* const kPBXSourceTreeGroup = @"<group>";
static __auto_type const kPBXSourceTreeProjectRoot = @"SOURCE_ROOT";

static NSDictionary* DictionaryWithProjectSourceTreeTypesAsStrings() {
    // This is the most vital operation on adding 500+ files
    // So, we caching this dictionary
    static NSDictionary* _projectNodeTypesAsStrings;
    if (_projectNodeTypesAsStrings) {
        return _projectNodeTypesAsStrings;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _projectNodeTypesAsStrings = @{
                                       kPBXSourceTreeSKRoot              : @(SourceTreeSDKRoot),
                                       kPBXSourceTreeGroup            : @(SourceTreeGroup),
									   kPBXSourceTreeProjectRoot: @(SourceTreeProjectRoot),
                                       };
    });
    return _projectNodeTypesAsStrings;
}

@implementation XcodeSourceTreeTypeHelper

+ (NSString*)stringFromSourceTreeType:(XcodeSourceTreeType)nodeType {
    NSDictionary* nodeTypesToString = DictionaryWithProjectSourceTreeTypesAsStrings();
    return [[nodeTypesToString allKeysForObject:@(nodeType)] firstObject];
}


+ (XcodeSourceTreeType)asSourceTreeType:(NSString *)string {
    NSDictionary* nodeTypesToString = DictionaryWithProjectSourceTreeTypesAsStrings();
    return (XcodeSourceTreeType) [nodeTypesToString[string] intValue];
}

@end
