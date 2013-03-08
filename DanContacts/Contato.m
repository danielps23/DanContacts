//
//  Contato.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato

//@synthesize nome, telefone, email, endereco, site, foto, latitude, longitude;
@dynamic nome, telefone, email, endereco, site, latitude, longitude;
@synthesize foto;

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *) title {
    return self.nome;
}

- (NSString *) subtitle {
    return self.email;
}

- (NSString *) nomeComEmail {
    return [NSString stringWithFormat:@"%@<%@>", self.nome, self.email];
}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:nome forKey:@"nome"];
//    [aCoder encodeObject:telefone forKey:@"telefone"];
//    [aCoder encodeObject:email forKey:@"email"];
//    [aCoder encodeObject:endereco forKey:@"endereco"];
//    [aCoder encodeObject:site forKey:@"site"];
//    [aCoder encodeObject:foto forKey:@"foto"];
//    [aCoder encodeObject:latitude forKey:@"latitude"];
//    [aCoder encodeObject:longitude forKey:@"longitude"];
//}
//
//- (id) initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        self.nome = [aDecoder decodeObjectForKey:@"nome"];
//        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
//        self.email = [aDecoder decodeObjectForKey:@"email"];
//        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
//        self.site = [aDecoder decodeObjectForKey:@"site"];
//        self.foto = [aDecoder decodeObjectForKey:@"foto"];
//        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
//        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
//    }
//    
//    return self;
//}

@end
