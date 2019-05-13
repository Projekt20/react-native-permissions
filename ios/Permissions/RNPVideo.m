//
//  RNPVideo.m
//  ReactNativePermissions
//
//  Created by Yonah Forst on 11/07/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

#import "RNPVideo.h"

#import <AVFoundation/AVFoundation.h>

@implementation RNPVideo

+ (NSString *)getStatus
{
    int status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
            return RNPStatusAuthorized;
        case AVAuthorizationStatusDenied:
            return RNPStatusDenied;
        case AVAuthorizationStatusRestricted:
            return RNPStatusRestricted;
        default:
            return RNPStatusUndetermined;
    }
}

+ (void)request:(NSString *)type completionHandler:(void (^)(NSString *))completionHandler
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                             completionHandler:^(BOOL granted) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completionHandler([RNPVideo getStatus]);
                                 });
                             }];
}

@end
