//
//  GifViewController.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/11.
//

#import "GifViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GifViewController ()

@property (nonatomic, strong) CALayer *gifLayer;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    // 获取 GIF 图片的路径
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"resource/gif/a" ofType:@"gif"];

    if (gifPath) {
        // 创建一个 CALayer
        self.gifLayer = [CALayer layer];
        self.gifLayer.frame = CGRectMake(50, 50, 200, 200); // 设置 Layer 的位置和尺寸

        // 读取 GIF 图片数据
        NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
        
        // 创建一个 GIF 动画对象
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        animation.values = [self createAnimationFramesFromData:gifData];
        animation.duration = animation.values.count * 0.1; // 设置动画的播放时长
        animation.repeatCount = HUGE_VALF; // 使动画无限循环播放
        
        // 将动画添加到 Layer 上
        [self.gifLayer addAnimation:animation forKey:@"gifAnimation"];
        
        // 将 Layer 添加到视图上
        [self.view.layer addSublayer:self.gifLayer];
    }
}

- (NSArray *)createAnimationFramesFromData:(NSData *)data {
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

