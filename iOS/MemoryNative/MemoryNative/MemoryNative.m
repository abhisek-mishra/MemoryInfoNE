//
//  ScreenShotLib.m
//  ScreenShotLib
//
//  Created by abhisek mishra on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#include "FlashRuntimeExtensions.h"
#import <Foundation/Foundation.h>
#import <mach/mach.h>







FREObject getMemoryInfo(FREContext ctx, void* funcData,uint32_t argc, FREObject argv[])
{
    
       
    uint32_t memUse = -1;
 
    FREObject retVal = nil;
   
    
    NSLog(@"Inside memory method");
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        NSLog(@"Memory in use (in bytes): %u", info.resident_size);
        memUse = info.resident_size;
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
        memUse = -1;
    }

  
    NSLog(@"Leaving memory method");
    
      FRENewObjectFromUint32(memUse,&retVal);
      return retVal;
    
    //return NULL;
     
}











void ContextInitializer(void * extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
	NSLog(@"In ContextInitializer Function");
	*numFunctionsToTest = 2;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*(*numFunctionsToTest));
	
	func[0].name = (const uint8_t*)"getMemoryInfo";
	func[0].functionData = NULL;
	func[0].function = &getMemoryInfo;
	
	
	
	*functionsToSet = func;
}

void ContextFinalizer(FREContext ctx)
{
	return;
}

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
	NSLog(@"in ExtInitializer");
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ContextInitializer;
	*ctxFinalizerToSet = &ContextFinalizer;
}

void ExtFinalizer(void * extData)
{
	return;
}
