#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "sqlite3.h"
#import "sqlite3ext.h"
#import "sqlite3session.h"
#import "sqlite_cfg.h"

FOUNDATION_EXPORT double sqlite3VersionNumber;
FOUNDATION_EXPORT const unsigned char sqlite3VersionString[];

