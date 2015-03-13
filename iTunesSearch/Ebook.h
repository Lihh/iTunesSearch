//
//  Ebook.h
//  iTunesSearch
//
//  Created by Lidia Chou on 3/13/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ebook : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSNumber *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSNumber *duracao;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *tipoMidia;
@property (nonatomic, strong) NSString *preco;
@property (nonatomic, strong) NSString *imagemMidia;

@end
