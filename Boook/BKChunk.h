#import "_BKChunk.h"

typedef enum {
	ChunkTypeTitle,
	ChunkTypeSubTitle,
	ChunkTypeHeading,
	ChunkTypeParagraph,
	ChunkTypeImage,
} ChunkType;
@interface BKChunk : _BKChunk {}
+ (BKChunk *)chunkWithType:(ChunkType)chunkType andValue:(NSString*)value;
@end
