QSORT(3)                             Linux Programmer's Manual                            QSORT(3)

NNAAMMEE
       qsort, qsort_r - sort an array

SSYYNNOOPPSSIISS
       ##iinncclluuddee <<ssttddlliibb..hh>>

       vvooiidd qqssoorrtt((vvooiidd **_b_a_s_e,, ssiizzee__tt _n_m_e_m_b,, ssiizzee__tt _s_i_z_e,,
                  iinntt ((**_c_o_m_p_a_r))((ccoonnsstt vvooiidd **,, ccoonnsstt vvooiidd **))));;

       vvooiidd qqssoorrtt__rr((vvooiidd **_b_a_s_e,, ssiizzee__tt _n_m_e_m_b,, ssiizzee__tt _s_i_z_e,,
                  iinntt ((**_c_o_m_p_a_r))((ccoonnsstt vvooiidd **,, ccoonnsstt vvooiidd **,, vvooiidd **)),,
                  vvooiidd **_a_r_g));;

   Feature Test Macro Requirements for glibc (see ffeeaattuurree__tteesstt__mmaaccrrooss(7)):

       qqssoorrtt__rr(): _GNU_SOURCE

DDEESSCCRRIIPPTTIIOONN
       The  qqssoorrtt()  function  sorts an array with _n_m_e_m_b elements of size _s_i_z_e.  The _b_a_s_e argument
       points to the start of the array.

       The contents of the array are sorted in ascending order according to a comparison  function
       pointed  to  by  _c_o_m_p_a_r, which is called with two arguments that point to the objects being
       compared.

       The comparison function must return an integer less than, equal to, or greater than zero if
       the  first  argument  is considered to be respectively less than, equal to, or greater than
       the second.  If two members compare as equal, their order in the sorted array is undefined.

       The qqssoorrtt__rr() function is identical to qqssoorrtt() except that the comparison  function  _c_o_m_p_a_r
       takes  a  third argument.  A pointer is passed to the comparison function via _a_r_g.  In this
       way, the comparison function does not need to use global variables to  pass  through  arbi‐
       trary arguments, and is therefore reentrant and safe to use in threads.

RREETTUURRNN VVAALLUUEE
       The qqssoorrtt() and qqssoorrtt__rr() functions return no value.

VVEERRSSIIOONNSS
       qqssoorrtt__rr() was added to glibc in version 2.8.

AATTTTRRIIBBUUTTEESS
       For an explanation of the terms used in this section, see aattttrriibbuutteess(7).

       ┌───────────────────┬───────────────┬─────────┐
       │IInntteerrffaaccee          │ AAttttrriibbuuttee     │ VVaalluuee   │
       ├───────────────────┼───────────────┼─────────┤
       │qqssoorrtt(), qqssoorrtt__rr() │ Thread safety │ MT-Safe │
       └───────────────────┴───────────────┴─────────┘

CCOONNFFOORRMMIINNGG TTOO
       qqssoorrtt(): POSIX.1-2001, POSIX.1-2008, C89, C99, SVr4, 4.3BSD.

NNOOTTEESS
       To  compare  C strings, the comparison function can call ssttrrccmmpp(3), as shown in the example
       below.

EEXXAAMMPPLLEE
       For one example of use, see the example under bbsseeaarrcchh(3).

       Another example is the following program, which sorts the strings given in its command-line
       arguments:

       #include <stdio.h>
       #include <stdlib.h>
       #include <string.h>

       static int
       cmpstringp(const void *p1, const void *p2)
       {
           /* The actual arguments to this function are "pointers to
              pointers to char", but strcmp(3) arguments are "pointers
              to char", hence the following cast plus dereference */

           return strcmp(* (char * const *) p1, * (char * const *) p2);
       }

       int
       main(int argc, char *argv[])
       {
           int j;

           if (argc < 2) {
               fprintf(stderr, "Usage: %s <string>...\n", argv[0]);
               exit(EXIT_FAILURE);
           }

           qsort(&argv[1], argc - 1, sizeof(char *), cmpstringp);

           for (j = 1; j < argc; j++)
               puts(argv[j]);
           exit(EXIT_SUCCESS);
       }

SSEEEE AALLSSOO
       ssoorrtt(1), aallpphhaassoorrtt(3), ssttrrccmmpp(3), vveerrssiioonnssoorrtt(3)

CCOOLLOOPPHHOONN
       This  page  is  part  of release 4.15 of the Linux _m_a_n_-_p_a_g_e_s project.  A description of the
       project, information about reporting bugs, and the latest version  of  this  page,  can  be
       found at https://www.kernel.org/doc/man-pages/.

                                            2017-09-15                                    QSORT(3)
