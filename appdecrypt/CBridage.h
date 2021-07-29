//
//  CBridage.h
//  appdecrypt
//
//  Created by paradiseduo on 2021/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBridage : NSObject
+ (int)encrypted:(void *)base cryptsize:(size_t)cryptsize cryptid:(uint32_t)cryptid;
@end

NS_ASSUME_NONNULL_END
