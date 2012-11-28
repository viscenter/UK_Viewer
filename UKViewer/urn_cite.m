//
//  urn_cite.m
//  UKViewer
//
//  Created by John B on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "urn_cite.h"



@interface urn_cite ()
//@property (strong, nonatomic) imgcache *cache;
//@property (strong, nonatomic) UIImage *SimpleImage;
@end



@implementation urn_cite

@synthesize machine = machine;
@synthesize base= base;
@synthesize size=size;
@synthesize type = type;
@synthesize doc = doc;
@synthesize crop = crop;
@synthesize pageNumber= pageNumber;





-(id)init
{
    if(self = [super init])
    {
        machine = @"http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?&request=GetBinaryImage&urn=";
        size = @"500";
        base=@"urn:cite:fufolioimg:";
        type=@"ChadRGB.";
        doc=@"Chad";
        crop = @":0.07,0.08,0.8.8,0.79&w=";        
    }
    
    return self;
}


-(id)initWithMachine:(NSString*)in_machine size:(NSString*)in_size base:(NSString*)in_base type:(NSString*)in_type doc:(NSString*)in_doc crop:(NSString*)in_crop
{
    if(self = [super init])
    {
        machine = in_machine;
        size = in_size;
        base= in_base;
        type=in_type;
        doc=in_doc;
        crop = in_crop;        
    }
    
    return self;
}



-(UIImage*)startImage {
    pageNumber = 001;
    //NSLog(@"Loaded Up Page 1");
    return [self grabImage:[self helper] ];
}

-(float)returnPage
{
    return pageNumber;
}

-(NSString*)setUrl
{
    NSLog(@"NOT written yet");
    return (@"sorry");
}

-(UIImage*)nextImage
{
    pageNumber++;
    UIImage* currentpage=[self grabImage:[self helper]];
    return currentpage;
}

-(UIImage*)currentImage:(int)newSize
{
    NSString *temp = size;
    NSString * tempString = [NSString stringWithFormat:@"%d",newSize];
    size = tempString;
    UIImage* currentpage=[self grabImage:[self helper]];
    size = temp;
    return currentpage;
}

//previous image

-(UIImage*)pervImage
{
    if (pageNumber-1 <1){
        return [self grabImage:[self helper]];
    }
    pageNumber--;
    UIImage* currentpage=[self grabImage:[self helper]];
    return currentpage;
}

-(UIImage*)gotopage: (int) pageNum
{
    pageNumber=pageNum;
    UIImage* currentpage=[self grabImage:[self helper]];
    return currentpage;
}




//concatenates the URL and URN together

-(NSString*)helper
{
    
    
    NSString * pageString = [NSString stringWithFormat:@"%03d",pageNumber];
    
    /* 
     NSString *newString = [[NSString alloc] init]; 
     [newString stringByAppendingFormat:@"daslfkasd;lfka; %@", _currentUrl.Base,_currentUrn.base, _currentUrn.type, _currentUrn.doc, pageString, _currentUrn.crop];
     */
    
    
    
    NSMutableString *tmpString = [[NSMutableString alloc] initWithFormat:machine ];
    [tmpString appendString:base];
    [tmpString appendString:type];
    [tmpString appendString:doc];
    [tmpString appendString:pageString];
    [tmpString appendString:crop];
    // [tmpString appendString:dataurn.size];
    // [tmpString appendString:dataurn.machine];
    [tmpString appendString:size];
    
    
    //    tmpString=[NSString stringWithFormat:_currentUrl.Base,tmpString];
    
      // NSLog(tmpString);
    
    
    
    //   NSLog(newString);
    



    return tmpString;
    
}
/*
-(BOOL)bufferFoward
{
    NSLog(@"Requesting the next page NOW");
      pageNumber++;
    [self grabImage:[self helper]];
    pageNumber--;
    return YES;
}
 */

-(NSData*) nextData
{
    pageNumber++;
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString: [self helper]]];
    
    return data;
}

-(NSString*) nextURN
{
    pageNumber++;
    return [self helper];
    
}

-(UIImage*) grabImage:(NSString*) url
{ 
    NSURL *ImageURL = [NSURL URLWithString: url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:ImageURL];//
    UIImage *image = [[UIImage alloc] initWithData: data];
    return image;
}



/*
-(void)speedTest
{
    
    //_currentUrn.size = @"25";
    for( int i = 0; i < 200; i++)
    {
        NSTimeInterval total;
        pageNumber = 4;
        for( int avgTime = 0; avgTime < 10; avgTime++)
        {
            size = [NSString stringWithFormat:@"%d", (i*10)];
            NSDate *start = [NSDate date]; 
            NSURL *ImageURL = [NSURL URLWithString: [self helper]];
            NSData *data = [[NSData alloc] initWithContentsOfURL:ImageURL];//
            UIImage *image = [[UIImage alloc] initWithData: data];
            NSDate *now = [NSDate date];
            NSTimeInterval interval = [now timeIntervalSinceDate:start];
            total = total + interval;
            [start release];
            [ImageURL release];
            [data release];
            [image release];
            [now release];
            
            
        }
        
        //NSTimeInterval timeInterval = [start timeIntervalSinceNow];
        NSLog(@",TIME, %f , %d, %@",total /10.0, (i*10), [self helper]);
        //   NSLog([NSString stringWithFormat:@"%d", (i*100)]);
        
        
        
        
    }
    return;
}
 */


@end
