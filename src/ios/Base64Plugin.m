#import <Cordova/CDV.h>
#import "Base64Plugin.h"

@implementation Base64Plugin

- (void)encodeFile:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        NSString * filePath =  [command.arguments objectAtIndex:0][@"filePath"];
        
        if ([filePath hasPrefix:@"file://"]) {
            filePath = [filePath substringFromIndex:[@"file://" length]];
        }
        NSData * data = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
        NSString * base64 = [NSString stringWithUTF8String:[[data base64EncodedDataWithOptions:0] bytes]];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:base64];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)encodeString:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        NSString * content =  [command.arguments objectAtIndex:0][@"content"];
        
        NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
        NSString * base64 = [NSString stringWithUTF8String:[[data base64EncodedDataWithOptions:0] bytes]];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:base64];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}


@end
