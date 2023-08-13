//
//  AnimationUtil.h
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/13.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationUtil : NSObject

+ (CAKeyframeAnimation *)getGifAnimationFromPath:(NSString *)gifPath repeatCount:(NSInteger)repeatCount;
+ (NSArray *)createAnimationFramesFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
