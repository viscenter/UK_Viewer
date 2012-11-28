//
//  pageViewerViewController.h
//  UKViewer
//
//  Created by John B on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urn_cite.h"

@interface pageViewerViewController : UIViewController <UIScrollViewDelegate>{
    UIImageView *bgController;
    UIScrollView* zoomView;
}

@property (strong, nonatomic)UINavigationBar *navBar;
@property (strong, nonatomic)urn_cite *urn;
@property (strong, nonatomic)UIImage *backGround;
@property (strong, nonatomic) IBOutlet UIImageView *bgController;
@property (strong, nonatomic) IBOutlet UIScrollView *zoomView;

-(void)getPage:(int)sender;

@end
