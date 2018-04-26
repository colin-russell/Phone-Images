//
//  ViewController.m
//  Phone Images
//
//  Created by Colin on 2018-04-26.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIImageView *iPhoneImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupImageView];
    
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/y9MIaCS.png"]; // step 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // step 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // step 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
    }]; // step 4
    
    [downloadTask resume]; // step 5

}


- (void)setupImageView {
    self.iPhoneImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.iPhoneImageView];
}

@end
