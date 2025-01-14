--- src/3rdparty/gn/build/gen.py.orig	2019-03-07 04:23:57.000000000 -0500
+++ src/3rdparty/gn/build/gen.py	2019-10-06 13:06:52.762743000 -0400
@@ -41,10 +41,14 @@
       self._platform = 'aix'
     elif self._platform.startswith('fuchsia'):
       self._platform = 'fuchsia'
+    elif self._platform.lower().startswith('freebsd'):
+      self._platform = 'bsd'
+    elif self._platform.lower().startswith('midnightbsd'):
+      self._platform = 'bsd'
 
   @staticmethod
   def known_platforms():
-    return ['linux', 'darwin', 'msvc', 'aix', 'fuchsia']
+    return ['linux', 'darwin', 'msvc', 'aix', 'fuchsia', 'bsd']
 
   def platform(self):
     return self._platform
@@ -67,8 +71,11 @@
   def is_aix(self):
     return self._platform == 'aix'
 
+  def is_bsd(self):
+    return self._platform == 'bsd'
+
   def is_posix(self):
-    return self._platform in ['linux', 'darwin', 'aix']
+    return self._platform in ['linux', 'darwin', 'aix', 'bsd']
 
 
 def main(argv):
@@ -221,6 +228,7 @@
       'darwin': 'build_mac.ninja.template',
       'linux': 'build_linux.ninja.template',
       'aix': 'build_aix.ninja.template',
+      'bsd': 'build_linux.ninja.template',
   }[platform.platform()])
 
   with open(template_filename) as f:
@@ -388,6 +396,11 @@
     elif platform.is_aix():
       cflags_cc.append('-maix64')
       ldflags.extend(['-maix64', '-pthread'])
+    elif platform.is_bsd():
+      cflags.extend(['-Wno-deprecated-register', '-Wno-parentheses-equality'])
+      ldflags.extend(['-pthread'])
+      libs.extend(['-lexecinfo', '-lkvm'])
+      include_dirs += ['/usr/local/include']
 
     if options.use_lto:
       cflags.extend(['-flto', '-fwhole-program-vtables'])
@@ -686,7 +699,7 @@
         'base/strings/string16.cc',
     ])
 
-  if platform.is_linux() or platform.is_aix():
+  if platform.is_linux() or platform.is_aix() or platform.is_bsd():
     static_libraries['base']['sources'].extend([
         'base/strings/sys_string_conversions_posix.cc',
     ])
