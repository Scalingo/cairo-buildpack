default: scalingo-14 scalingo-18

scalingo-14: dist/scalingo-14/pixman-0.34.0-1.tar.gz \
	        dist/scalingo-14/freetype-2.6.3-1.tar.gz \
					dist/scalingo-14/giflib-5.1.4-1.tar.gz \
					dist/scalingo-14/pango-1.40.1-1.tar.gz \
					dist/scalingo-14/cairo-1.14.6-1.tar.gz \
					dist/scalingo-14/fontconfig-2.13.1-1.tar.gz \
					dist/scalingo-14/harfbuzz-1.2.7-1.tar.gz

scalingo-18: dist/scalingo-18/pixman-0.34.0-1.tar.gz \
	        dist/scalingo-18/freetype-2.6.3-1.tar.gz \
					dist/scalingo-18/giflib-5.1.4-1.tar.gz \
					dist/scalingo-18/pango-1.40.1-1.tar.gz \
					dist/scalingo-18/cairo-1.14.6-1.tar.gz \
					dist/scalingo-18/fontconfig-2.13.1-1.tar.gz \
					dist/scalingo-18/harfbuzz-1.2.7-1.tar.gz

dist/scalingo-14/cairo-1.14.6-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/cairo-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv cairo-scalingo.tar.gz $@

dist/scalingo-14/fontconfig-2.13.1-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/fontconfig-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv fontconfig-scalingo.tar.gz $@

dist/scalingo-14/freetype-2.6.3-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/freetype-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv freetype-scalingo.tar.gz $@

dist/scalingo-14/giflib-5.1.4-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/giflib-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv giflib-scalingo.tar.gz $@

dist/scalingo-14/harfbuzz-1.2.7-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/harfbuzz-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv harfbuzz-scalingo.tar.gz $@

dist/scalingo-14/pango-1.40.1-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/pango-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pango-scalingo.tar.gz $@

dist/scalingo-14/pixman-0.34.0-1.tar.gz: cairo-scalingo-14
	docker cp $<:/tmp/pixman-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pixman-scalingo.tar.gz $@

dist/scalingo-18/cairo-1.14.6-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/cairo-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv cairo-scalingo.tar.gz $@

dist/scalingo-18/fontconfig-2.13.1-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/fontconfig-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv fontconfig-scalingo.tar.gz $@

dist/scalingo-18/freetype-2.6.3-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/freetype-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv freetype-scalingo.tar.gz $@

dist/scalingo-18/giflib-5.1.4-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/giflib-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv giflib-scalingo.tar.gz $@

dist/scalingo-18/harfbuzz-1.2.7-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/harfbuzz-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv harfbuzz-scalingo.tar.gz $@

dist/scalingo-18/pango-1.40.1-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/pango-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pango-scalingo.tar.gz $@

dist/scalingo-18/pixman-0.34.0-1.tar.gz: cairo-scalingo-18
	docker cp $<:/tmp/pixman-scalingo.tar.gz .
	mkdir -p $$(dirname $@)
	mv pixman-scalingo.tar.gz $@

clean:
	rm -rf src/ dist/ cairo-scalingo*/*.tar.*
	-docker rm cairo-scalingo-14 cairo-scalingo-18

src/cairo.tar.xz:
	mkdir -p $$(dirname $@)
	curl -sL http://cairographics.org/releases/cairo-1.14.6.tar.xz -o $@

src/fontconfig.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -sL http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.1.tar.bz2 -o $@

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

scalingo-18-stack:
	@docker pull scalingo/scalingo-18:latest && \
  	  docker tag scalingo/scalingo-18:latest $@:latest

scalingo-14-stack:
	@docker pull scalingo/scalingo-14:latest && \
  	  docker tag scalingo/scalingo-14:latest $@:latest

.PHONY: cairo-scalingo

cairo-scalingo-14: scalingo-14-stack cairo-scalingo/pixman.tar.gz cairo-scalingo/freetype.tar.bz2 cairo-scalingo/giflib.tar.bz2 cairo-scalingo/cairo.tar.xz cairo-scalingo/pango.tar.xz cairo-scalingo/fontconfig.tar.bz2 cairo-scalingo/harfbuzz.tar.bz2
	docker build -f cairo-scalingo/Dockerfile-scalingo-14 --no-cache --rm -t $@ cairo-scalingo
	-docker rm $@
	docker run --name $@ $@ /bin/echo $@

cairo-scalingo-18: scalingo-18-stack cairo-scalingo/pixman.tar.gz cairo-scalingo/freetype.tar.bz2 cairo-scalingo/giflib.tar.bz2 cairo-scalingo/cairo.tar.xz cairo-scalingo/pango.tar.xz cairo-scalingo/fontconfig.tar.bz2 cairo-scalingo/harfbuzz.tar.bz2
	docker build -f cairo-scalingo/Dockerfile-scalingo-18 --no-cache --rm -t $@ cairo-scalingo
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
