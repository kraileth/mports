--- src/Makefile.orig	2020-05-15 16:29:52.000000000 -0400
+++ src/Makefile	2020-05-16 12:20:46.728148000 -0400
@@ -16,7 +16,7 @@
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 OPTIMIZATION?=-O2
-DEPENDENCY_TARGETS=hiredis linenoise lua
+DEPENDENCY_TARGETS=hiredis linenoise
 NODEPS:=clean distclean
 
 # Default settings
@@ -73,8 +73,8 @@
 # Override default settings if possible
 -include .make-settings
 
-FINAL_CFLAGS=$(STD) $(WARN) $(OPT) $(DEBUG) $(CFLAGS) $(REDIS_CFLAGS)
-FINAL_LDFLAGS=$(LDFLAGS) $(REDIS_LDFLAGS) $(DEBUG)
+FINAL_CFLAGS=$(STD) $(WARN) $(OPT) $(DEBUG) $(CFLAGS)
+FINAL_LDFLAGS=$(LDFLAGS) $(DEBUG)
 FINAL_LIBS=-lm
 DEBUG=-g -ggdb
 
@@ -149,7 +149,7 @@
 endif
 endif
 # Include paths to dependencies
-FINAL_CFLAGS+= -I../deps/hiredis -I../deps/linenoise -I../deps/lua/src
+FINAL_CFLAGS+= -I../deps/hiredis -I../deps/linenoise
 
 # Determine systemd support and/or build preference (defaulting to auto-detection)
 BUILD_WITH_SYSTEMD=no
@@ -197,6 +197,9 @@
     FINAL_LIBS += ../deps/hiredis/libhiredis_ssl.a -lssl -lcrypto
 endif
 
+FINAL_CFLAGS+=-I${PREFIX}/include/lua51
+FINAL_LIBS+= -L${PREFIX}/lib -llua-5.1
+
 REDIS_CC=$(QUIET_CC)$(CC) $(FINAL_CFLAGS)
 REDIS_LD=$(QUIET_LINK)$(CC) $(FINAL_LDFLAGS)
 REDIS_INSTALL=$(QUIET_INSTALL)$(INSTALL)
@@ -217,6 +220,7 @@
 REDIS_SERVER_NAME=redis-server$(PROG_SUFFIX)
 REDIS_SENTINEL_NAME=redis-sentinel$(PROG_SUFFIX)
 REDIS_SERVER_OBJ=adlist.o quicklist.o ae.o anet.o dict.o server.o sds.o zmalloc.o lzf_c.o lzf_d.o pqsort.o zipmap.o sha1.o ziplist.o release.o networking.o util.o object.o db.o replication.o rdb.o t_string.o t_list.o t_set.o t_zset.o t_hash.o config.o aof.o pubsub.o multi.o debug.o sort.o intset.o syncio.o cluster.o crc16.o endianconv.o slowlog.o scripting.o bio.o rio.o rand.o memtest.o crcspeed.o crc64.o bitops.o sentinel.o notify.o setproctitle.o blocked.o hyperloglog.o latency.o sparkline.o redis-check-rdb.o redis-check-aof.o geo.o lazyfree.o module.o evict.o expire.o geohash.o geohash_helper.o childinfo.o defrag.o siphash.o rax.o t_stream.o listpack.o localtime.o lolwut.o lolwut5.o lolwut6.o acl.o gopher.o tracking.o connection.o tls.o sha256.o timeout.o setcpuaffinity.o mt19937-64.o
+REDIS_SERVER_OBJ+=fpconv.o lua_bit.o lua_cjson.o lua_cmsgpack.o lua_struct.o strbuf.o
 REDIS_CLI_NAME=redis-cli$(PROG_SUFFIX)
 REDIS_CLI_OBJ=anet.o adlist.o dict.o redis-cli.o zmalloc.o release.o ae.o crcspeed.o crc64.o siphash.o crc16.o mt19937-64.o
 REDIS_BENCHMARK_NAME=redis-benchmark$(PROG_SUFFIX)
@@ -268,7 +272,7 @@
 
 # redis-server
 $(REDIS_SERVER_NAME): $(REDIS_SERVER_OBJ)
-	$(REDIS_LD) -o $@ $^ ../deps/hiredis/libhiredis.a ../deps/lua/src/liblua.a $(FINAL_LIBS)
+	$(REDIS_LD) -o $@ $^ ../deps/hiredis/libhiredis.a $(FINAL_LIBS)
 
 # redis-sentinel
 $(REDIS_SENTINEL_NAME): $(REDIS_SERVER_NAME)
