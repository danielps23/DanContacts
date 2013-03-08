//
//  Contato.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Contato : NSObject<NSCoding, MKAnnotation>

@property(strong) NSString *nome;
@property(strong) NSString *telefone;
@property(strong) NSString *email;
@property(strong) NSString *endereco;
@property(strong) NSString *site;
@property(strong) UIImage *foto;
@property(strong) NSNumber *latitude;
@property(strong) NSNumber *longitude;

- (NSString *) nomeComEmail;

@end
