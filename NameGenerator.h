@interface NameGenerator : NSObject
{
    NSString *vowel;
    NSString *letter;
	
	NSMutableArray *malePre;
	NSMutableArray *maleStart;
	NSMutableArray *maleMiddle;
	NSMutableArray *maleEnd;
	NSMutableArray *malePost;
	
	NSMutableArray *maleArray;
	
	NSMutableArray *femalePre;
	NSMutableArray *femaleStart;
	NSMutableArray *femaleMiddle;
	NSMutableArray *femaleEnd;
	NSMutableArray *femalePost;
	
	NSMutableArray *femaleArray;
}

+ (NameGenerator *)sharedSingleton;

- (NSString *)getUsername;

- (NSString *)getName;

- (NSString *)getName:(BOOL)generated male:(BOOL)male female:(BOOL)female prefix:(BOOL)prefix postfix:(BOOL)postfix;

@end
