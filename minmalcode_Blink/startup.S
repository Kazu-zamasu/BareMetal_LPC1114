@ startup
	.global _start
	.align
_start:
	// main呼び出し
	bl main

	// 終了（無限ループ）
	b .