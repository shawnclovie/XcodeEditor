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

#import <Foundation/Foundation.h>

typedef enum
{
    SourceTreeSDKRoot,
	SourceTreeProjectRoot,
    SourceTreeGroup
} XcodeSourceTreeType;

@interface XcodeSourceTreeTypeHelper : NSObject

+ (NSString*)stringFromSourceTreeType:(XcodeSourceTreeType)nodeType;

+ (XcodeSourceTreeType)asSourceTreeType:(NSString *)string;

@end

