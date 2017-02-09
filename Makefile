.PHONY = all clean install
all: boot.bin system.bit.bin

SYSTEM_BIT_BIN_DEPS = system.bit boot_a53_pl.bif
system.bit.bin: $(SYSTEM_BIT_BIN_DEPS)
	bootgen -image boot_a53_pl.bif -arch zynqmp -process_bitstream bin

BOOT_BIN_DEPS = bl31.elf boot_a53_ps.bif fsbl.elf pmu.elf system.bit u-boot.elf
boot.bin: $(BOOT_BIN_DEPS)
	 bootgen -image boot_a53_ps.bif -arch zynqmp -w -o i $@

clean:
	rm -f boot.bin system.bit.bin

install: all
	@echo Manually copy \'boot.bin\', \'system.bit.bin\', and \'uEnv.txt\' to BOOT partition on SD card
