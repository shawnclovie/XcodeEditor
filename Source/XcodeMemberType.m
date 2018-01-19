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

#import "XcodeMemberType.h"

static NSString* const kPBXNilType = @"PBXNilType";
static NSString* const kPBXBuildFile = @"PBXBuildFile";
static NSString* const kPBXContainerItemProxy = @"PBXContainerItemProxy";
static NSString* const kPBXCopyFilesBuildPhase = @"PBXCopyFilesBuildPhase";
static NSString* const kPBXFileReference = @"PBXFileReference";
static NSString* const kPBXFrameworksBuildPhase = @"PBXFrameworksBuildPhase";
static NSString* const kPBXGroup = @"PBXGroup";
static NSString* const kPBXNativeTarget = @"PBXNativeTarget";
static NSString* const kPBXProject = @"PBXProject";
static NSString* const kPBXReferenceProxy = @"PBXReferenceProxy";
static NSString* const kPBXResourcesBuildPhase = @"PBXResourcesBuildPhase";
static NSString* const kPBXShellScriptBuildPhase = @"PBXShellScriptBuildPhase";
static NSString* const kPBXSourcesBuildPhase = @"PBXSourcesBuildPhase";
static NSString* const kPBXTargetDependency = @"PBXTargetDependency";
static NSString* const kPBXVariantGroup = @"PBXVariantGroup";
static NSString* const kXCBuildConfiguration = @"XCBuildConfiguration";
static NSString* const kXCConfigurationList = @"XCConfigurationList";
static NSString* const kXCVersionGroup = @"XCVersionGroup";

static NSDictionary* DictionaryWithProjectNodeTypesAsStrings() {
    // This is the most vital operation on adding 500+ files
    // So, we caching this dictionary
    static NSDictionary* _projectNodeTypesAsStrings;
    if (_projectNodeTypesAsStrings) {
        return _projectNodeTypesAsStrings;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _projectNodeTypesAsStrings = @{
                                       kPBXNilType              : @(PBXNilType),
                                       kPBXBuildFile            : @(PBXBuildFileType),
                                       kPBXContainerItemProxy   : @(PBXContainerItemProxyType),
                                       kPBXCopyFilesBuildPhase  : @(PBXCopyFilesBuildPhaseType),
                                       kPBXFileReference        : @(PBXFileReferenceType),
                                       kPBXFrameworksBuildPhase : @(PBXFrameworksBuildPhaseType),
                                       kPBXGroup                : @(PBXGroupType),
                                       kPBXNativeTarget         : @(PBXNativeTargetType),
                                       kPBXProject              : @(PBXProjectType),
                                       kPBXReferenceProxy       : @(PBXReferenceProxyType),
                                       kPBXResourcesBuildPhase  : @(PBXResourcesBuildPhaseType),
                                       kPBXSourcesBuildPhase    : @(PBXSourcesBuildPhaseType),
                                       kPBXTargetDependency     : @(PBXTargetDependencyType),
                                       kPBXVariantGroup         : @(PBXVariantGroupType),
                                       kXCBuildConfiguration    : @(XCBuildConfigurationType),
                                       kXCConfigurationList     : @(XCConfigurationListType),
                                       kPBXShellScriptBuildPhase : @(PBXShellScriptBuildPhase),
                                       kXCVersionGroup          : @(XCVersionGroupType)
                                       };
    });
    return _projectNodeTypesAsStrings;
}

@implementation XCMemberHelper
+ (XcodeMemberType)asMemberType:(NSObject *)value {
	NSDictionary* nodeTypesToString = DictionaryWithProjectNodeTypesAsStrings();
	return (XcodeMemberType) [nodeTypesToString[value] intValue];
}
+ (BOOL)hasFileReferenceType:(NSObject *)value {
	return [kPBXFileReference isEqual:value];
}
+ (BOOL)hasFileReferenceOrReferenceProxyType:(NSObject *)value {
	return [kPBXFileReference isEqual:value] || [kPBXReferenceProxy isEqual:value];
}
+ (BOOL)hasReferenceProxyType:(NSObject *)value {
	return [kPBXReferenceProxy isEqual:value];
}
+ (BOOL)hasGroupType:(NSObject *)value {
	return [kPBXGroup isEqual:value] || [kPBXVariantGroup isEqual:value];
}
+ (BOOL)hasProjectType:(NSObject *)value {
	return [kPBXProject isEqual:value];
}
+ (BOOL)hasNativeTargetType:(NSObject *)value {
	return [kPBXNativeTarget isEqual:value];
}
+ (BOOL)hasBuildFileType:(NSObject *)value {
	return [kPBXBuildFile isEqual:value];
}
+ (BOOL)hasBuildConfigurationType:(NSObject *)value {
	return [kXCBuildConfiguration isEqual:value];
}
+ (BOOL)hasContainerItemProxyType:(NSObject *)value {
	return [kPBXContainerItemProxy isEqual:value];
}
+ (BOOL)hasResourcesBuildPhaseType:(NSObject *)value {
	return [kPBXResourcesBuildPhase isEqual:value];
}
+ (BOOL)hasShellScriptBuildPhase:(NSObject *)value {
	return [kPBXShellScriptBuildPhase isEqual:value];
}
+ (BOOL)hasSourcesOrFrameworksBuildPhaseType:(NSObject *)value {
	return [kPBXSourcesBuildPhase isEqual:value] || [kPBXFrameworksBuildPhase isEqual:value];
}
+ (BOOL)hasVersionedGroupType:(NSObject *)value {
	return [kXCVersionGroup isEqual:value];
}
@end

@implementation NSString (XcodeMemberTypeExtensions)

+ (NSString*)xce_stringFromMemberType:(XcodeMemberType)nodeType {
    NSDictionary* nodeTypesToString = DictionaryWithProjectNodeTypesAsStrings();
    return [[nodeTypesToString allKeysForObject:@(nodeType)] firstObject];
}
@end
