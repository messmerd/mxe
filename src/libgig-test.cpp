/*
 * This file is part of MXE. See LICENSE.md for licensing information.
 */

#include <gig.h>
#include <iostream>

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    try
    {
        RIFF::File riff{"nonexistent.gig"};
        gig::File gig{&riff};

        gig::Instrument* instrument = gig.GetFirstInstrument();
        if (instrument)
        {
            DLS::Info* info = instrument->pInfo;
            if (info)
            {
                std::cout << info->Name << "\n";
            }
        }
    }
    catch (...)
    {
    }

    return 0;
}
