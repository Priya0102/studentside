//
//  ViewLocationViewController.m
//  Eshiksa
//
//  Created by Punit on 09/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "ViewLocationViewController.h"
#import "CurrentLocation.h"
//#import <GoogleMaps/GoogleMaps.h>
#import "UIKit/UIKit.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface ViewLocationViewController ()

@end

@implementation ViewLocationViewController
@synthesize mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.mapView.delegate = self;
    
    NSString *stopname = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"stopname"];
    NSLog(@"stopname ==%@",stopname);
    
    NSString *longitude = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"longitude"];
    NSLog(@"longitude ==%@",longitude);
    
    NSString *latitude = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"latitude"];
    NSLog(@"latitude ==%@",latitude);
    
    NSString *journeyId = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"journeyId"];
    NSLog(@"journeyId ==%@",journeyId);
    
    [self loadUserLocation];
  
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//       [self->locationManager requestWhenInUseAuthorization];
//    
//    [locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void) loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [objLocationManager requestWhenInUseAuthorization];
    }
    [objLocationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    CLLocation *newLocation = [locations objectAtIndex:0];
    latitude_UserLocation = newLocation.coordinate.latitude;
    longitude_UserLocation = newLocation.coordinate.longitude;
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [objLocationManager stopUpdatingLocation];
}
- (void) loadMapView
{
    CLLocationCoordinate2D objCoor2D = {.latitude = latitude_UserLocation, .longitude = longitude_UserLocation};
    MKCoordinateSpan objCoorSpan = {.latitudeDelta = 0.2, .longitudeDelta = 0.2};
    MKCoordinateRegion objMapRegion = {objCoor2D, objCoorSpan};
    //[objMapView setRegion:objMapRegion];
    
}
 

@end
