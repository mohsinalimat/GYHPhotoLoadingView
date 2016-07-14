//
//  SectorProgressViewController.m
//  GYHPhotoLoadingView
//
//  Created by 范英强 on 16/7/13.
//  Copyright © 2016年 gyh. All rights reserved.
//
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "SectorProgressViewController.h"
#import "GYHSectorProgressView.h"
#import "UIImageView+WebCache.h"

@interface SectorProgressViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation SectorProgressViewController
{
    GYHSectorProgressView *progressV;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    
    progressV = [[GYHSectorProgressView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 22)/2,(SCREEN_HEIGHT - 22)/2, 22, 22)];
    progressV.progressColor = [UIColor colorWithWhite:1 alpha:0.7];
    progressV.progressStrokeWidth = 22.0f;
    progressV.progressTrackColor = [UIColor clearColor];
    [self.view addSubview:progressV];
    
    __weak __typeof__(self) block_self = self;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        [block_self animate:progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        progressV.hidden = YES;
    }];
}

- (void)animate:(CGFloat)progress {
    progressV.progressValue = progress;
}



@end