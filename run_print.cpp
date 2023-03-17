extern "C" void DodoPrint (const char* template_string, ...);

int main()
{
    DodoPrint ("Bebrochka!\n");

    DodoPrint ("У меня %d хромосом.\n", 47);
    
    DodoPrint ("Hi %% %d %x %s %b \n", 127, 23, "Kekich", 65);
    return 0;
}