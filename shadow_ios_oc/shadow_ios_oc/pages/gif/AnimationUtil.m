//
//  AnimationUtil.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/13.
//

#import "AnimationUtil.h"


@implementation AnimationUtil

+ (CAKeyframeAnimation *)getGifAnimationFromPath:(NSString *)gifPath repeatCount:(NSInteger)repeatCount {
    // 读取 GIF 图片数据
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    
    // 创建一个 GIF 动画对象
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.values = [self createAnimationFramesFromData:gifData];
    animation.duration = animation.values.count * 0.1; // 设置动画的播放时长
    animation.repeatCount = repeatCount == 0 ? HUGE_VALF : repeatCount; // 0使动画无限循环播放
    
    return animation;
}

+ (NSArray *)createAnimationFramesFromData:(NSData *)data {
    NSMutableArray *frames = [NSMutableArray array];
    
    // 使用 ImageIO 框架分解 GIF 图片为多帧图片
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (imageSource) {
        size_t count = CGImageSourceGetCount(imageSource);
        for (size_t i = 0; i < count; i++) {
            CGImageRef frameImage = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
            if (frameImage) {
                [frames addObject:(__bridge id)frameImage];
                CFRelease(frameImage);
            }
        }
        CFRelease(imageSource);
    }
    
    return frames;
}

@end
