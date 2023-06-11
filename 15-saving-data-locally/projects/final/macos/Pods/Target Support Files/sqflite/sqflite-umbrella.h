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

#import "SqfliteCursor.h"
#import "SqfliteDatabase.h"
#import "SqfliteImport.h"
#import "SqfliteOperation.h"
#import "SqflitePlugin.h"

FOUNDATION_EXPORT double sqfliteVersionNumber;
FOUNDATION_EXPORT const unsigned char sqfliteVersionString[];

