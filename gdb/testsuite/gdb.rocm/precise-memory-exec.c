/* Copyright 2021-2025 Free Software Foundation, Inc.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

static void
second (void)
{
}

int
main (int argc, char **argv)
{
  if (argc == 1)
    {
      /* First invocation.  */
      int ret = execl (argv[0], argv[0], "Hello", NULL);
      perror ("exec");
      abort ();
    }
  else
    {
      /* Second invocation.  */
      second ();
    }

  return 0;
}
