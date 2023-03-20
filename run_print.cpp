#include <stdio.h>

extern "C" void DodoPrint (const char* template_string, ...);

int main()
{

    DodoPrint ("У меня %d хромосом.\n", 10);
    
    DodoPrint ("Привет, %s, я твой %d-ый подписчик. %b%% меня хочет пицы c %o ананасов на ней \n" \
    "Завтра я поймаю %x женщин и покажу им свой o%co\n", "Ded", 54, 23, 1098, 45, 33);



    return 0;
}