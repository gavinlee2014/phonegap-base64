#import <Cordova/CDVPlugin.h>

@interface Base64Plugin : CDVPlugin

- (void)encodeFile:(CDVInvokedUrlCommand*)command;

@end