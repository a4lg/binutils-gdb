/* This testcase is part of GDB, the GNU debugger.

   Copyright 2007-2025 Free Software Foundation, Inc.

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

/* This program is intended to be started outside of gdb, and then
   attached to by gdb.  It loops for a while, but not forever.  */

#include <unistd.h>
#include <pthread.h>

static void *
thread_func (void *arg)
{
  int i;

  for (i = 0; i < 120; i++)
    sleep (1);

  return NULL;
}

int main ()
{
  int i;
  pthread_t thread;

  pthread_create (&thread, NULL, thread_func, NULL);

  for (i = 0; i < 120; i++)
    sleep (1);

  pthread_join (thread, NULL);

  return 0;
}
