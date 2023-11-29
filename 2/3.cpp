
#include <iostream>
int main()
{
    unsigned char data[] = {0x34, 0x45, 0x56, 0x67, 0xaf};
    for (int i = 0; i < 5; i++)
        std::cout << "0x" << std::hex << (int)data[i] << ' ';
    std::cout << std::endl;
    for (int i = 0; i < 5; i++)
    {
        unsigned char x = data[i];
        unsigned char a;
        _asm
            {
			mov cl, 4
			mov al, x
			mov bl, x
			shr al, cl
			shl bl, cl
			add al, bl
			mov a, al
            }
        std::cout << "0x" << std::hex << (int)a << ' ';
    }
    std::cout << std::endl;
    return 0;
}