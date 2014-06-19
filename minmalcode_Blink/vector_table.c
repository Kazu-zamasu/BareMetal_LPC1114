// 割り込みベクタの配置は DUI0497A_cortex_m0_r0p0_generic_ug.pdf の2-22ページ参照

// リンカスクリプトより参照
extern void* stack_entry;
// スタートアップ：startup.S の関数
extern void* _start(void);

// 割り込みハンドラの宣言
void NMI_Handler(void);
void HardFault_Handler(void);
void SVCall_Handler(void);
void PendSV_Handler(void);
void SysTick_Handler(void);
void IRQ0(void);

// Declare a weak alias macro as described in the GCC manual[1][2]
#define SECTION(s) __attribute__ ((section(s)))

// ベクタテーブルを定義する
const void *vectors[] SECTION(".irq_vectors") =
{
    &stack_entry,
    _start,

    // Various fault handlers
    NMI_Handler,           // The NMI handler
    HardFault_Handler,     // The hard fault handler
    0,                     // Reserved
    0,                     // Reserved
    0,                     // Reserved
    0,                     // Reserved
    0,                     // Reserved
    0,                     // Reserved
    0,                     // Reserved
    SVCall_Handler,        // SVCall handler
    0,                     // Reserved
    0,                     // Reserved
    PendSV_Handler,        // The PendSV handler
    SysTick_Handler,       // The SysTick handler
    // 以下 IQR0 ~ IRQn まで入力割り込み
    IRQ0
};


void loop(void){
    while(1);
}

// 割り込みはとりあえずループに落とす
void NMI_Handler(void){
    loop();
}

void HardFault_Handler(void){
    loop();
}

void SVCall_Handler(void){
    loop();
}

void PendSV_Handler(void){
    loop();
}

void SysTick_Handler(void){
    loop();
}

void IRQ0(void){
    loop();
}