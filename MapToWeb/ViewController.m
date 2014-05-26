//
//  ViewController.m
//  MapToWeb
//
//  Created by 河辺雅史 on 2014/05/23.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myMapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MKCoordinateRegion region = myMapView.region;
    region.center.latitude = 41.842011;
    region.center.longitude = 140.766987;
    region.span.latitudeDelta = 0.005;
    region.span.longitudeDelta = 0.005;
    [myMapView setRegion:region animated:YES];
    
    lm =[[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    lm.distanceFilter = kCLHeadingFilterNone;
    [lm startUpdatingLocation];
    
    MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D point;
    point.latitude = 41.842011;
    point.longitude = 140.766987;
    [pin setCoordinate:point];
    pin.title = @"公立はこだて未来大学";
    pin.subtitle = @"亀田中野町116番地2";
    [myMapView addAnnotation:pin];
    
    myMapView.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    myMapView.showsUserLocation = YES;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) Annotation{
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [myMapView dequeueReusableAnnotationViewWithIdentifier: @"my_annotaion"];
    
    if(annotationView == nil){
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation: Annotation reuseIdentifier:@"my_annotaion"];
    }else{
        annotationView.annotation = Annotation;
    }
    
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    annotationView.pinColor = MKPinAnnotationColorPurple;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    //ピンのタイトル表示時にボタンを表示
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = button;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // push the detail view
    [self performSegueWithIdentifier:@"toWeb" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
