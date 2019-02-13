int xor(int *mem)
{
    int len = mem[0];
    int res, i;
    if (len < 0)
        return 0;
    res = mem[1];
    for (i = 2; i < len+1; i++)
        res ^= mem[i];
    return res;
}
