//
//  MapViewController.m
//  CTADataRecoder
//
//  Created by Eddie Koranek on 9/29/14.
//  Copyright (c) 2014 Eddie Koranek. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, weak)IBOutlet MKMapView *map;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.49509, -88.989156), MKCoordinateSpanMake(.1, .1)) animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
