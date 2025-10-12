##
## Agon ez80 Assembly Build
##

# Project
TARGET			?= spritecollision
SRCDIR			?= src
BINDIR			?= bin

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

# Toolchain (Agon eZ80 assembler)
EZ80ASM          ?= ez80asm
# Default flags: verbose stats (-x), ADL on (-a 1), origin 0x040000 (-o 040000)
EZ80ASM_FLAGS    ?= -x -a 1 -o 040000
RM				?= rm -f
RMDIR			?= rm -rf
MKDIRP			?= mkdir -p

# Emulator
EMU				?= fab-agon-emulator
EMU_VDP			?= ~/development/tools/fab-agon/firmware/vdp_console8.so
EMU_MOS			?= ~/development/tools/fab-agon/firmware/mos_console8.bin
SDCARD_DIR		?= $(BINDIR)
EMU_FLAGS		?= --vdp $(EMU_VDP) --mos $(EMU_MOS) --sdcard $(SDCARD_DIR)/

# Derived
ASM_SOURCES		:= $(wildcard $(SRCDIR)/*.asm)
BINARIES		:= $(patsubst $(SRCDIR)/%.asm,$(BINDIR)/%.bin,$(ASM_SOURCES))
PRIMARY_BIN		:= $(BINDIR)/$(TARGET).bin

.DEFAULT_GOAL := all
.PHONY: all all-bins clean run help check-tools dirs

all: check-tools dirs $(PRIMARY_BIN)
	@printf "$(GREEN)$(OK) Build complete$(RESET) -> $(BOLD)$(PRIMARY_BIN)$(RESET)\n"

# Build all discovered ASM sources to bin/
all-bins: check-tools dirs $(BINARIES)
	@printf "$(GREEN)$(OK) Built$(RESET): $(BOLD)$(BINARIES)$(RESET)\n"

# Ensure required tools are available

check-tools:
	@printf "$(BLUE)$(WRENCH) Checking tools...$(RESET)\n"
	@command -v $(EZ80ASM) >/dev/null 2>&1 || { \
		printf "$(RED)$(ERR) Error: '%s' not found in PATH. Expected Agon ez80asm.$(RESET)\n" "$(EZ80ASM)"; \
		exit 1; \
	}
	@printf "$(GREEN)$(OK) Using $(BOLD)%s$(RESET) at %s\n" "$(EZ80ASM)" "$(shell command -v $(EZ80ASM))"

# Create output directories
dirs:
	@printf "$(CYAN)$(DISK) Ensuring output directory: $(BINDIR)$(RESET)\n"
	@$(MKDIRP) $(BINDIR)


$(BINDIR)/%.bin: $(SRCDIR)/%.asm | dirs
	@printf "$(MAGENTA)Assembling$(RESET) %s $(DIM)->$(RESET) %s\n" "$<" "$@"
	@$(EZ80ASM) $< $@ $(EZ80ASM_FLAGS)

$(PRIMARY_BIN): $(SRCDIR)/main.asm | dirs
	@printf "$(MAGENTA)Assembling$(RESET) %s $(DIM)->$(RESET) %s\n" "$<" "$@"
	@$(EZ80ASM) $< $@ $(EZ80ASM_FLAGS)

clean:
	@printf "$(YELLOW)$(BRUSH) Cleaning artifacts...$(RESET)\n"
	@$(RMDIR) $(BINDIR)

run: all
	@printf "$(CYAN)$(RUNSYM) Launching emulator...$(RESET)\n"
	@$(EMU) $(EMU_FLAGS)

help:
	@printf "$(BOLD)Targets:$(RESET)\n"
	@printf "  $(BOLD)all$(RESET)       - Build $(PRIMARY_BIN)\n"
	@printf "  $(BOLD)all-bins$(RESET)  - Build all $(SRCDIR)/*.asm to $(BINDIR)/*.bin\n"
	@printf "  $(BOLD)run$(RESET)       - Build and launch emulator mounting $(SDCARD_DIR)/\n"
	@printf "  $(BOLD)clean$(RESET)     - Remove build artifacts (bin/)\n"
	@printf "  $(BOLD)help$(RESET)      - Show this help\n\n"
	@printf "$(BOLD)Variables (override with make VAR=value):$(RESET)\n"
	@printf "  TARGET=$(TARGET)  SRCDIR=$(SRCDIR)  BINDIR=$(BINDIR)\n"
	@printf "  EZ80ASM=$(EZ80ASM)  EZ80ASM_FLAGS=$(EZ80ASM_FLAGS)\n"
	@printf "  EMU=$(EMU)  EMU_VDP=$(EMU_VDP)  EMU_MOS=$(EMU_MOS)  SDCARD_DIR=$(SDCARD_DIR)\n"