//  FISAppDelegate.m

#import "FISAppDelegate.h"
#import <math.h>

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *list = @[@"Hello", @"World", @"in", @"a", @"frame"];
    [self printInAFrameFromList:list];
    
    NSString *thefox = @"The quick brown fox";
    [self toPigLatin: thefox];
    
    NSArray *firstList = @[@"a",@"b",@"c"];
    NSArray *secondList = @[@1,@2,@3];
    NSArray *combinedList = [self combineTwoListsIntoOneAlternatingly:firstList secondList:secondList];
    NSLog(@"%@",combinedList);
    
    NSUInteger number = 12045;
    NSArray *digitsList = [self numbersDigitsToArray:number];
    NSLog(@"Digits array: %@", digitsList);
    
    //NSMutableArray *backwardsItems = [[NSMutableArray alloc] initWithObjects:@"c", @"b","a", nil];
    
    NSMutableArray *backwardsItems = [@[@"z", @"y", @"x"] mutableCopy];
    NSLog(@"Backwards: %@", backwardsItems);
    NSArray *forwardsItems = [self reverseArray:backwardsItems];
    NSLog(@"Forwards: %@", forwardsItems);
    
    return YES;
}
-(void)printInAFrameFromList:(NSArray *)list{
    NSUInteger longestWord = 0;
    for (NSString *word in list) {
        NSUInteger currentWordLength = [word length];
        if (currentWordLength > longestWord)
        {
            longestWord = currentWordLength;
        }
    }
    
    // print part
    NSLog(@"*********");
    for (NSString *word in list)
    {
        NSString *lineInFrame = [NSString stringWithFormat:@"* %@", word];
        if (word.length < longestWord)
        {
            NSString *lineInFrameWithAddedSpaces =[lineInFrame stringByPaddingToLength:longestWord+3 withString:@" " startingAtIndex:0];
            // 9 total spaces for the word gives enough padding
            lineInFrameWithAddedSpaces = [lineInFrameWithAddedSpaces stringByAppendingString:@"*"];
            lineInFrame = lineInFrameWithAddedSpaces;
        }else {
            lineInFrame = [lineInFrame stringByAppendingString:@" *"];
        }
        NSLog(@"%@", lineInFrame);
    }
    NSLog(@"*********");
    
}

-(void)toPigLatin:(NSString *)normalText
{
    NSArray *sentence = [normalText componentsSeparatedByString:@" "];
    NSString *pigLatinSentence = @"";
    for (NSString *word in sentence)
    {
        // to remember: unichar does NOT take in a pointer
        // %C stringWithFormat, not lowercase %c
        unichar firstLetter = [word characterAtIndex:0];
        NSString *firstLetterStr = [NSString stringWithFormat:@"%C", firstLetter];
        NSString *wordWithoutFirstLetter =[word substringFromIndex:1];
        wordWithoutFirstLetter = [wordWithoutFirstLetter stringByAppendingString:[NSString stringWithFormat:@"%@ay ", firstLetterStr]];
        wordWithoutFirstLetter = wordWithoutFirstLetter.lowercaseString;
        pigLatinSentence = [pigLatinSentence stringByAppendingString:wordWithoutFirstLetter];
    }
    
    NSMutableArray *pigLatinArr = [[pigLatinSentence componentsSeparatedByString:@" "] mutableCopy];
    NSString *capitalizeTheFirstWord = [pigLatinArr[0] capitalizedString];
    pigLatinArr[0] = capitalizeTheFirstWord;
    pigLatinSentence = @"";
    for (NSString *word in pigLatinArr)
    {
        pigLatinSentence = [pigLatinSentence stringByAppendingString:[NSString stringWithFormat:@"%@ ", word]];
    }
    
    NSLog(@"%@", pigLatinSentence);
}
-(NSArray *)combineTwoListsIntoOneAlternatingly:(NSArray *)firstList secondList:(NSArray *)secondList {
    //should check first which array is biggest, assumes both parameter arrays are of equal size
    
    NSUInteger firstElementInsertPosition = 0;
    NSUInteger secondElementInsertPosition = 1;
    NSMutableArray *alternatingArray = [[NSMutableArray alloc] init];
    for (NSUInteger i =0; i < [firstList count]; i++) {
        [alternatingArray insertObject:firstList[i] atIndex:firstElementInsertPosition];  //insertObject at an index that doesn't exist WORKS for index that is ONE beyond the Mutable Array's last placed item
        [alternatingArray insertObject:secondList[i] atIndex:secondElementInsertPosition];
        firstElementInsertPosition += 2;
        secondElementInsertPosition += 2;
    }
    return alternatingArray;
}

-(NSArray *)numbersDigitsToArray:(NSUInteger)number {
    NSMutableArray *digitList = [[NSMutableArray alloc] init];
    
   // NSUInteger numberOfIntDigits = (number ==0) ? 1 : (NSUInteger)log10(number) + 1;
    //could also convert to string then string.count
    // 12045
//    for (NSUInteger i =numberOfIntDigits; i > 2; i--)
//    {
//        NSUInteger ithPlace = pow(10, i);
//        NSUInteger digit = number % ithPlace;
//        [digitList addObject:@(digit)];
//    }
//    
    //In general, for any number n, ith digit is n % pow(10, i)
    NSUInteger loop = number;
    while (loop > 0) {
        NSUInteger digit = loop %10; //not loop /10
        loop /= 10;
        [digitList addObject:@(digit)];
    }
    
    //reverse a mutable array
    return [[[digitList reverseObjectEnumerator] allObjects] mutableCopy];
}
-(NSArray *)reverseArray:(NSMutableArray *)array {
    //pointer practice
    
    return [[array reverseObjectEnumerator] allObjects];
}

/**
 
 * Write your method implementations here!
 
 */


@end
