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



#import "XcodeSourceFileType.h"

static NSDictionary* NSDictionaryWithXCFileReferenceTypes()
{
    static NSDictionary* dictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        dictionary = @{
            @"sourcecode.c.h"        : @(SourceCodeHeader),
            @"sourcecode.c.objc"     : @(SourceCodeObjC),
			@"sourcecode.cpp.objcpp" : @(SourceCodeObjCPlusPlus),
			@"sourcecode.cpp.cpp"    : @(SourceCodeCPlusPlus),
			@"sourcecode.swift"      : @(SourceCodeSwift),
			@"sourcecode.javascript": @(XcodeSourceFileTypeJavaScript),

			@"wrapper.application"   : @(Application),
			@"wrapper.cfbundle"      : @(Bundle),
            @"wrapper.framework"     : @(Framework),
			@"wrapper.plug-in": @(Bundle),
			@"wrapper.pb-project"    : @(XcodeProject),
			@"wrapper.xcconfig"         : @(XCConfig),
			@"wrapper.xcdatamodel": @(XCDataModel),

			@"text"                  : @(TEXT),
			@"text.html"             : @(HTML),
			@"text.json": @(XcodeSourceFileTypeJSON),
			@"text.plist.strings"    : @(PropertyList),
			@"text.plist.xml"        : @(XMLPropertyList),
			@"text.script.sh"        : @(ShellScript),
			@"text.xcconfig"         : @(XCConfig),

			@"file": @(XcodeSourceFileTypeBinaryFile),
			@"file.xib"              : @(XibFile),
			@"file.playground"       : @(Playground),
			@"file.storyboard"       : @(Storyboard),
			@"file.strings": @(LocalizableStrings),
			@"folder"                : @(Folder),
			@"folder.assetcatalog"   : @(AssetCatalog),
			
			@"archive.ar"            : @(Archive),
//			@"compiled.mach-o.dylib": @(),
//			@"image.icns": ?,
            @"image.png"             : @(ImageResourcePNG),
            @"net.daringfireball.markdown" : @(Markdown),
        };
    });

    return dictionary;
}

NSString* NSStringFromXCSourceFileType(XcodeSourceFileType type)
{
    return [[NSDictionaryWithXCFileReferenceTypes() allKeysForObject:@(type)] objectAtIndex:0];
}

XcodeSourceFileType XCSourceFileTypeFromStringRepresentation(NSString* string)
{
    NSDictionary* typeStrings = NSDictionaryWithXCFileReferenceTypes();

    if (typeStrings[string])
    {
        return (XcodeSourceFileType) [typeStrings[string] intValue];
    }
    else
    {
        return FileTypeNil;
    }
}


XcodeSourceFileType XCSourceFileTypeFromFileName(NSString* fileName)
{
	__auto_type ext = fileName.pathExtension;
	if ([ext isEqualToString:@"framework"]) {
		return Framework;
	}
	if ([ext isEqualToString:@"a"]) {
		return Archive;
	}
    if ([ext isEqualToString:@"h"] || [ext isEqualToString:@"hh"] || [ext isEqualToString:@"hpp"] || [ext isEqualToString:@"hxx"])
    {
        return SourceCodeHeader;
    }
    if ([ext isEqualToString:@"c"] || [ext isEqualToString:@"m"])
    {
        return SourceCodeObjC;
    }
    if ([ext isEqualToString:@"mm"])
    {
        return SourceCodeObjCPlusPlus;
    }
    if ([ext isEqualToString:@"cpp"])
    {
        return SourceCodeCPlusPlus;
    }
    if ([ext isEqualToString:@"swift"])
    {
        return SourceCodeSwift;
    }
    if ([ext isEqualToString:@"xcdatamodel"])
    {
        return XCDataModel;
    }
    if ([ext isEqualToString:@"strings"])
    {
        return LocalizableStrings;
    }
	if ([ext isEqualToString:@"json"]) {
		return XcodeSourceFileTypeJSON;
	}
	if ([ext isEqualToString:@"js"]) {
		return XcodeSourceFileTypeJavaScript;
	}
    if ([ext isEqualToString:@"plist"])
    {
        return PropertyList;
    }
	if ([ext isEqualToString:@"png"]) {
		return ImageResourcePNG;
	}
	if ([ext isEqualToString:@"nib"]) {
		return XcodeSourceFileTypeBinaryFile;
	}
	if ([ext isEqualToString:@"html"]) {
		return HTML;
	}
	if ([ext isEqualToString:@"txt"]) {
		return TEXT;
	}
	if ([ext isEqualToString:@"xib"]) {
		return XibFile;
	}
	if ([ext isEqualToString:@"bundle"]) {
		return Bundle;
	}
	if ([ext isEqualToString:@"md"] || [ext isEqualToString:@"markdown"]) {
		return Markdown;
	}
    return FileTypeNil;
}

BOOL CanXcodeSourceFileTypeBeBuildFile(XcodeSourceFileType type) {
	return type == SourceCodeObjC
	|| type == SourceCodeObjCPlusPlus
	|| type == SourceCodeCPlusPlus
	|| type == XibFile
	|| type == Framework
	|| type == ImageResourcePNG
	|| type == HTML
	|| type == Bundle
	|| type == Archive
	|| type == AssetCatalog
	|| type == SourceCodeSwift
	|| type == PropertyList
	|| type == LocalizableStrings
	|| type == XcodeSourceFileTypeBinaryFile
	|| type == XcodeSourceFileTypeJSON
	|| type == XcodeSourceFileTypeJavaScript;
}

XcodeMemberType GetBuildPhaseForSourceType(XcodeSourceFileType type) {
	switch (type) {
		case SourceCodeObjC:
		case SourceCodeObjCPlusPlus:
		case SourceCodeCPlusPlus:
		case SourceCodeSwift:
		case XibFile:
			return PBXSourcesBuildPhaseType;
		case Framework:
			return PBXFrameworksBuildPhaseType;
		case ImageResourcePNG:
		case HTML:
		case Bundle:
		case AssetCatalog:
		case PropertyList:
		case LocalizableStrings:
		case XcodeSourceFileTypeJSON:
		case XcodeSourceFileTypeJavaScript:
		case XcodeSourceFileTypeBinaryFile:
		case TEXT:
		case Markdown:
		case XMLPropertyList:
			return PBXResourcesBuildPhaseType;
		case Archive:
			return PBXFrameworksBuildPhaseType;
		default:
			return PBXNilType;
	}
}
