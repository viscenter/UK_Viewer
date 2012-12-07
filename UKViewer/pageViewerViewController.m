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
@synthesize layer2Controller = layer2Controller;

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


-(void) setUp_urn_cite_Class
{
    // if (urn) NSLog(@"true");
    
    if(!urn){
        urn = [[urn_cite alloc] initWithMachine:@"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=" 
                                           size:@"1000" 
                                           base:@"urn:cite:fufolioimg:"
                                           type:@"ChadRGB." 
                                            doc:@"Chad"
                                             //This is a better crop but it makes aglinment difficult
                                           //crop:@":0.07,0.08,0.8.8,0.79&w="]; 
                                           crop:@"&w="]; 
        
        
        //   urn = [[urn_cite alloc] init];
        NSLog(@"alloc urn");
    }
    
    
    
    return;
}

-(void) addbackGroundImage{
    CGRect const screensize =[[UIScreen mainScreen] bounds];
    
    
    
    //UIScrollView
    zoomView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
    [zoomView setFrame:screensize];
    [zoomView setBounds:screensize];
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
    
    
    //CITE URN Image
    backGround= [[UIImage alloc] init];
    //backGround = [urn startImage];
    backGround = [urn gotopage:11];
    
    //Layer one Image
    UIImage *temp = [ UIImage imageNamed:@"12_good.png"];
    layer1 = [UIImage imageWithCGImage:[temp CGImage]
                                 scale: 1
                           orientation:UIImageOrientationUp  ];
    
    //UIImage *temp = [UIImage imageNamed:@"form2.png"];
    //   layer1 = [ UIImage imageWithCGImage:[temp CGImage]
    //                                 scale:7.05
    //                        orientation:UIImageOrientationUp]; 
    
    
    
    //UIImageView background image setup (layer 0) URN image view
    bgController = [[UIImageView alloc ]initWithImage:backGround];
    [bgController setFrame: [zoomView frame] ];
    [bgController setTag:BACKGROUND_TAG];
    [compositView addSubview:bgController];
    
    //UIImageView Layer1 set up
    layer1Controller = [[UIImageView alloc] initWithImage:layer1];
    [layer1Controller setFrame:[zoomView frame]];
    [layer1Controller setContentMode:UIViewContentModeScaleAspectFit];
    [bgController setFrame: [zoomView frame] ];
    [layer1Controller setTag:LAYER_1_TAG];
    [compositView addSubview:layer1Controller];
    
    [layer1Controller setAlpha:0]; //Inital set up
    
    
    //UILableView
    CGRect textFrame;
    textFrame.origin.x = zoomView.frame.origin.x +120; 
    textFrame.origin.y = zoomView.frame.origin.y +160;
    textFrame.size.height = zoomView.frame.size.height * 2/10; 
    textFrame.size.width = zoomView.frame.size.width* 2/3;
    layer2Controller = [[UILabel alloc] initWithFrame:textFrame];
    [layer2Controller setLineBreakMode:UILineBreakModeWordWrap];
    [layer2Controller setNumberOfLines:100];
    [layer2Controller setFont:[UIFont fontWithName:@"Helvetica" size:(18.0)]];
    [layer2Controller setTextColor:[UIColor whiteColor]];
    [layer2Controller setText:@"For the past year, the engineering team at the Google Cultural Institute has been working steadfastly and intensely to prepare for today: the new launch of 42 online exhibitions at http://google.com/culturalinstitute. As Visiting Scientist with the engineering team I have had a first-hand view of the process and a chance to get to know the engineers and some of the technology behind the code that is driving the launch"];
    [layer2Controller setAlpha:0];
    
    
    [layer2Controller setBackgroundColor:[UIColor clearColor]];
    
    
    
    [compositView addSubview:layer2Controller];
    


    
    
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
    segFrame.origin.x = navFrame.size.width * 7/10;
    segFrame.origin.y = navFrame.size.height*1/6;
    segFrame.size.width = navFrame.size.width/4;
    segFrame.size.height = navFrame.size.height/2;
    
    //create the seg layers
    seg = [[UISegmentedControl alloc ] initWithFrame: segFrame];
    [seg insertSegmentWithTitle:@"Plain" atIndex:0 animated:NO];
    [seg insertSegmentWithTitle:@"Text" atIndex:1 animated:NO];
    [seg insertSegmentWithTitle:@"Fonts" atIndex:2 animated:NO];
    
    [seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [seg setSelectedSegmentIndex:0]; //inital setup
    
    //add seg to the nave bar
    [navBar addSubview:seg];    
    
    [self LookForExtraDataForTheSeg];
    
    return;
}

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

//Below this point all functions are EVENT BASED
//////////////////////////////////////////////////


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
    if( [sender selectedSegmentIndex] ==2 )
    {
        
       // layer1Controller.alpha =0;
        NSLog(@"seg Font");
        [UIView beginAnimations:@"fade in" context:nil];
        [UIView setAnimationDuration:1.0];
        layer1Controller.alpha = 1.0;
        layer2Controller.alpha = 0;
        bgController.alpha = 1;

        [UIView commitAnimations];

        /* [UIView transitionFromView:layer1Controller
                        toView:bgController
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        // animation completed
         
        
        }];
    */
    }
    else if( [sender selectedSegmentIndex] ==0 )
    {
           
        //layer1Controller.alpha =.0;
        NSLog(@"Seg Plain");
        [UIView beginAnimations:@"fade in" context:nil];
        [UIView setAnimationDuration:1.0];
        layer1Controller.alpha = 0;
        layer2Controller.alpha = 0;
        bgController.alpha = 1;
        [UIView commitAnimations];
        /*[UIView transitionFromView:bgController
                                toView:layer1Controller
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            completion:^(BOOL finished){
                                // animation completed
          
         }];
    */
    }
    else if ([sender selectedSegmentIndex ] == 1)
    {      
        NSLog(@"seg text");
        
        //layer1Controller.alpha =1.0;
        [UIView beginAnimations:@"fade in" context:nil];
        [UIView setAnimationDuration:1.0];
        layer2Controller.alpha = 1;
        layer1Controller.alpha= 0;
        bgController.alpha = .7;
        [UIView commitAnimations];
    }
        
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
    
    [self LookForExtraDataForTheSeg   ];

}



-(void)swipeLeft:(UISwipeGestureRecognizer *) recognizer
{
    NSLog(@"in left swipe");
    backGround = [urn nextImage];
    [bgController setImage:backGround];

    [self LookForExtraDataForTheSeg];
    
}

-(void)LookForExtraDataForTheSeg
{
    [seg removeSegmentAtIndex:2 animated:NO];

    NSString *fileName =nil;
    if ( [urn pageNumber] == 11)
        fileName = @"forms.png";
    else if ( [urn pageNumber] == 12)
        fileName = @"12_good.png";
    else if ( [urn pageNumber] == 13)
    fileName = @"13_good.png";
    else if ( [urn pageNumber] == 14)
    fileName = @"14_good.png";
    else if ( [urn pageNumber] == 15)
    fileName = @"15_good.png";
    else if ( [urn pageNumber] == 16)
    fileName = @"16_good.png";
    
    if(fileName != nil)
    {
        [seg insertSegmentWithTitle:@"Fonts" atIndex:2 animated:NO];
        layer1 = [UIImage imageNamed: fileName];
        [layer1Controller setImage:layer1];
    }
    else {
        [layer1Controller setAlpha:0];
    }
    /*
    NSLog(@"looking for any data on this image");
    NSString* path = [[NSBundle mainBundle] pathForResource:@"jb.metainfo" 
                                                     ofType:@"txt"];
    NSString *tempFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:Nil]; 
    NSLog(tempFile);
    NSRange rangeOfNumber = [ tempFile rangeOfString:[NSString stringWithFormat:@"%d", [urn pageNumber]]];
    
    if(rangeOfNumber != NSNotFound)
        NSString *substring = 
    //substring = (rangeOfNumber.location != NSNotFound) ? [tempFile substringToIndex:rangeOfNumber.location] : nil;
    
     */
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*
-(void)alinmentTool
{
    UINavigationBar *temp =  [UINavigationBar alloc] initWithFrame:[CGRectMake(50, 50, 200, 200)];
    
    UIButton *up = [UIButton alloc] initWithFrame:[CGRectMake(10, 10, 50, 50)]
    UIButton *lower = [UIButton alloc] initWithFrame:[CGRectMake(10, 60, 50, 50)]
    UIButton *left = [UIButton alloc] initWithFrame:[CGRectMake(100, 10, 50, 50)]
    UIButton *right = [UIButton alloc] initWithFrame:[CGRectMake(100, 60, 50, 50)]
    
    temp su
    
}
*/

@end
