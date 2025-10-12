##
## Agon C Build (agdev)
##

# Project
NAME			?= spritecollision
SRCDIR			?= src
BINDIR			?= bin
OBJDIR			?= obj

# Pretty output (disable with NO_COLOR=1)
ifndef NO_COLOR
RED     := \033[31m
GREEN   := \033[32m
YELLOW  := \033[33m
BLUE    := \033[34m
MAGENTA := \033[35m
CYAN    := \033[36m
BOLD    := \033[1m
DIM     := \033[2m
RESET   := \033[0m
else
RED     :=
GREEN   :=
YELLOW  :=
BLUE    :=
MAGENTA :=
CYAN    :=
BOLD    :=
DIM     :=
RESET   :=
endif

# Icons (disable with NO_EMOJI=1)
ifndef NO_EMOJI
OK      := ✓
ERR     := ✗
RUNSYM  := ▶
WRENCH  := 🔧
DISK    := 💾
BRUSH   := 🧹
endif

# Toolchain flags (forwarded to agdev)
CFLAGS			?= -Wall -Wextra -Oz
CXXFLAGS		?= -Wall -Wextra -Oz

RM				?= rm -f
RMDIR			?= rm -rf
MKDIRP			?= mkdir -p

# Emulator (mirrors asm/Makefile)
EMU				?= fab-agon-emulator
EMU_VDP			?= ~/development/tools/fab-agon/firmware/vdp_console8.so
EMU_MOS			?= ~/development/tools/fab-agon/firmware/mos_console8.bin
SDCARD_DIR		?= $(BINDIR)
EMU_FLAGS		?= --vdp $(EMU_VDP) --mos $(EMU_MOS) --sdcard $(SDCARD_DIR)/

# The agdev make rules
include $(shell cedev-config --makefile)

# Derived
PRIMARY_BIN		:= $(BINDIR)/$(NAME).bin

.DEFAULT_GOAL := build
.PHONY: build clean run help check-tools dirs

build: check-tools dirs $(PRIMARY_BIN)
	@printf "$(GREEN)$(OK) Build complete$(RESET) -> $(BOLD)$(PRIMARY_BIN)$(RESET)\n"

check-tools:
	@printf "$(BLUE)$(WRENCH) Checking tools...$(RESET)\n"
	@command -v cedev-config >/dev/null 2>&1 || { \
		printf "$(RED)$(ERR) Error: 'cedev-config' not found in PATH. Install agdev.$(RESET)\n"; \
		exit 1; \
	}
	@printf "$(GREEN)$(OK) Using $(BOLD)cedev-config$(RESET) at %s\n" "$(shell command -v cedev-config)"

dirs:
	@printf "$(CYAN)$(DISK) Ensuring output directories: $(BINDIR) $(OBJDIR)$(RESET)\n"
	@$(MKDIRP) $(BINDIR) $(OBJDIR)

clean:
	@printf "$(YELLOW)$(BRUSH) Cleaning artifacts...$(RESET)\n"
	@$(RMDIR) $(BINDIR) $(OBJDIR)

run: build
	@printf "$(CYAN)$(RUNSYM) Launching emulator...$(RESET)\n"
	@$(EMU) $(EMU_FLAGS)

help:
	@printf "$(BOLD)Targets:$(RESET)\n"
	@printf "  $(BOLD)build$(RESET)     - Build $(PRIMARY_BIN)\n"
	@printf "  $(BOLD)run$(RESET)       - Build and launch emulator mounting $(SDCARD_DIR)/\n"
	@printf "  $(BOLD)clean$(RESET)     - Remove build artifacts (bin/, obj/)\n"
	@printf "  $(BOLD)help$(RESET)      - Show this help\n\n"
	@printf "$(BOLD)Variables (override with make VAR=value):$(RESET)\n"
	@printf "  NAME=$(NAME)  SRCDIR=$(SRCDIR)  BINDIR=$(BINDIR)  OBJDIR=$(OBJDIR)\n"
	@printf "  CFLAGS=$(CFLAGS)  CXXFLAGS=$(CXXFLAGS)\n"
	@printf "  EMU=$(EMU)  EMU_VDP=$(EMU_VDP)  EMU_MOS=$(EMU_MOS)  SDCARD_DIR=$(SDCARD_DIR)\n"