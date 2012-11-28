//
//  urn_cite.h
//  UKViewer
//
//  Created by John B on 11/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface urn_cite : NSObject


@property  (strong,nonatomic)NSString *machine;
@property  (strong,nonatomic)    NSString *base;
@property  (strong,nonatomic)   NSString *size;
@property  (strong,nonatomic)  NSString *type;
@property  (strong,nonatomic) NSString *doc;
@property  (strong,nonatomic)  NSString *crop;
@property   int pageNumber;





//@property (strong, nonatomic) NSString *IfUrl;

-(id)init;
-(id)initWithMachine:(NSString*)in_machine 
                size:(NSString*)in_size 
                base:(NSString*)in_base 
                type:(NSString*)in_type 
                 doc:(NSString*)in_doc 
                crop:(NSString*)in_crop;
-(float)returnPage;
-(UIImage*)nextImage;
-(UIImage*)currentImage:(int)quality;
-(UIImage*)pervImage;
-(UIImage*)startImage;
-(UIImage*)gotopage:(int)pageNum;
-(NSString*)setUrl;
-(NSString*)helper; 


-(NSData*)nextData;
-(NSString*)nextURN;
-(void)speedTest;


@end



//_currentUrn.