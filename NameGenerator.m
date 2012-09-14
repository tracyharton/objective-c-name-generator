#import"NameGenerator.h"

#define PRE_CHANCE 33
#define VOWEL_CHANCE 80
#define MIDDLE1_CHANCE 30
#define MIDDLE2_CHANCE 10
#define POST_CHANCE 22
#define GENERATED_CHANCE 50

@implementation NameGenerator

static NameGenerator *sharedSingleton;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedSingleton = [[NameGenerator alloc] init];
    }
}

+ (NameGenerator *)sharedSingleton
{
    return sharedSingleton;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		vowel = @"aeiouy";
        letter = @"abcdefghijklmnopqrstuvwxyz";
		malePre = [NSMutableArray array];
		femalePre = [NSMutableArray array];
		maleStart = [NSMutableArray array];
		femaleStart = [NSMutableArray array];
		maleMiddle = [NSMutableArray array];
		femaleMiddle = [NSMutableArray array];
		maleEnd = [NSMutableArray array];
		femaleEnd = [NSMutableArray array];
		malePost = [NSMutableArray array];
		femalePost = [NSMutableArray array];
		maleArray = [NSMutableArray array];
		femaleArray = [NSMutableArray array];

		NSStringEncoding encoding;
		NSError *error;

		NSBundle *bundle = [NSBundle mainBundle];

		NSString *syllablePath = [bundle pathForResource:@"syllable" ofType:@"csv"];
		NSString *syllableFile = [NSString stringWithContentsOfFile:syllablePath usedEncoding:&encoding error:&error];
		NSArray *syllableRows = [[NSArray alloc] initWithArray:[syllableFile componentsSeparatedByString:@"\n"]];

		for (NSUInteger i = 1; i < [syllableRows count]; i++)
		{
			NSArray *cells = [[syllableRows objectAtIndex:i] componentsSeparatedByString:@","];
			NSString *cell;
			if ((cells.count >= 1) && ([cells objectAtIndex:0] != nil))
			{
				cell = [cells objectAtIndex:0];
				if (cell.length != 0)
				{
					[maleStart addObject:cell];
				}
			}
			if ((cells.count >= 2) && ([cells objectAtIndex:1] != nil))
			{
				cell = [cells objectAtIndex:1];
				if (cell.length != 0)
				{
					[maleMiddle addObject:cell];
				}
			}
			if ((cells.count >= 3) && ([cells objectAtIndex:2] != nil))
			{
				cell = [cells objectAtIndex:2];
				if (cell.length != 0)
				{
					[maleEnd addObject:cell];
				}
			}
			if ((cells.count >= 4) && ([cells objectAtIndex:3] != nil))
			{
				cell = [cells objectAtIndex:3];
				if (cell.length != 0)
				{
					[femaleStart addObject:cell];
				}
			}
			if ((cells.count >= 5) && ([cells objectAtIndex:4] != nil))
			{
				cell = [cells objectAtIndex:4];
				if (cell.length != 0)
				{
					[femaleMiddle addObject:cell];
				}
			}
			if ((cells.count >= 6) && ([cells objectAtIndex:5] != nil))
			{
				cell = [cells objectAtIndex:5];
				if (cell.length != 0)
				{
					[femaleEnd addObject:cell];
				}
			}
			if ((cells.count >= 7) && ([cells objectAtIndex:6] != nil))
			{
				cell = [cells objectAtIndex:6];
				if (cell.length != 0)
				{
					[maleStart addObject:cell];
					[femaleStart addObject:cell];
				}
			}
			if ((cells.count >= 8) && ([cells objectAtIndex:7] != nil))
			{
				cell = [cells objectAtIndex:7];
				if (cell.length != 0)
				{
					[maleMiddle addObject:cell];
					[femaleMiddle addObject:cell];
				}
			}
			if ((cells.count >= 9) && ([cells objectAtIndex:8] != nil))
			{
				cell = [cells objectAtIndex:8];
				if (cell.length != 0)
				{
					[maleEnd addObject:cell];
					[femaleEnd addObject:cell];
				}
			}
		}


		NSString *titlePath = [bundle pathForResource:@"title" ofType:@"csv"];
		NSString *titleFile = [NSString stringWithContentsOfFile:titlePath usedEncoding:&encoding error:&error];
		NSArray *titleRows = [[NSArray alloc] initWithArray:[titleFile componentsSeparatedByString:@"\n"]];

		for (NSUInteger i = 1; i < [titleRows count]; i++)
		{
			NSArray *cells = [[titleRows objectAtIndex:i] componentsSeparatedByString:@","];
			NSString *cell;
			if ((cells.count >= 1) && ([cells objectAtIndex:0] != nil))
			{
				cell = [cells objectAtIndex:0];
				if (cell.length != 0)
				{
					[malePre addObject:cell];
				}
			}
			if ((cells.count >= 2) && ([cells objectAtIndex:1] != nil))
			{
				cell = [cells objectAtIndex:1];
				if (cell.length != 0)
				{
					[malePost addObject:cell];
				}
			}
			if ((cells.count >= 3) && ([cells objectAtIndex:2] != nil))
			{
				cell = [cells objectAtIndex:2];
				if (cell.length != 0)
				{
					[femalePre addObject:cell];
				}
			}
			if ((cells.count >= 4) && ([cells objectAtIndex:3] != nil))
			{
				cell = [cells objectAtIndex:3];
				if (cell.length != 0)
				{
					[femalePost addObject:cell];
				}
			}
			if ((cells.count >= 5) && ([cells objectAtIndex:4] != nil))
			{
				cell = [cells objectAtIndex:4];
				if (cell.length != 0)
				{
					[malePre addObject:cell];
					[femalePre addObject:cell];
				}
			}
			if ((cells.count >= 6) && ([cells objectAtIndex:5] != nil))
			{
				cell = [cells objectAtIndex:5];
				if (cell.length != 0)
				{
					[malePost addObject:cell];
					[femalePost addObject:cell];
				}
			}
		}


		NSString *namePath = [bundle pathForResource:@"name" ofType:@"csv"];
		NSString *nameFile = [NSString stringWithContentsOfFile:namePath usedEncoding:&encoding error:&error];
		NSArray *nameRows = [[NSArray alloc] initWithArray:[nameFile componentsSeparatedByString:@"\n"]];

		for (NSUInteger i = 1; i < [nameRows count]; i++)
		{
			NSArray *cells = [[nameRows objectAtIndex:i] componentsSeparatedByString:@","];
			NSString *cell;
			if ((cells.count >= 1) && ([cells objectAtIndex:0] != nil))
			{
				cell = [cells objectAtIndex:0];
				if (cell.length != 0)
				{
					[maleArray addObject:cell];
				}
			}
			if ((cells.count >= 2) && ([cells objectAtIndex:1] != nil))
			{
				cell = [cells objectAtIndex:1];
				if (cell.length != 0)
				{
					[femaleArray addObject:cell];
				}
			}
			if ((cells.count >= 3) && ([cells objectAtIndex:2] != nil))
			{
				cell = [cells objectAtIndex:2];
				if (cell.length != 0)
				{
					[maleArray addObject:cell];
					[femaleArray addObject:cell];
				}
			}
		}

	}
	return self;
}

- (NSUInteger)random:(NSUInteger)max
{
	return (NSUInteger) floor(arc4random() % max);
}

- (NSString *) getUsername
{
    NSString *name = [[self getName:NO male:NO female:YES prefix:NO postfix:NO] lowercaseString];
    
    NSString *userName = [NSString stringWithFormat:@"%c%@", [letter characterAtIndex:[self random:[letter length]]], name];
    
    return userName;
    
}

- (NSString *)getName
{
	return [self getName:YES male:YES female:YES prefix:YES postfix:YES];
}

- (NSString *)getName:(BOOL)generated male:(BOOL)male female:(BOOL)female prefix:(BOOL)prefix postfix:(BOOL)postfix
{
	NSMutableString *newName = [NSMutableString string];
    
    BOOL sex;
    
    if(male && !female)
        sex = FALSE;
    else if(female && !male)
        sex = FALSE;
    else
        sex = ([self random:100] < 50);

	BOOL preAdded = NO;
	if (prefix && ([self random:100] < PRE_CHANCE))
	{
		[newName appendString:[(sex ? malePre : femalePre) objectAtIndex:[self random:[(sex ? malePre : femalePre) count]]]];
		[newName appendString:@" "];
		preAdded = YES;
	}

	if (generated && ([self random:100] < GENERATED_CHANCE))
	{
		[newName appendString:[(sex ? maleStart : femaleStart) objectAtIndex:[self random:[(sex ? maleStart : femaleStart) count]]]];

		if ([self random:100] < VOWEL_CHANCE)
		{
			[newName stringByAppendingFormat:@"%c", [vowel characterAtIndex:[self random:[vowel length]]]];
		}

		if ([self random:100] < MIDDLE1_CHANCE)
		{
			[newName appendString:[(sex ? maleMiddle : femaleMiddle) objectAtIndex:[self random:[(sex ? maleMiddle : femaleMiddle) count]]]];
		}
		if ([self random:100] < MIDDLE2_CHANCE)
		{
			[newName appendString:[(sex ? maleMiddle : femaleMiddle) objectAtIndex:[self random:[(sex ? maleMiddle : femaleMiddle) count]]]];
		}

		[newName appendString:[(sex ? maleEnd : femaleEnd) objectAtIndex:[self random:[(sex ? maleEnd : femaleEnd) count]]]];
	}
	else
	{
		[newName appendString:[(sex ? maleArray : femaleArray) objectAtIndex:[self random:[(sex ? maleArray : femaleArray) count]]]];
	}

	int postChance = POST_CHANCE;
	if (preAdded) postChance += 50;
	if (postfix && ([self random:100] > postChance))
	{
		[newName appendString:@" "];
		[newName appendString:[(sex ? malePost : femalePost) objectAtIndex:[self random:[(sex ? malePost : femalePost) count]]]];
	}

	return newName;
}

@end
