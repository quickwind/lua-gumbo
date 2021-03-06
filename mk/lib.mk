AR = ar -rc
RANLIB = ranlib

LIBGUMBO_FILES = \
    attribute error string_buffer tag utf8 vector char_ref parser \
    string_piece tokenizer util \

LIBGUMBO_OBJ = $(addprefix build/lib/, $(addsuffix .o, $(LIBGUMBO_FILES)))
LIBGUMBO_A = build/lib/libgumbo.a

$(LIBGUMBO_OBJ): CFLAGS += -Wall

$(LIBGUMBO_A): $(LIBGUMBO_OBJ)
	@$(PRINT) AR '$@'
	@$(AR) $@ $?
	@$(RANLIB) $@

$(LIBGUMBO_OBJ): build/lib/%.o: lib/%.c | build/lib/
	@$(PRINT) CC '$@'
	@$(CC) $(XCFLAGS) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

build/lib/:
	@$(MKDIR) '$@'


CLEANFILES += $(LIBGUMBO_A) $(LIBGUMBO_OBJ)

# sed -i '/^# sed/,$ { /^# sed/b; /^  gcc/b; d }' mk/lib.mk && \
  gcc -MM lib/*.c | sed 's|^\([^: ]\+:\)|build/lib/\1|' >> mk/lib.mk
build/lib/attribute.o: lib/attribute.c lib/attribute.h lib/gumbo.h lib/tag_enum.h \
 lib/util.h
build/lib/char_ref.o: lib/char_ref.c lib/char_ref.h lib/error.h lib/gumbo.h \
 lib/tag_enum.h lib/insertion_mode.h lib/string_buffer.h lib/token_type.h \
 lib/string_piece.h lib/utf8.h lib/util.h
build/lib/error.o: lib/error.c lib/error.h lib/gumbo.h lib/tag_enum.h \
 lib/insertion_mode.h lib/string_buffer.h lib/token_type.h lib/parser.h \
 lib/util.h lib/vector.h
build/lib/parser.o: lib/parser.c lib/attribute.h lib/gumbo.h lib/tag_enum.h \
 lib/error.h lib/insertion_mode.h lib/string_buffer.h lib/token_type.h \
 lib/parser.h lib/tokenizer.h lib/tokenizer_states.h lib/utf8.h \
 lib/util.h lib/vector.h
build/lib/string_buffer.o: lib/string_buffer.c lib/string_buffer.h lib/gumbo.h \
 lib/tag_enum.h lib/string_piece.h lib/util.h
build/lib/string_piece.o: lib/string_piece.c lib/string_piece.h lib/gumbo.h \
 lib/tag_enum.h lib/util.h
build/lib/tag.o: lib/tag.c lib/gumbo.h lib/tag_enum.h lib/tag_strings.h \
 lib/tag_sizes.h lib/tag_gperf.h
build/lib/tokenizer.o: lib/tokenizer.c lib/tokenizer.h lib/gumbo.h lib/tag_enum.h \
 lib/token_type.h lib/tokenizer_states.h lib/attribute.h lib/char_ref.h \
 lib/error.h lib/insertion_mode.h lib/string_buffer.h lib/parser.h \
 lib/string_piece.h lib/utf8.h lib/util.h lib/vector.h
build/lib/utf8.o: lib/utf8.c lib/utf8.h lib/gumbo.h lib/tag_enum.h lib/error.h \
 lib/insertion_mode.h lib/string_buffer.h lib/token_type.h lib/parser.h \
 lib/util.h lib/vector.h
build/lib/util.o: lib/util.c lib/util.h lib/gumbo.h lib/tag_enum.h lib/parser.h
build/lib/vector.o: lib/vector.c lib/vector.h lib/gumbo.h lib/tag_enum.h lib/util.h
