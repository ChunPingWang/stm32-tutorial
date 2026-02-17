# Blinky - STM32F401RE LED 閃爍專案

## 硬體
- Nucleo-F401RE (STM32F401RET6)
- LED 在 PA5 (LD2 - 綠色 LED)

## 前置需求

### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi libnewlib-arm-none-eabi openocd stm32flash
```

### macOS
```bash
brew install --cask gcc-arm-embedded
brew install openocd
```

### Windows
- 安裝 [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html) (推薦)
- 或安裝 [GNU ARM Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm)

## 編譯
```bash
cd blinky
make
```

## 燒錄

### 選項 1: stm32flash (透過 USB)
```bash
make flash SERIAL=/dev/ttyACM0
```

### 選項 2: OpenOCD (透過 ST-Link)
```bash
make flash
```

## 偵錯
```bash
make debug
```

## 專案結構
```
blinky/
├── Makefile
├── STM32F401RE_FLASH.ld    # 連結腳本
└── Core/
    ├── Src/
    │   ├── main.c          # 應用程式
    │   └── startup_stm32f401xe.s  # 啟動程式
    └── Inc/
```

## 設定與下一步

### 1. 安裝 ARM 工具鏈

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi libnewlib-arm-none-eabi openocd stm32flash
```

**macOS:**
```bash
brew install --cask gcc-arm-embedded
brew install openocd
```

**Windows:**
- 下載 [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)

### 2. 生成 HAL 檔案

此專案需要 STM32 HAL 庫。您有兩個選項：

**選項 A: 使用 STM32CubeMX (推薦)**
1. 下載 [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
2. 建立新專案 → 選擇「Nucleo-F401RE」
3. 腳位配置: PA5 → GPIO_Output (LED)
4. 專案設定:
   - 工具鏈: Makefile
   - HAL: GPIO
5. 專案 → 生成程式碼
6. 複製以下資料夾到此專案:
   - `Inc/` (包含 stm32f4xx_hal.h 等)
   - `Drivers/`

**選項 B: 使用 STM32CubeIDE (對初學者最簡單)**
1. 下載 [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)
2. 檔案 → 新增 → STM32 專案
3. 選擇「Nucleo-F401RE」
4. 設定 LED 在 PA5
5. 生成程式碼並匯入

### 3. 編譯與燒錄
```bash
make          # 編譯
make flash    # 透過 ST-Link 燒錄
```

## 學習路徑

閃爍專案完成後，可繼續學習：
1. 按鈕輸入 + 中斷
2. UART 序列通訊
3. PWM 輸出
4. ADC 讀取
5. I2C/SPI 感測器
