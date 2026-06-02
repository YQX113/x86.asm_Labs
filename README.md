## Project Overview

The examples cover arithmetic operations, memory access, stack manipulation, screen output, interrupt handling, keyboard input, timing, and simple hardware interaction.



## Environment

- **DOSBox-X**: https://dosbox-x.com/
- **DOSBox**: https://www.dosbox.com/index.php
- **MS-DOS**: https://winworldpc.com/product/ms-dos/50



## How to Run

```bash
mount c x:\MASM
c:
masm x:\Resource Files\code.asm
link code.obj
debug code.exe
```



## Lab Contents
| Fragment | Lines     | Function                                            |
| -------- | --------- | --------------------------------------------------- |
| 1        | 1-12      | Basic arithmetic operations and program termination |
| 2        | 15-27     | Loop-based multiplication                           |
| 3        | 30-49     | Memory access and arithmetic operations             |
| 4        | 52-73     | Memory array summation                              |
| 5        | 75-95     | Memory array summation (alternative approach)       |
| 6        | 98-121    | Memory data transfer                                |
| 7        | 123-145   | Memory data transfer with offset                    |
| 8        | 147-199   | Stack-based data manipulation                       |
| 9        | 202-236   | Screen text output                                  |
| 10       | 238-375   | Video mode setup and screen clearing                |
| 11       | 377-406   | Simple string output                                |
| 12       | 408-497   | Error handling and interrupt redirection            |
| 13       | 499-563   | Interrupt service routine setup                     |
| 14       | 565-641   | Interrupt service routine with string processing    |
| 15       | 643-664   | Screen cursor positioning and text output           |
| 16       | 665-731   | Screen text output with delay                       |
| 17       | 733-755   | Timer configuration                                 |
| 18       | 757-785   | Real-time clock display                             |
| 19       | 788-914   | Real-time clock with binary/BCD conversion          |
| 20       | 916-1085  | Keyboard interrupt handler                          |
| 21       | 1087-1172 | Keyboard interrupt handler with color change        |
| 22       | 1174-1224 | Color change based on keyboard input                |
| 23       | 1226-1393 | Keyboard input with stack-based character handling  |
| 24       | 1395-1507 | Musical note playback                               |
| 25       | 1509-1533 | Simple string output                                |
| 26       | 1535-1563 | Function call demonstration                         |
| 27       | 1564-1581 | Library macro usage                                 |



## License

This project is for educational purposes.



-----
> [!NOTE]
> · Necessary documents：MASM.EXE、LINK.EXE、CREF.EXE、debug.exe \
> · The file runs in a virtual 8086 environment, the exact file names and path may vary depending on your local setup. \
> · enjoy！
