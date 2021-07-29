//
//  CBridage.m
//  appdecrypt
//
//  Created by paradiseduo on 2021/7/29.
//

#import "CBridage.h"

extern int mremap_encrypted(void*, size_t, uint32_t, uint32_t, uint32_t);

@implementation CBridage
+ (int)encrypted:(void *)base cryptsize:(size_t)cryptsize cryptid:(uint32_t)cryptid {
    return mremap_encrypted(base, cryptsize, cryptid, CPU_TYPE_ARM64, CPU_SUBTYPE_ARM64_ALL);
}
@end
