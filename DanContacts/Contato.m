//
//  Contato.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@synthesize nome, telefone, email, endereco, site, foto;

- (NSString *) nomeComEmail {
    return [NSString stringWithFormat:@"%@<%@>", nome, email];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:nome forKey:@"nome"];
    [aCoder encodeObject:telefone forKey:@"telefone"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:endereco forKey:@"endereco"];
    [aCoder encodeObject:site forKey:@"site"];
    [aCoder encodeObject:foto forKey:@"foto"];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.foto = [aDecoder decodeObjectForKey:@"foto"];
    }
    
    return self;
}

@end
