//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <licence_plate_keyboard/licence_plate_keyboard_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) licence_plate_keyboard_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LicencePlateKeyboardPlugin");
  licence_plate_keyboard_plugin_register_with_registrar(licence_plate_keyboard_registrar);
}
