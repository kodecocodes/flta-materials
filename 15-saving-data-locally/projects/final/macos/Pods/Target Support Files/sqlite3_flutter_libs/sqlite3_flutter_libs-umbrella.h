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

#import "Sqlite3FlutterLibsPlugin.h"

FOUNDATION_EXPORT double sqlite3_flutter_libsVersionNumber;
FOUNDATION_EXPORT const unsigned char sqlite3_flutter_libsVersionString[];

