#import "LicencePlateKeyboardPlugin.h"
#if __has_include(<licence_plate_keyboard/licence_plate_keyboard-Swift.h>)
#import <licence_plate_keyboard/licence_plate_keyboard-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "licence_plate_keyboard-Swift.h"
#endif

@implementation LicencePlateKeyboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLicencePlateKeyboardPlugin registerWithRegistrar:registrar];
}
@end
