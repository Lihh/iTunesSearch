//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Ebook.h"
#import "Podcast.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarFilmes:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }

    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    @try {
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *filmes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Filme *filme = [[Filme alloc] init];
            [filme setNome:[item objectForKey:@"trackName"]];
            [filme setTrackId:[item objectForKey:@"trackId"]];
            [filme setArtista:[item objectForKey:@"artistName"]];
            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPais:[item objectForKey:@"country"]];
            [filme setTipoMidia:[item objectForKey:@"kind"]];
            
            [filmes addObject:filme];
        }
        
        return filmes;
    }
    @catch (NSException *exception) {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"ERRO!" message:@"Erro na consulta. Tente novamente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
        
        NSMutableArray *filmes = [[NSMutableArray alloc] init];
        return filmes;
        
    }
    
    
}

- (NSArray *)buscarMusicas:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    @try {
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *musicas = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Musica *musica = [[Musica alloc] init];
            [musica setNome:[item objectForKey:@"trackName"]];
            [musica setTrackId:[item objectForKey:@"trackId"]];
            [musica setArtista:[item objectForKey:@"artistName"]];
            [musica setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [musica setGenero:[item objectForKey:@"primaryGenreName"]];
            [musica setPais:[item objectForKey:@"country"]];
            [musica setTipoMidia:[item objectForKey:@"kind"]];
            
            [musicas addObject:musica];
        }
        
        return musicas;
    }
    @catch (NSException *exception) {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"ERRO!" message:@"Erro na consulta. Tente novamente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
        
        NSMutableArray *musicas = [[NSMutableArray alloc] init];
        return musicas;
        
    }
    
    
}

- (NSArray *)buscarEbooks:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=ebook", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    @try {
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *ebooks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Ebook *ebook = [[Ebook alloc] init];
            [ebook setNome:[item objectForKey:@"trackName"]];
            [ebook setTrackId:[item objectForKey:@"trackId"]];
            [ebook setArtista:[item objectForKey:@"artistName"]];
            [ebook setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
            [ebook setPais:[item objectForKey:@"country"]];
            [ebook setTipoMidia:[item objectForKey:@"kind"]];
            [ebook setPreco:[item objectForKey:@"formattedPrice"]];
            
            [ebooks addObject:ebook];
        }
        
        return ebooks;
    }
    @catch (NSException *exception) {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"ERRO!" message:@"Erro na consulta. Tente novamente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
        
        NSMutableArray *ebooks = [[NSMutableArray alloc] init];
        return ebooks;
        
    }
    
    
}

- (NSArray *)buscarPodcasts:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    @try {
        NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&error];
        if (error) {
            NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
            return nil;
        }
        
        NSArray *resultados = [resultado objectForKey:@"results"];
        NSMutableArray *podcasts = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in resultados) {
            Podcast *podcast = [[Podcast alloc] init];
            [podcast setNome:[item objectForKey:@"trackName"]];
            [podcast setTrackId:[item objectForKey:@"trackId"]];
            [podcast setArtista:[item objectForKey:@"artistName"]];
            [podcast setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
            [podcast setPais:[item objectForKey:@"country"]];
            [podcast setTipoMidia:[item objectForKey:@"kind"]];
            
            [podcasts addObject:podcast];
        }
        
        return podcasts;
    }
    @catch (NSException *exception) {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"ERRO!" message:@"Erro na consulta. Tente novamente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
        
        NSMutableArray *podcasts = [[NSMutableArray alloc] init];
        return podcasts;
        
    }
    
    
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
