package com.open
{
	import flash.external.ExtensionContext;
	
	import flashx.textLayout.formats.Float;
	
	
	
	public class MemoryInfo
	{
		public var extContext:ExtensionContext;
		
		
		public function MemoryInfo()
		{
			extContext = ExtensionContext.createExtensionContext("com.open.MemoryInfoNE","type");
			
		}
		public function getMemoryInfo():Number{
			
			
			return extContext.call("getMemoryInfo") as Number;
			
			
		}
		
		
		public function disposeNative():void
		{
			extContext.dispose();	
		}
	}
}