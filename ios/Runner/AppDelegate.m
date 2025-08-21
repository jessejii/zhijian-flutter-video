#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#include "FlutterDownloaderPlugin.h" //flutter downloader支持

@implementation AppDelegate

void registerPlugins(NSObject<FlutterPluginRegistry>* registry) {
  if (![registry hasPlugin:@"FlutterDownloaderPlugin"]) {
     [FlutterDownloaderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterDownloaderPlugin"]];
  }
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [FlutterDownloaderPlugin setPluginRegistrantCallback:registerPlugins];  //flutter downloader支持
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
