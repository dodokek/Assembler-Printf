#include <stdio.h>

extern "C" void DodoPrint (const char* template_string, ...);

int main()
{

    DodoPrint ("У меня %d хромосом.\n", 47);
    
    DodoPrint ("Привет, %s, я твой %d-ый подписчик. %b%% меня хочет пицы c %o ананасов на ней \n" 
               "Завтра я поймаю %x женщин и покажу им свой o%co\n"
               "-what do you like now?\n"
               "%d %s %x %d%%%c%b\n", "Ded",
                54, 32, -64, 45, 33, -1, "love", 3802, 100, 33, 127);


    return 0;
}