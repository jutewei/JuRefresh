//
//  JuRRefresh.m
//  JuRefresh
//
//  Created by Juvid on 16/9/1.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshHead.h"
#import "UIView+JuLayGroup.h"
#define InsetH 65
#define RefreshH 64
@interface JuRefreshHead (){
    BOOL isBeginRefresh;///< 即将开始刷新
    UIImageView *imageView;
    BOOL isRefreshing;
}
@property (nonatomic,copy  ) dispatch_block_t ju_StartRefresh;//开始刷新
@end

@implementation JuRefreshHead

+(instancetype)juHeadWithhandle:(dispatch_block_t)handle{
    JuRefreshHead *refresh=[[self alloc]init];
    refresh.ju_StartRefresh=handle;
    return refresh;
}

-(void)juSetView{
    [super juSetView];
    self.frame=CGRectMake(0, -RefreshH, [[UIScreen mainScreen] bounds].size.width, RefreshH);
    self.labTitle.text=JuRefreshBegin;
    imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"arrow"];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:imageView];
    imageView.juTraSpace.toView(self.labTitle).equal(20);
    imageView.juCenterY.equal(0);

}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    CGPoint pointNew=[change[@"new"] CGPointValue];
    CGPoint pointOld=[change[@"old"] CGPointValue];
    [self juWillRefresh:pointNew];
    if (!scrollView.isDragging) { // 如果正在拖拽
        if (isRefreshing||pointOld.y==0) return;
        if (pointOld.y < -(ju_InsetTop+InsetH)) {
            [self juStartRefresh];
        }
    }
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
    [self juDidRefresh];
    isBeginRefresh=NO;
}
-(void)juWillRefresh:(CGPoint)contentOffset{
    if (isRefreshing) return;
    if (contentOffset.y<-(ju_InsetTop+InsetH)) {
        self.labTitle.text=JuRefreshPulling;
    }else{
        self.labTitle.text=JuRefreshBegin;
    }
    [self juStartAnimation:contentOffset.y<-(ju_InsetTop+InsetH)];
}
-(void)juDidRefresh{
    if (!scrollView||self.hidden) return;

    if (!self.window||!isBeginRefresh) return;

    ju_RefreshOffsetH=RefreshH;
    isRefreshing=YES;

    UIEdgeInsets contentInset= scrollView.contentInset;
    contentInset.top=ju_RefreshOffsetH+ju_InsetTop;
    [self.loadingAni startAnimating];
    imageView.hidden=isRefreshing;
    self.labTitle.text=JuRefreshIng;

    [UIView animateWithDuration:.3 animations:^{
        scrollView.contentInset = contentInset;
    } completion:^(BOOL finished) {

    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.ju_StartRefresh)  self.ju_StartRefresh();
    });
}
-(void)juStartRefresh{
    isBeginRefresh=YES;
    [self juDidRefresh];
}
-(void)juEndRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIEdgeInsets contentInset= scrollView.contentInset;
        contentInset.top=ju_InsetTop;
        [UIView animateWithDuration:0.35 animations:^{
            scrollView.contentInset=contentInset;
        } completion:^(BOOL finished) {
            isRefreshing=NO;
            imageView.hidden=isRefreshing;
            [self.loadingAni stopAnimating];
            self.labTitle.text=@"下拉开始刷新";
        }];
    });
}
- (void)juStartAnimation:(BOOL)Refresh{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(Refresh?-M_PI:2*M_PI);
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = endAngle;
    } completion:^(BOOL finished) {}];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
