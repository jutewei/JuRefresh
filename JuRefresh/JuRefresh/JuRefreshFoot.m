//
//  JuLoadMore.m
//  JuRefresh
//
//  Created by Juvid on 16/9/7.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#import "JuRefreshFoot.h"
#import "UIView+JuLayout.h"
#define LoadFootH 44

@interface JuRefreshFoot ()
@property (nonatomic,copy  ) shLoadNextPage ju_LoadMore;//开始刷新
@property (nonatomic,assign) JuLoadStatus ju_LoadStatus;
@end


@implementation JuRefreshFoot
@synthesize ju_LoadStatus;
-(void)juSetView{
    [super juSetView];
    self.frame=CGRectMake(0, scrollView.contentSize.height, [[UIScreen mainScreen] bounds].size.width, LoadFootH);
    self.labTitle.text=JuLoadMoreSuccess;
    self.hidden=YES;
}

+(instancetype)juFootWithhandle:(shLoadNextPage)handle{
    JuRefreshFoot *refresh=[[self alloc]init];
    refresh.ju_LoadMore=handle;
    return refresh;
}

-(void)juLoadMoreStatus:(JuLoadStatus)status{
    if (!scrollView) return;
    self.hidden=NO;
    ju_LoadStatus=status;
    switch (ju_LoadStatus) {
        case JuLoadStatusIng:{
            self.labTitle.text=JuLoadMoreIng;
            [self.loadingAni startAnimating];
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

    [self juSetScrollInset:10000];

}
/**自动刷新使用*/
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
//    scrollView.contentOffset.y>=(scrollView.contentSize.height-scrollView.frame.size.height)||
    if(scrollView.contentOffset.y>=scrollView.contentSize.height-scrollView.frame.size.height-80&&(int)(self.frame.origin.y)!=(int)(scrollView.contentSize.height)){
        [self juSetScrollInset:0];
    }
    if (_isAutoLoad) {
        [self juDidLoadMore];
    }
}
-(void)juSetScrollInset:(BOOL)estimatedHight{
    static BOOL isBusy=NO;
    if (isBusy) return;///< 防止重复执行

    isBusy=YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        CGRect selfFrame=self.frame;
        UIEdgeInsets insets= scrollView.contentInset;
        CGFloat bottom=LoadFootH;

        if (scrollView.contentSize.height<scrollView.frame.size.height) {
            bottom=0;
            selfFrame.origin.y=scrollView.frame.size.height-insets.top;
        }else{
            selfFrame.origin.y=scrollView.contentSize.height;
        }
        selfFrame.origin.y+=estimatedHight;
        self.frame=selfFrame;
        if(isFirstConfig){
            if (insets.bottom!=bottom&&(insets.bottom>=0&&insets.bottom<=44)) {
                insets.bottom=bottom+insets.bottom;
                scrollView.contentInset=insets;
            }
        }
        isBusy=NO;
    });
}

/**
 开始加载更多
 */
-(void)juDidLoadMore{
    if (self.ju_LoadMore&&!self.hidden&&scrollView.contentOffset.y>=scrollView.contentSize.height-scrollView.frame.size.height&&scrollView.contentOffset.y>0) {
        JuLoadStatus loadStatus=self.ju_LoadStatus;
        if (loadStatus==JuLoadStatusIng||loadStatus==JuLoadStatusFinish) return;
        else {
            [self juLoadMoreStatus:JuLoadStatusIng];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{///< 刷新延迟
                if (loadStatus==JuLoadStatusSuccess) {
                    self.ju_LoadMore(YES);
                }else{
                    return  self.ju_LoadMore(NO);
                }
            });
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
