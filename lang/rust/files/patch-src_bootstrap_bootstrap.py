--- src/bootstrap/bootstrap.py.orig	2019-12-16 10:38:05.000000000 -0500
+++ src/bootstrap/bootstrap.py	2020-08-16 14:14:33.879270000 -0400
@@ -102,10 +102,10 @@
     return verified
 
 
-def unpack(tarball, dst, verbose=False, match=None):
+def unpack(tarball, tarball_suffix, dst, verbose=False, match=None):
     """Unpack the given tarball file"""
     print("extracting", tarball)
-    fname = os.path.basename(tarball).replace(".tar.gz", "")
+    fname = os.path.basename(tarball).replace(tarball_suffix, "")
     with contextlib.closing(tarfile.open(tarball)) as tar:
         for member in tar.getnames():
             if "/" not in member:
@@ -180,6 +180,7 @@
         'Darwin': 'apple-darwin',
         'DragonFly': 'unknown-dragonfly',
         'FreeBSD': 'unknown-freebsd',
+        'MidnightBSD': 'unknown-freebsd',
         'Haiku': 'unknown-haiku',
         'NetBSD': 'unknown-netbsd',
         'OpenBSD': 'unknown-openbsd'
@@ -331,6 +332,18 @@
         self.use_vendored_sources = ''
         self.verbose = False
 
+        def support_xz():
+            try:
+                with tempfile.NamedTemporaryFile(delete=False) as temp_file:
+                    temp_path = temp_file.name
+                with tarfile.open(temp_path, "w:xz") as tar:
+                    pass
+                return True
+            except tarfile.CompressionError:
+                return False
+
+        self.tarball_suffix = '.tar.xz' if support_xz() else '.tar.gz'
+
     def download_stage0(self):
         """Fetch the build system for Rust, written in Rust
 
@@ -349,12 +362,13 @@
                  self.program_out_of_date(self.rustc_stamp())):
             if os.path.exists(self.bin_root()):
                 shutil.rmtree(self.bin_root())
-            filename = "rust-std-{}-{}.tar.gz".format(
-                rustc_channel, self.build)
+            filename = "rust-std-{}-{}{}".format(
+                rustc_channel, self.build, self.tarball_suffix)
             pattern = "rust-std-{}".format(self.build)
             self._download_stage0_helper(filename, pattern)
 
-            filename = "rustc-{}-{}.tar.gz".format(rustc_channel, self.build)
+            filename = "rustc-{}-{}{}".format(rustc_channel, self.build,
+                                              self.tarball_suffix)
             self._download_stage0_helper(filename, "rustc")
             self.fix_executable("{}/bin/rustc".format(self.bin_root()))
             self.fix_executable("{}/bin/rustdoc".format(self.bin_root()))
@@ -365,14 +379,15 @@
             # libraries/binaries that are included in rust-std with
             # the system MinGW ones.
             if "pc-windows-gnu" in self.build:
-                filename = "rust-mingw-{}-{}.tar.gz".format(
-                    rustc_channel, self.build)
+                filename = "rust-mingw-{}-{}{}".format(
+                    rustc_channel, self.build, self.tarball_suffix)
                 self._download_stage0_helper(filename, "rust-mingw")
 
         if self.cargo().startswith(self.bin_root()) and \
                 (not os.path.exists(self.cargo()) or
                  self.program_out_of_date(self.cargo_stamp())):
-            filename = "cargo-{}-{}.tar.gz".format(cargo_channel, self.build)
+            filename = "cargo-{}-{}{}".format(cargo_channel, self.build,
+                                              self.tarball_suffix)
             self._download_stage0_helper(filename, "cargo")
             self.fix_executable("{}/bin/cargo".format(self.bin_root()))
             with output(self.cargo_stamp()) as cargo_stamp:
@@ -388,7 +403,7 @@
         tarball = os.path.join(rustc_cache, filename)
         if not os.path.exists(tarball):
             get("{}/{}".format(url, filename), tarball, verbose=self.verbose)
-        unpack(tarball, self.bin_root(), match=pattern, verbose=self.verbose)
+        unpack(tarball, self.tarball_suffix, self.bin_root(), match=pattern, verbose=self.verbose)
 
     @staticmethod
     def fix_executable(fname):
