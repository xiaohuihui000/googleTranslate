//
//  ViewController.m
//  text
//
//  Created by 陈光辉 on 2020/6/15.
//  Copyright © 2020 陈光辉. All rights reserved.
//

#import "ViewController.h"
#import <Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *array = @[
        @"我爱你",
        @"사랑해",
        @"Ich liebe Dich",
        @"あいしてる",
        @"IK hou van jou",
        @"Jag lskar dig",
        @"Szeretlek",
    ];
    
    for (NSString *text in array) {
        FIRLanguageIdentification *languageID = [[FIRNaturalLanguage naturalLanguage] languageIdentification];
        [languageID identifyPossibleLanguagesForText:text completion:^(NSArray<FIRIdentifiedLanguage *> * _Nullable identifiedLanguages, NSError * _Nullable error) {
            FIRIdentifiedLanguage *lange = identifiedLanguages.firstObject;
            FIRTranslateLanguage language = FIRTranslateLanguageForLanguageCode(lange.languageCode);
            FIRTranslatorOptions *opations = [[FIRTranslatorOptions alloc] initWithSourceLanguage:language targetLanguage:FIRTranslateLanguageEN];
            FIRTranslator *translator = [[FIRNaturalLanguage naturalLanguage] translatorWithOptions:opations];
            [translator downloadModelIfNeededWithCompletion:^(NSError * _Nullable error) {
                [translator translateText:text completion:^(NSString * _Nullable result, NSError * _Nullable error) {
                    NSLog(@"****翻译完成:%@", result);
                }];
            }];
        }];
    }
}



@end
