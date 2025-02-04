/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

#import "RNSplashScreen.h"
#import <React/RCTBridge.h>

static bool waiting = true;
static bool addedJsLoadErrorObserver = false;
static UIView* loadingView = nil;
static UIView* parentView = nil;
static NSString* splash = nil;

@implementation RNSplashScreen
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE(SplashScreen)

+ (void)show {
    if (!loadingView) {
        // load from storyboard
        UIStoryboard *launchSb = [UIStoryboard storyboardWithName:splashScreen bundle:nil];
        UIViewController *launchSbVC = [launchSb instantiateInitialViewController];
        loadingView = launchSbVC.view;

        // load from nib: not working
        //NSArray *launchNib = [[NSBundle mainBundle] loadNibNamed:splashScreen owner:self options:nil];
        //loadingView = [launchNib objectAtIndex:0];

        CGRect frame = parentView.frame;
        frame.origin = CGPointMake(0, 0);
        loadingView.frame = frame;
    }
    waiting = false;

    [parentView addSubview:loadingView];
}

+ (void)showSplash:(NSString*)splashScreen inRootView:(UIView*)rootView {
    parentView = rootView;
    splash = splashScreen;
    [RNSplashScreen show];
}

+ (void)hide {
    if (waiting) {
        dispatch_async(dispatch_get_main_queue(), ^{
            waiting = false;
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{loadingView.alpha = 0.0;}
                             completion:^(BOOL finished){ [loadingView removeFromSuperview]; }];
        });
    }
}

+ (void) jsLoadError:(NSNotification*)notification
{
    // If there was an error loading javascript, hide the splash screen so it can be shown.  Otherwise the splash screen will remain forever, which is a hassle to debug.
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(hide) {
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(show) {
    [RNSplashScreen show];
}

@end
