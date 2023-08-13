//
//  GifViewController.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/11.
//

#import "GifViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AnimationUtil.h"

@interface GifViewController ()

@property (nonatomic, strong) CALayer *gifLayer;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    // 创建一个 CALayer
    self.gifLayer = [CALayer layer];
    self.gifLayer.frame = CGRectMake(50, 50, 200, 200); // 设置 Layer 的位置和尺寸
    
    // 获取 GIF 图片的路径
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"resource/gif/a" ofType:@"gif"];

    if (gifPath) {
        // 创建一个 GIF 动画对象
        CAKeyframeAnimation *animation = [AnimationUtil getGifAnimationFromPath:gifPath repeatCount:0];
        // 将动画添加到 Layer 上
        [self.gifLayer addAnimation:animation forKey:@"aGifAnimation"];
    }
    
    // 将 Layer 添加到视图上
    [self.view.layer addSublayer:self.gifLayer];

    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 500, 100, 60);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.text = @"click";
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click:(id)sender {
    [self.gifLayer removeAnimationForKey:@"aGifAnimation"];
    
    // 获取 GIF 图片的路径
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"resource/gif/b" ofType:@"gif"];
    if (gifPath) {
        // 创建一个 GIF 动画对象
        CAKeyframeAnimation *animation = [AnimationUtil getGifAnimationFromPath:gifPath repeatCount:0];
        // 将动画添加到 Layer 上
        [self.gifLayer addAnimation:animation forKey:@"bGifAnimation"];
    }
}

@end

