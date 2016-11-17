//
//  JuLoadMore.m
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuRefreshFoot.h"
//#import "UIView+JuLayout.h"
#define LoadFootH 44

@implementation JuRefreshFoot
@synthesize ju_LoadStatus;
-(void)juSetView{
    [super juSetView];
    self.frame=CGRectMake(0, scrollView.contentSize.height, [[UIScreen mainScreen] bounds].size.width, LoadFootH);
    self.labTitle.text=JuLoadMoreSuccess;
    self.hidden=YES;
}
-(void)juLoadMoreStatus:(JuLoadStatus)status{
    if (!scrollView) return;
    self.hidden=NO;
    ju_LoadStatus=status;
    switch (ju_LoadStatus) {
        case JuLoadStatusIng:{
            self.labTitle.text=JuLoadMoreIng;
            [self.loadingAni startAnimating];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self juLoadMoreStatus:JuLoadStatusFinish];
//            });
        }
            break;
        case JuLoadStatusFinish:{
            self.labTitle.text=JuLoadMoreFinish;
             [self.loadingAni stopAnimating];
        }
            break;
        case JuLoadStatusSuccess:{
            self.labTitle.text=JuLoadMoreSuccess;
             [self.loadingAni stopAnimating];
        }
            break;
        case JuLoadStatusFailure:{
            self.labTitle.text=juLoadMoreFaliure;
            [self.loadingAni stopAnimating];
        }
            break;
        default:
            break;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self juSetScrollInset];
//    });

}
/**自动刷新使用*/
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if(scrollView.decelerating){
        [self juSetScrollInset];
    }
    if (self.ju_LoadMore&&!self.hidden) {
        if(scrollView.isDragging&&scrollView.contentOffset.y>=scrollView.contentSize.height-scrollView.frame.size.height&&scrollView.contentOffset.y>0){
            if (self.ju_LoadStatus==JuLoadStatusIng||self.ju_LoadStatus==JuLoadStatusFinish) return;
            else {
                if (self.ju_LoadStatus==JuLoadStatusSuccess) {
                     self.ju_LoadMore(@"1");
                }else{
                    self.ju_LoadMore(@"2");
                }
            }
        }
    }
}
-(void)juSetScrollInset{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect selfFrame=self.frame;
        UIEdgeInsets insets= scrollView.contentInset;
        CGFloat bottom=LoadFootH;

        if (scrollView.contentSize.height<scrollView.frame.size.height) {
            bottom=0;
            selfFrame.origin.y=scrollView.frame.size.height-insets.top;
        }else{
            selfFrame.origin.y=scrollView.contentSize.height;
        }
        self.frame=selfFrame;
        if(isFirstConfig){
            if (insets.bottom!=bottom&&(insets.bottom>=0&&insets.bottom<=44)) {
                insets.bottom=bottom+insets.bottom;
                scrollView.contentInset=insets;
            }
        }
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
