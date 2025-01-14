https://github.com/boostorg/asio/commit/b5b17a67f0aa29f5156324d5e8a73dd8669a5a51

--- src/third_party/asio-master/asio/include/asio/detail/config.hpp.orig	2020-11-11 23:24:07 UTC
+++ src/third_party/asio-master/asio/include/asio/detail/config.hpp
@@ -784,8 +784,9 @@
 # if !defined(ASIO_DISABLE_STD_STRING_VIEW)
 #  if defined(__clang__)
 #   if (__cplusplus >= 201402)
-#    if __has_include(<experimental/string_view>)
+#    if __has_include(<string_view>)
 #     define ASIO_HAS_STD_STRING_VIEW 1
+#    elif __has_include(<experimental/string_view>)
 #     define ASIO_HAS_STD_EXPERIMENTAL_STRING_VIEW 1
 #    endif // __has_include(<experimental/string_view>)
 #   endif // (__cplusplus >= 201402)
