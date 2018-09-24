int main(void) 
{
    char buf[] = {'H', 'e', 'l', 'l', 'o', '\n', '\0'};
    write(1, buf, sizeof(buf));
    exit(0);
}
