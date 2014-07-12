//	The MIT License (MIT)
//
//	Copyright (c) 2014 Jens Meder
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.

#import "JMTerminalViewModel.h"
#import "RscMgr.h"

@interface JMTerminalViewModel () <RscMgrDelegate>

@end

@implementation JMTerminalViewModel
{
	@private
	
	RscMgr* _serialManager;
}

-(instancetype)initWithSerialManager:(RscMgr *)serialManager
{
	self = [super init];

	if (self)
	{
		_serialManager = serialManager;
		[_serialManager setDelegate:self];
		_receivedText = @"";
	}

	return self;
}

-(void)sendMessage:(NSString *)message
{
	if (_connected)
	{
		[_serialManager writeString:message];
	}
}

-(void)setConnected:(BOOL)connected
{
	[self willChangeValueForKey:@"connected"];
	
	_connected = connected;
	
	[self didChangeValueForKey:@"connected"];
}

-(void)setReceivedText:(NSString *)receivedText
{
	[self willChangeValueForKey:@"receivedText"];
	
	_receivedText = receivedText;
	
	[self didChangeValueForKey:@"receivedText"];
}

#pragma mark - Delegate

-(void) readBytesAvailable:(UInt32)length
{
	NSString* message = [_serialManager getStringFromBytesAvailable];

	[self setReceivedText:[_receivedText stringByAppendingFormat:@"%@\n",message]];
}

-(void)cableConnected:(NSString *)protocol
{
	[self setConnected:YES];
}

-(void)cableDisconnected
{
	[self setConnected:NO];
}

-(void)portStatusChanged
{
}

@end
