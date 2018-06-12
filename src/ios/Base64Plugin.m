#import <Cordova/CDV.h>
#import "Base64Plugin.h"

@implementation Base64Plugin
//#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

//static char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

//static char decodingTable[128];
//+ (void) initialize {
//
//    if (self == [Base64Plugin class]) {
//
//        memset(decodingTable, 0, ArrayLength(decodingTable));
//
//        for (NSInteger i = 0; i < ArrayLength(encodingTable); i++) {
//
//            decodingTable[encodingTable[i]] = i;
//
//        }
//
//    }
//
//}

//- (NSString*) encode:(const uint8_t*) input length:(NSInteger) length {
//    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
//    uint8_t* output = (uint8_t*)data.mutableBytes;
//    for (NSInteger i = 0; i < length; i += 3) {
//        NSInteger value = 0;
//        for (NSInteger j = i; j < (i + 3); j++) {
//            value <<= 8;
//            if (j < length) {
//                value |= (0xFF & input[j]);
//            }
//        }
//
//        NSInteger index = (i / 3) * 4;
//        output[index + 0] = encodingTable[(value >> 18) & 0x3F];
//        output[index + 1] = encodingTable[(value >> 12) & 0x3F];
//        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
//        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
//    }
//
//    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//}
//
//
//
//- (NSString*) encode:(NSData*) rawBytes {
//    return [self encode:(const uint8_t*) rawBytes.bytes length:rawBytes.length];
//}



- (void)encodeFile:(CDVInvokedUrlCommand*)command {
    NSString * filePath =  [command.arguments objectAtIndex:0][@"filePath"];
    
    if ([filePath hasPrefix:@"file://"]) {
        filePath = [filePath substringFromIndex:[@"file://" length]];
    }
    NSData * data = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
    NSString * base64 = [NSString stringWithUTF8String:[[data base64EncodedDataWithOptions:0] bytes]];
    NSLog(@"%@", base64);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:base64];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end