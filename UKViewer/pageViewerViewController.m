//
//  pageViewerViewController.m
//  UKViewer
//
//  Created by John B on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define BACKGROUND_TAG 100
#define LAYER_1_TAG 200
#define COMP_VIEW_TAG 300

#import "pageViewerViewController.h"

@interface pageViewerViewController ()

@end

@implementation pageViewerViewController
@synthesize navBar= navBar;
@synthesize urn = urn;
@synthesize backGround = backGround;
@synthesize bgController = bgController;
@synthesize layer1Controller = layer1Controller;
@synthesize zoomView = zoomView;
@synthesize seg = seg;
@synthesize compositView = compositView;
@synthesize layer1 = layer1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
        [self setUp_urn_cite_Class];
        
        [self addbackGroundImage];
        
        [self addNavBar];
        
        [self guesterEvents];
        
        
    }
    
    return self;
}

-(void)getPage:(int)sender{

    
}

-(void)buttonPressed{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    return;
}


-(void) addNavBar{
    
    //Create NavBar
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    CGRect navFrame;
    
    //Nav Frame 
    navFrame.size.width = screensize.size.width;
    navFrame.size.height= screensize.size.height/10;
    navFrame.origin.x=screensize.origin.x;
    navFrame.origin.y=screensize.size.height - navFrame.size.height;
    
    //Display NavBar
    navBar= [[UINavigationBar alloc] initWithFrame:navFrame];
    [self.view addSubview:navBar];
    
    //Create Button
    UIButton *chadGospelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect buttonFrame;
    
    //button Frame
    buttonFrame.origin.x = 0;
    buttonFrame.origin.y = 0;
    buttonFrame.size.width = navBar.frame.size.height * 8/10;
    buttonFrame.size.height = navBar.frame.size.height* 8/10;    
    
    // set up what button does
    [chadGospelButton setFrame:buttonFrame];
    [chadGospelButton setBackgroundImage:[UIImage imageNamed:@"home_button.png"] forState:UIControlStateNormal];
    [chadGospelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chadGospelButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //display button
    [navBar addSubview:chadGospelButton];
    
    
    //Create Progress Bar
    UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    CGRect progFrame;
    
    //Progress Bar Frame
    //progFrame.origin.x = buttonFrame.size.width + navFrame.size.width / 20;
    progFrame.origin.x = navFrame.size.width/3;
    progFrame.origin.y = navFrame.size.height*1/3;
    progFrame.size.height = navFrame.size.height;
    progFrame.size.width = navFrame.size.width/3;
    
    //Display Progress Bar
    [progress setFrame:progFrame];
    [navBar addSubview:progress];

    //creat seg control
    
    //seg Frame
    CGRect segFrame;
    segFrame.origin.x = navFrame.size.width * 8/10;
    segFrame.origin.y = navFrame.size.height*1/6;
    segFrame.size.width = navFrame.size.width/6;
    segFrame.size.height = navFrame.size.height/2;
    
    //create the seg layers
    seg = [[UISegmentedControl alloc ] initWithFrame: segFrame];
    [seg insertSegmentWithTitle:@"layer0" atIndex:0 animated:NO];
    [seg insertSegmentWithTitle:@"layer1" atIndex:1 animated:NO];
    
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];

    //add seg to the nave bar
    [navBar addSubview:seg];    
    return;
}

-(void) setUp_urn_cite_Class
{
   // if (urn) NSLog(@"true");
    
    if(!urn){
        urn = [[urn_cite alloc] initWithMachine:@"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=" 
                                           size:@"1000" 
                                           base:@"urn:cite:fufolioimg:"
                                           type:@"ChadRGB." 
                                            doc:@"Chad"
                                           crop:@":0.07,0.08,0.8.8,0.79&w="];
    
    
     //   urn = [[urn_cite alloc] init];
        NSLog(@"alloc urn");
    }
   
    
    
    return;
}

-(void) addbackGroundImage{
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    
    //UIImage
    backGround= [[UIImage alloc] init];
    backGround = [urn startImage];

    //UIScrollView
    zoomView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
    [zoomView setFrame:screensize];
    [zoomView setBounces:NO];
    
    [zoomView setBackgroundColor:[UIColor blackColor]];
    [zoomView setDelegate:self];
    [self.view addSubview:zoomView];
    
    
    //float minimumScale = [zoomView frame].size.width  / [bgController frame].size.width;
    float minimumScale = 1;
    float maxScale = 10;
    
    [zoomView setMaximumZoomScale:maxScale];
    [zoomView setMinimumZoomScale:minimumScale];
    [zoomView setZoomScale:minimumScale];
    [zoomView setScrollsToTop:YES];
     
    
    
    //Composite view
    compositView = [[UIView alloc] initWithFrame:screensize];
    [compositView setTag:COMP_VIEW_TAG];
    [zoomView addSubview:compositView];


    //Layer one
    layer1 = [[UIImage alloc] init];
    layer1 = [UIImage imageNamed:@"vandalized.jpg"];
    
    //UIImageView background image (layer 0)
    bgController = [[UIImageView alloc ]initWithImage:backGround];
    [bgController setFrame: [zoomView frame] ];
    [bgController setTag:BACKGROUND_TAG];
    
    [compositView addSubview:bgController];

    

    
    layer1Controller = [[UIImageView alloc] initWithImage:layer1];
    [bgController setFrame: [zoomView frame] ];
    [layer1Controller setTag:LAYER_1_TAG];
    [compositView addSubview:layer1Controller];
    
    
    

    

}
/*
-(void)loadButtons{
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    CGRect buttonFrame;
    

    
    UIButton *chadGospelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chadGospelButton setFrame:buttonFrame];
    [chadGospelButton setBackgroundImage:[UIImage imageNamed:@"home_button.png"] forState:UIControlStateNormal];
    [chadGospelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chadGospelButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:chadGospelButton];
    
}
*/
-(void) guesterEvents{

//ADDING GESTURES

    //Pinch
/*    UIPinchGestureRecognizer *twoFingerPinch =  [[UIPinchGestureRecognizer alloc] 
                                                 initWithTarget:self action:@selector(twoFingerPinch:)];
    [[self view] addGestureRecognizer:twoFingerPinch];

    //Rotate
    UIRotationGestureRecognizer *twoFingersRotate = [[UIRotationGestureRecognizer alloc] 
                                                     initWithTarget:self action:@selector(twoFingersRotate:)];
    [[self view] addGestureRecognizer:twoFingersRotate];


    //Pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] 
                                   initWithTarget:self action:@selector(pan:)];
    [pan setMaximumNumberOfTouches:1];
    [[self view] addGestureRecognizer:pan];
    [pan setEnabled:NO];

    //One finger Two taps
    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc] 
                                                initWithTarget:self action:@selector(oneFingerTwoTaps:)];
    [oneFingerTwoTaps setNumberOfTapsRequired:2];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:oneFingerTwoTaps];

    //Two fingers two taps
    UITapGestureRecognizer *twoFingersTwoTapsOBJ = [[UITapGestureRecognizer alloc] 
                                                    initWithTarget:self action:@selector(twoFingersTwoTaps:)] ;
    [twoFingersTwoTapsOBJ setNumberOfTapsRequired:2];
    [twoFingersTwoTapsOBJ setNumberOfTouchesRequired:2];
    [[self view] addGestureRecognizer:twoFingersTwoTapsOBJ];
    */
    
  
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] 
                                            initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection: UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:swipeLeft];

    
}





-(void)twoFingerPinch :(UIPinchGestureRecognizer *) recognizer
{
    NSLog(@"in pinch");
/*
    float currentzoom =  [zoomView zoomScale];
    
    [zoomView setZoomScale:.5];
     [bgController setFrame: [zoomView frame] ];
 */
    /*
    #define ZOOM_STEP 1.5
    float newScale;
    if( [recognizer scale] < 0) 
        newScale = [zoomView zoomScale] * ZOOM_STEP;
    else 
        newScale = [zoomView zoomScale] / ZOOM_STEP;

    NSLog(@"numbers scale %f , new scale %f",[zoomView zoomScale], newScale);
    CGRect zoomRect = [self zoomRectForScale:newScale*100 withCenter:[recognizer locationInView:recognizer.view]];
    NSLog(@" %f, %f   %f, %f", zoomRect.origin.x , zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height);
    [zoomView zoomToRect:zoomRect animated:YES];
    [bgController setFrame: [zoomView frame] ];
*/
     
}



#pragma mark UIScrollViewDelegate methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
    
    return [zoomView viewWithTag:COMP_VIEW_TAG];
}


- (void)scrollViewDidEndZooming:(UIScrollView *) scrollView withView:(UIView *)view atScale:(float)t_scale 
{
    NSLog(@"zooming stoped %f", t_scale);
    [scrollView setZoomScale:t_scale+0.01 animated:NO];
    [scrollView setZoomScale:t_scale animated:NO];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //NSLog(@"some one zommed");
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"stopped dragging");
    [zoomView setZoomScale:[scrollView zoomScale] animated:NO];
}

-(void)scrollViewDidEndDecelerating
{
    NSLog(@"did end decelerating");
}

-(void)setZoomView:(UIScrollView *)zoomView
{
    NSLog(@"set zoom View?");
}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    NSLog(@"zoom RectForScale");
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [zoomView frame].size.height / scale;
    zoomRect.size.width  = [zoomView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}



- (void)segChanged:(id) sender
{
    NSLog(@"segHasChanged");
    
    if( [sender selectedSegmentIndex] ==0 )
    {
        NSLog(@"seg0");
        [UIView transitionFromView:layer1Controller
                        toView:bgController
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        // animation completed
                    }];
    }
    else if( [sender selectedSegmentIndex] ==1 )
    {
        NSLog(@"seg1");
            [UIView transitionFromView:bgController
                                toView:layer1Controller
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            completion:^(BOOL finished){
                                // animation completed
                        }];
    }
    else
        {}
        
        return;
    
}







-(void)twoFingersRotate:(UIGestureRecognizer*) recognizer
{
NSLog(@"in roatate");

}

-(void)pan:(UIPanGestureRecognizer *) recognizer
{
    NSLog(@"in pan");
    CGPoint velocity = [recognizer velocityInView:self.view];
    CGPoint distance = [recognizer translationInView:self.view];
  
    NSLog(@"you velocity was x %f  y  %f  The distance was  x %f,  y%f ", velocity.x,velocity.y, distance.x,distance.y);


}



-(void)oneFingerTwoTaps:(UITapGestureRecognizer *) recognizer
{
    NSLog(@"in One finger Two taps");
    
}

-(void)twoFingersTwoTaps:(UITapGestureRecognizer *) recognizer
{
    NSLog(@"in two fingers two Taps");
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)swipeRight:(UISwipeGestureRecognizer *) recognizer
{
   NSLog(@"in right swipe");
   backGround = [urn pervImage];
   [bgController setImage:backGround];
  

}



-(void)swipeLeft:(UISwipeGestureRecognizer *) recognizer
{
    NSLog(@"in left swipe");
    backGround = [urn nextImage];
    [bgController setImage:backGround];

    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
