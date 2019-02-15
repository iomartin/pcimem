function test_elf() {
    echo "------------------------"
    echo "Running "${FUNCNAME[0]}
    sudo ./pcimem /dev/pci_ubpf0 0 f tests/elf.o
    sudo ./pcimem /dev/pci_ubpf0 1048576 w 1
    sudo ./pcimem /dev/pci_ubpf0 2097152 w
    echo "Expected: 0x9"
}

function test_add() {
    echo "------------------------"
    echo "Running "${FUNCNAME[0]}
    sudo ./pcimem /dev/pci_ubpf0 0 f tests/add.ebpf
    sudo ./pcimem /dev/pci_ubpf0 1048576 w 1
    sudo ./pcimem /dev/pci_ubpf0 2097152 w
    echo "Expected: 0x3"
}

function load_memory() {
    echo "------------------------"
    echo "Running "${FUNCNAME[0]}
    sudo ./pcimem /dev/pci_ubpf0 0 f tests/ldxb.ebpf
    sudo ./pcimem /dev/pci_ubpf0 4 w 4                  # mem_len
    sudo ./pcimem /dev/pci_ubpf0 8388608 d 733293108718 # 0xaabbacddee
    sudo ./pcimem /dev/pci_ubpf0 1048576 w 1
    sudo ./pcimem /dev/pci_ubpf0 2097152 w
    echo "Expected: 0xAC"
}

function xor_with_memory() {
    echo "------------------------"
    echo "Running "${FUNCNAME[0]}
    sudo ./pcimem /dev/pci_ubpf0 0 f tests/xor.o         # load program
    sudo ./pcimem /dev/pci_ubpf0 8388608 m tests/mem.dat # load memory
    sudo ./pcimem /dev/pci_ubpf0 4 w 40                  # memory length
    sudo ./pcimem /dev/pci_ubpf0 1048576 w 1             # launch program
    sudo ./pcimem /dev/pci_ubpf0 2097152 w               # read result
    echo "Expected: 0x8F800BEE"
}

function test_data_file() {
    echo "------------------------"
    echo "Running "${FUNCNAME[0]}
    sudo ./pcimem /dev/pci_ubpf0 0 f tests/parameter.o   # load program
    sudo ./pcimem /dev/pci_ubpf0 8388608 m tests/mem.dat # load memory
    sudo ./pcimem /dev/pci_ubpf0 4 w 256                 # memory length
    sudo ./pcimem /dev/pci_ubpf0 1048576 w 1             # launch program
    sudo ./pcimem /dev/pci_ubpf0 2097152 w               # read result
    echo "Expected: 0x8C7C83F9"
}

test_elf
test_add
load_memory
test_data_file
xor_with_memory
