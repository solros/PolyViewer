/***********************************************************************
 * Created by Andreas Paffenholz on 04/18/12.
 * Copyright 2012-2014 by Andreas Paffenholz.
 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2, or (at your option) any
 * later version: http://www.gnu.org/licenses/gpl.txt.
 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * RetrieveFromDBController.m
 * PolyViewer
 **************************************************************************/

#import "RetrieveFromDBController.h"
#import "PolymakeFile.h"
#import "AppController.h"

@implementation RetrieveFromDBController

@synthesize database = _database;
@synthesize collection = _collection;
@synthesize ID = _ID;


-(id)init {
	self = [super init];
	if (self) {
        _database = nil;
        _collection = nil;
        _ID = nil;


    }
    
	return self;
}


-(void)dealloc {
	[_database release];
    [_collection dealloc];
    [_ID dealloc];
    
	[super dealloc];
}


- (void)windowDidLoad {
	
    NSLog(@"[RetrieveFromDBController windowDidLoadNib] called");
    // start with some example values to prevent the obvious crash
    // as we currently don't do any value checking
    self.database = @"LatticePolytopes";
    _collection = @"SmoothReflexive";
    _ID = @"F.4D.0123";
    [databaseTextfield setStringValue:_database];
    [collectionTextfield setStringValue:_collection];
    [IDTextfield setStringValue:_ID];
}

- (IBAction)retrieveFromDB:(id)sender {
    
    NSLog(@"[RetrieveFromDBController retrieveFromDB] called");
    NSLog(@"[RetrieveFromDBController retrieveFromDB] current values:\ndatabase: %@\ncollection: %@\nID: %@",_database,_collection,_ID);
    
    PolymakeFile * pf = [[PolymakeFile alloc] init];
    [pf readFromDatabase:_database andCollection:_collection withID:_ID];
    
    [pf makeWindowControllers];
    [pf showWindows];
    [[NSDocumentController sharedDocumentController] addDocument:pf];
    [pf release];
    [[self window] orderOut:nil];
}

@end
