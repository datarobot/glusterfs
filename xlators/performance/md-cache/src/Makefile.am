xlator_LTLIBRARIES = md-cache.la
xlatordir = $(libdir)/glusterfs/xlator/performance

md_cache_la_LDFLAGS = -module $(GF_XLATOR_DEFAULT_LDFLAGS)

md_cache_la_SOURCES = md-cache.c
md_cache_la_LIBADD = $(top_builddir)/libglusterfs/src/libglusterfs.la

noinst_HEADERS = md-cache-mem-types.h md-cache-messages.h

AM_CPPFLAGS = $(GF_CPPFLAGS) -I$(top_srcdir)/libglusterfs/src \
	-I$(top_srcdir)/rpc/xdr/src -I$(top_builddir)/rpc/xdr/src \
	-I$(CONTRIBDIR)/rbtree

AM_CFLAGS = -Wall $(GF_CFLAGS)

CLEANFILES =


stat-prefetch-compat:
	mkdir -p $(DESTDIR)$(libdir)/glusterfs/xlator/performance
	rm -rf $(DESTDIR)$(libdir)/glusterfs/xlator/performance/stat-prefetch.so
	ln -s ./md-cache.so $(DESTDIR)$(libdir)/glusterfs/xlator/performance/stat-prefetch.so


install-exec-local: stat-prefetch-compat

uninstall-local:
	rm -f $(DESTDIR)$(libdir)/glusterfs/xlator/performance/stat-prefetch.so
