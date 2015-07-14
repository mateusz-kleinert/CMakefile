EXEC=

CPP_FLAGS=
C_FLAGS=
CXX_FLAGS=

C_COMPILER=gcc
CXX_COMPILER=g++

INCL_DIRS=

function prepareIncludes {
	for incl in INCL_DIRS; do
		CPP_FLAGS="${CPP_FLAGS} -I ${incl}"
	done
}

prepareIncludes

OBJ_DIR=obj
LIB_DIR=../lib

LIBS=-lm

_DEPS = *.h
DEPS=

function prepareDeps {
	for incl in INCL_DIRS; do
		
		DEPS="$DEPS $(patsubst %,$(incl)/%,$(_DEPS))"
	done
}

_OBJ = *.o
OBJ = $(patsubst %,$(OBJ_DIR)/%,$(_OBJ))

$(OBJ_DIR)/%.o: %.c $(DEPS) 
	$(C_COMPILER) -c -o $@ $< $(C_FLAGS) ${CPP_FLAGS}

${EXEC}: $(OBJ)
	${C_COMPILER} -o $@ $^ $(C_FLAGS) ${CPP_FLAGS} $(LIBS)

.PHONY: clean

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f ${EXEC}
