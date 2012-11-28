//
//  mainViewViewController.m
//  UKViewer
//
//  Created by John B on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mainViewViewController.h"
#import "pageViewerViewController.h"

@interface mainViewViewController ()
@end

@implementation mainViewViewController
@synthesize myPage = myPage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addbackGroundImage];
    
    [self loadButtons];
    
    

    
}
-(void)addbackGroundImage
{
    CGRect const screensize =[[UIScreen mainScreen] bounds];

    
    UIImage *background = [[UIImage alloc] init];
    background = [UIImage  imageNamed:@"Chad_Cover_Image.jpg"];
    UIImageView *bgController = [[UIImageView alloc ]initWithImage:background];
    [bgController setFrame: screensize];
    [self.view addSubview:bgController];
    
}



- (void)loadButtons {
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    CGRect buttonFrame;
    
    buttonFrame.origin.x = screensize.size.width*8./10;
    buttonFrame.origin.y = screensize.size.height*9./10;

    buttonFrame.size.width = screensize.size.width*1/5;
    buttonFrame.size.height = screensize.size.height*1/20;
    
    UIButton *chadGospelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chadGospelButton setFrame:buttonFrame];
    [chadGospelButton setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
    [chadGospelButton setTitle:@"Go to page one" forState:UIControlStateNormal];
    [chadGospelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chadGospelButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:chadGospelButton];
    
}

-(void) buttonPressed
{
    if(!myPage)
    {
        myPage = [[pageViewerViewController alloc ]initWithNibName:@"pageViewerViewController" bundle:nil];
        //NSLog(@"alloc viewPage");
    }
    myPage .modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self addChildViewController:myPage];
    [myPage didMoveToParentViewController:self];
    [self.view addSubview:myPage.view];
    

    
}





- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  (interfaceOrientation == UIInterfaceOrientationPortrait) ;
}




@end
