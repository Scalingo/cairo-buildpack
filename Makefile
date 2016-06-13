default: scalingo

scalingo: dist/scalingo/pixman-0.34.0-1.tar.gz \
	        dist/scalingo/freetype-2.6.3-1.tar.gz \
					dist/scalingo/giflib-5.1.4-1.tar.gz \
					dist/scalingo/pango-1.40.1-1.tar.gz \
					dist/scalingo/cairo-1.14.6-1.tar.gz \
					dist/scalingo/fontconfig-2.11.95-1.tar.gz \
					dist/scalingo/harfbuzz-1.2.7-1.tar.gz

dist/scalingo/cairo-1.14.6-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/cairo-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv cairo-scalingo.tar.gz $@

dist/scalingo/fontconfig-2.11.95-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/fontconfig-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv fontconfig-scalingo.tar.gz $@

dist/scalingo/freetype-2.6.3-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/freetype-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv freetype-scalingo.tar.gz $@

dist/scalingo/giflib-5.1.4-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/giflib-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv giflib-scalingo.tar.gz $@

dist/scalingo/harfbuzz-1.2.7-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/harfbuzz-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv harfbuzz-scalingo.tar.gz $@

dist/scalingo/pango-1.40.1-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/pango-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pango-scalingo.tar.gz $@

dist/scalingo/pixman-0.34.0-1.tar.gz: cairo-scalingo
	docker cp $<:/tmp/pixman-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pixman-scalingo.tar.gz $@

clean:
	rm -rf src/ dist/ cairo-scalingo*/*.tar.*
	-docker rm cairo-scalingo

src/cairo.tar.xz:
	mkdir -p $$(dirname $@)
	curl -sL http://cairographics.org/releases/cairo-1.14.6.tar.xz -o $@

src/fontconfig.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.95.tar.bz2 -o $@

src/freetype.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://download.savannah.gnu.org/releases/freetype/freetype-2.6.3.tar.bz2 -o $@

src/giflib.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL "http://downloads.sourceforge.net/project/giflib/giflib-5.1.4.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fgiflib%2Ffiles%2F&ts=1465769547&use_mirror=heanet" -o $@
	

src/harfbuzz.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.2.7.tar.bz2 -o $@

src/pango.tar.xz:
	mkdir -p $$(dirname $@)
	curl -sL http://ftp.gnome.org/pub/GNOME/sources/pango/1.40/pango-1.40.1.tar.xz -o $@

src/pixman.tar.gz:
	mkdir -p $$(dirname $@)
	curl -sL http://cairographics.org/releases/pixman-0.34.0.tar.gz -o $@

.PHONY: scalingo-stack

scalingo-stack:
	@docker pull scalingo/builder:v22 && \
  	  docker tag scalingo/builder:v22 $@:latest

.PHONY: cairo-scalingo

cairo-scalingo: scalingo-stack cairo-scalingo/pixman.tar.gz cairo-scalingo/freetype.tar.bz2 cairo-scalingo/giflib.tar.bz2 cairo-scalingo/cairo.tar.xz cairo-scalingo/pango.tar.xz cairo-scalingo/fontconfig.tar.bz2 cairo-scalingo/harfbuzz.tar.bz2
	docker build --rm -t $@ $@
	-docker rm $@
	docker run --name $@ $@ /bin/echo $@

cairo-scalingo/cairo.tar.xz: src/cairo.tar.xz
	ln -f $< $@

cairo-scalingo/fontconfig.tar.bz2: src/fontconfig.tar.bz2
	ln -f $< $@

cairo-scalingo/freetype.tar.bz2: src/freetype.tar.bz2
	ln -f $< $@

cairo-scalingo/giflib.tar.bz2: src/giflib.tar.bz2
	ln -f $< $@

cairo-scalingo/harfbuzz.tar.bz2: src/harfbuzz.tar.bz2
	ln -f $< $@

cairo-scalingo/pango.tar.xz: src/pango.tar.xz
	ln -f $< $@

cairo-scalingo/pixman.tar.gz: src/pixman.tar.gz
	ln -f $< $@
