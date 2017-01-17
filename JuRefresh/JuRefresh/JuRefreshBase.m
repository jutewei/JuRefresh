//
//  JuRefreshBase.m
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshBase.h"
#import "UIView+JuLayGroup.h"
@implementation JuRefreshBase
//+(instancetype)juHeadWithhandle:(dispatch_block_t)handle{
//    JuRefreshBase *refresh=[[self alloc]init];
//    refresh.ju_StartRefresh=handle;
//    return refresh;
//}
//+(instancetype)juFootWithhandle:(shLoadNextPage)handle{
//    JuRefreshBase *refresh=[[self alloc]init];
//    refresh.ju_LoadMore=handle;
//    return refresh;
//}
//+(instancetype)juFoot{
//    return [self juFootWithhandle:nil];
//}
-(instancetype)init{
    self=[super init];
    if (self) {
        [self juSetView];
    }
    return self;
}
//-(void)dealloc{
//    [scrollView removeObserver:self forKeyPath:@"contentOffset"];
//}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

-(void)didMoveToWindow{
    if (!isFirstConfig) {
        isFirstConfig=YES;
        ju_InsetTop=scrollView.contentInset.top-ju_RefreshOffsetH;
        ju_InsetBottom=scrollView.contentInset.bottom;
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
    if (newSuperview) {
        scrollView=(UIScrollView *)newSuperview;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}

-(void)juSetView{

    _labTitle=[[UILabel alloc]init];
    _labTitle.textColor=[UIColor grayColor];
    _labTitle.font=[UIFont systemFontOfSize:14];
    [self addSubview:_labTitle];
    _labTitle.juOrigin(CGPointMake(0, 0));

    _loadingAni = [[UIActivityIndicatorView alloc] init];
    _loadingAni.hidesWhenStopped=YES;
    _loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:_loadingAni];
    _loadingAni.juTraSpace.toView(_labTitle).equal(10);
    _loadingAni.juCenterY.equal(0);

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
