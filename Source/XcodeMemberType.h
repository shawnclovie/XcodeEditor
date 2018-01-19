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
    PBXNilType,
    PBXBuildFileType,
    PBXContainerItemProxyType,
    PBXCopyFilesBuildPhaseType,
    PBXFileReferenceType,
    PBXFrameworksBuildPhaseType,
    PBXGroupType,
    PBXNativeTargetType,
    PBXProjectType,
    PBXReferenceProxyType,
    PBXResourcesBuildPhaseType,
    PBXSourcesBuildPhaseType,
    PBXTargetDependencyType,
    PBXVariantGroupType,
    XCBuildConfigurationType,
    XCConfigurationListType,
    PBXShellScriptBuildPhase,
    XCVersionGroupType
} XcodeMemberType;

@interface XCMemberHelper : NSObject
+ (XcodeMemberType)asMemberType:(NSObject *)value;
+ (BOOL)hasFileReferenceType:(NSObject *)value;
+ (BOOL)hasFileReferenceOrReferenceProxyType:(NSObject *)value;
+ (BOOL)hasReferenceProxyType:(NSObject *)value;
+ (BOOL)hasGroupType:(NSObject *)value;
+ (BOOL)hasProjectType:(NSObject *)value;
+ (BOOL)hasNativeTargetType:(NSObject *)value;
+ (BOOL)hasBuildFileType:(NSObject *)value;
+ (BOOL)hasBuildConfigurationType:(NSObject *)value;
+ (BOOL)hasContainerItemProxyType:(NSObject *)value;
+ (BOOL)hasResourcesBuildPhaseType:(NSObject *)value;
+ (BOOL)hasShellScriptBuildPhase:(NSObject *)value;
+ (BOOL)hasSourcesOrFrameworksBuildPhaseType:(NSObject *)value;
+ (BOOL)hasVersionedGroupType:(NSObject *)value;
@end

@interface NSString (XcodeMemberTypeExtensions)

+ (NSString*)xce_stringFromMemberType:(XcodeMemberType)nodeType;

@end

