/*  Last saved: Sun 06 Sep 2009 02:09:23 PM*/

/*  Copyright (c) 1998 Kenneth Albanowski. All rights reserved.
 *  Copyright (c) 2007 Bob Free. All rights reserved.
 *  Copyright (c) 2009 Chris Marshall. All rights reserved.
 *  This program is free software; you can redistribute it and/or
 *  modify it under the same terms as Perl itself.
 */

/* This ends up being GLUT.pm */
#define IN_POGL_MAIN_XS

#include <stdio.h>

#include "pgopogl.h"

#ifdef IN_POGL_MAIN_XS

=head2 Miscellaneous

Various BOOT utilities defined in GLUT.xs

=over

=item PGOPOGL_CALL_BOOT(name)

call the boot code of a module by symbol rather than by name.

in a perl extension which uses several xs files but only one pm, you
need to bootstrap the other xs files in order to get their functions
exported to perl.  if the file has MODULE = Foo::Bar, the boot symbol
would be boot_Foo__Bar.

=item void _pgopogl_call_XS (pTHX_ void (*subaddr) (pTHX_ CV *), CV * cv, SV ** mark);

never use this function directly.  see C<PGOPOGLL_CALL_BOOT>.

for the curious, this calls a perl sub by function pointer rather than
by name; call_sv requires that the xsub already be registered, but we
need this to call a function which will register xsubs.  this is an
evil hack and should not be used outside of the PGOPOGL_CALL_BOOT macro.
it's implemented as a function to avoid code size bloat, and exported
so that extension modules can pull the same trick.

=back

=cut

void
_pgopogl_call_XS (pTHX_ void (*subaddr) (pTHX_ CV *), CV * cv, SV ** mark)
{
	dSP;
	PUSHMARK (mark);
	(*subaddr) (aTHX_ cv);
	PUTBACK;	/* forget return values */
}
#endif /* End IN_POGL_MAIN_XS */

#ifdef HAVE_GL
#include "gl_util.h"
#endif

#if defined(HAVE_GLUT) || defined(HAVE_FREEGLUT)
#ifndef GLUT_API_VERSION
#define GLUT_API_VERSION 4
#endif
#include "glut_util.h"
#endif


MODULE = OpenGL::GLUT		PACKAGE = OpenGL::GLUT

# /* This is assigned to GLX for now.  The glp*() functions should be split out */


BOOT:
  PGOPOGL_CALL_BOOT(boot_OpenGL__GLUT__Const);
  PGOPOGL_CALL_BOOT(boot_OpenGL__GLUT__GL__Top);
  PGOPOGL_CALL_BOOT(boot_OpenGL__GLUT);
