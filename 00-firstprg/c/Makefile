# ----------------------------
# Makefile Options
# ----------------------------

FAB_AGON_EMU       = fab-agon-emulator
FAB_AGON_EMU_FLAGS = --vdp ~/development/tools/fab-agon/firmware/vdp_console8.so --mos ~/development/tools/fab-agon/firmware/mos_console8.bin --sdcard bin/
NAME = firstprg

CFLAGS = -Wall -Wextra -Oz
CXXFLAGS = -Wall -Wextra -Oz

include $(shell cedev-config --makefile)

run:
	@echo "Launching emulator..."
	$(FAB_AGON_EMU) $(FAB_AGON_EMU_FLAGS) 