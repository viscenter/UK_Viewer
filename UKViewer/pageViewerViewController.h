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
  //  UIImageView *bgController;
  //  UIImageView *layer1Controller;
    UIScrollView* zoomView;
}

@property (strong, nonatomic)UINavigationBar *navBar;
@property (strong, nonatomic)urn_cite *urn;
@property (strong, nonatomic)UIImage *backGround;
@property (strong, nonatomic) UIImageView *bgController;
@property (strong, nonatomic) IBOutlet UIScrollView *zoomView;
@property (strong, nonatomic) UIImageView *layer1Controller;
@property (strong, nonatomic) UISegmentedControl *seg ;
@property (strong, nonatomic) IBOutlet UIView * compositView;
@property (strong, nonatomic) UIImage *layer1;

-(void)getPage:(int)sender;

@end
