//
//  FEEventLoader.h
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YAJLiOS/YAJL.h>
#import "Event.h"
#import "FEProxy.h"

@protocol FEEventLoaderDelegate <NSObject>
@required
- (void)eventsLoaded:(NSArray *)events;

@optional
- (void)failWithError:(NSError *)error;

@end

@interface FEEventLoader : NSObject <FEProxyProtocol, FacebookObjectLoadedCompleteDelegate> {
    NSString *eventsURL;
    FEProxy *proxy;
    id<FEEventLoaderDelegate> waitingDelegate;
    
    NSInteger numberOfLoadedEvents;
}

@property (nonatomic, readwrite) NSInteger numberOfLoadedEvents;

- (id)initWithEventsURL:(NSString *)url andDelegate:(id<FEEventLoaderDelegate>)delegate;
- (void)startGettingEvents;

@end

/*
 {
 "data": [
 {
 "name": "Cocoon showcase \u0040 Undercurrent",
 "start_time": "2012-10-17T22:00:00",
 "end_time": "2012-10-18T06:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Undercurrent",
 "id": "141441742662477",
 "rsvp_status": "unsure"
 },
 {
 "name": ":: FROM BRAZIL WITH \u2665 :: DIGITARIA LIVE (HOT CREATIONS, BR) + LOCAL SUPPORT ::",
 "start_time": "2012-09-29T23:00:00",
 "end_time": "2012-09-30T05:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Club Home",
 "id": "415793168476809",
 "rsvp_status": "attending"
 },
 {
 "name": "OP DE VALRAVE",
 "start_time": "2012-09-16T15:00:00",
 "end_time": "2012-09-16T23:55:00",
 "timezone": "Europe/Amsterdam",
 "location": "Magneet Festival",
 "id": "110108202469492",
 "rsvp_status": "attending"
 },
 {
 "name": "INNERVISIONS \u0040 STEDELIJK FEAT. \u00c2ME, DIXON, HENRIK SCHWARZ",
 "start_time": "2012-09-09T17:00:00",
 "end_time": "2012-09-09T23:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Stedelijk",
 "id": "383182465081355",
 "rsvp_status": "attending"
 },
 {
 "name": "NGHTDVSN \u0040 Paradiso with Max Cooper, Stephan Bodzin, Tiger & Woods",
 "start_time": "2012-09-08T23:00:00",
 "end_time": "2012-09-09T02:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Paradiso",
 "id": "517618668255088",
 "rsvp_status": "attending"
 },
 {
 "name": "Amateur & Border Community - Nathan Fake Album Tour\t ",
 "start_time": "2012-09-01T18:00:00",
 "end_time": "2012-09-02T03:30:00",
 "timezone": "Europe/Amsterdam",
 "location": "Whoosah Beachclub",
 "id": "211176885671568",
 "rsvp_status": "unsure"
 },
 {
 "name": "NACHT BAZAAR",
 "start_time": "2012-08-31T20:30:00",
 "end_time": "2012-09-01T03:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "TrouwAmsterdam",
 "id": "430574546993150",
 "rsvp_status": "attending"
 },
 {
 "name": "Dinner At Mi Casa",
 "start_time": "2012-08-31T20:00:00",
 "end_time": "2012-08-31T23:00:00",
 "location": "Koningin Wilhelminaplein 348",
 "id": "449022245138540",
 "rsvp_status": "attending"
 },
 {
 "name": "WHY op NachtBazaar Trouw!",
 "start_time": "2012-08-31T02:00:00",
 "end_time": "2012-09-01T02:00:00",
 "location": "TrouwAmsterdam",
 "id": "353295214746241",
 "rsvp_status": "unsure"
 },
 {
 "name": "Malawi Returns",
 "start_time": "2012-08-30T20:00:00",
 "end_time": "2012-08-31T01:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Basis Amsterdam",
 "id": "102745373208181",
 "rsvp_status": "unsure"
 },
 {
 "name": "LOCKDOWN FESTIVAL 2012",
 "start_time": "2012-08-26T12:00:00",
 "end_time": "2012-08-26T23:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "NDSM Werf",
 "id": "286797118084547",
 "rsvp_status": "unsure"
 },
 {
 "name": "VOLTT LOVES SUMMER 2012 AFTER \u0040 Paradiso",
 "start_time": "2012-08-25T23:00:00",
 "end_time": "2012-08-26T02:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Paradiso",
 "id": "481845521845539",
 "rsvp_status": "attending"
 },
 {
 "name": "ABC's Summer BIG Boat Party | Saturday August 25th",
 "start_time": "2012-08-25T14:00:00",
 "end_time": "2012-08-25T19:30:00",
 "timezone": "Europe/Amsterdam",
 "location": "Pier 14, just behind Centraal Station in Amsterdam at 14:00 Street: De Ruyterkade (Where Supper Club Boat is) ",
 "id": "330964630331236",
 "rsvp_status": "unsure"
 },
 {
 "name": "VOLTT LOVES SUMMER FESTIVAL 2012",
 "start_time": "2012-08-25T11:00:00",
 "end_time": "2012-08-25T23:00:00",
 "location": "NDSM Werf",
 "id": "214323375313040",
 "rsvp_status": "unsure"
 },
 {
 "name": "Secrets of Dante",
 "start_time": "2012-08-24T21:30:00",
 "end_time": "2012-08-25T09:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Amsterdam, Netherlands",
 "id": "219283918197035",
 "rsvp_status": "attending"
 },
 {
 "name": "Secrets of Dante",
 "start_time": "2012-08-24T21:30:00",
 "end_time": "2012-08-25T04:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Dante Kitchen & Bar",
 "id": "332043203552081",
 "rsvp_status": "attending"
 },
 {
 "name": "DVM goes to da beach !",
 "start_time": "2012-08-17T23:05:00",
 "end_time": "2012-08-19T17:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "TBA",
 "id": "399624120101311",
 "rsvp_status": "attending"
 },
 {
 "name": "Trutjes",
 "start_time": "2012-08-17T18:00:00",
 "end_time": "2012-08-18T03:00:00",
 "timezone": "Europe/Amsterdam",
 "location": "Amsterdam Roest",
 "id": "409363322449316",
 "rsvp_status": "unsure"
 }
 ],
 "paging": {
 "previous": "https://graph.facebook.com/592580788/events?access_token=BAAEtPMZC1ZAGMBAKojZAbZAeStEFLtQ8zAaCGsPZBvybhXrYujgFdDg0Sbn71XYQUK21IEdLL96zoGamIiIcpTZBrSfXyKpyMv40cTfqhCPlc2BP8UZAljTnOusKFea3K6SuzqWm8MdBwZDZD&limit=25&since=1350511200&__paging_token=141441742662477&__previous=1",
 "next": "https://graph.facebook.com/592580788/events?access_token=BAAEtPMZC1ZAGMBAKojZAbZAeStEFLtQ8zAaCGsPZBvybhXrYujgFdDg0Sbn71XYQUK21IEdLL96zoGamIiIcpTZBrSfXyKpyMv40cTfqhCPlc2BP8UZAljTnOusKFea3K6SuzqWm8MdBwZDZD&limit=25&until=1345226400&__paging_token=409363322449316"
 }
 }
*/