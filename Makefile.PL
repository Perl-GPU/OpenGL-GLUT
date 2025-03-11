use strict;
use warnings;
use ExtUtils::MakeMaker;
use OpenGL::Config;

WriteMakefile(
  'NAME'	=> 'OpenGL::GLUT',
  'VERSION_FROM'=> 'lib/OpenGL/GLUT.pm',
  PREREQ_PM => {
    'OpenGL' => '0.70',
  },
  CONFIGURE_REQUIRES => {
    "ExtUtils::MakeMaker" => '6.64',
    "OpenGL" => '0.70',
  },
  TEST_REQUIRES => {
    'Test::More' => '0.88',
  },
  'AUTHOR'	=> "Chris Marshall ".'<chm at cpan dot org>',
  'OBJECT' 	=> '$(BASEEXT)$(OBJ_EXT) gl_util$(OBJ_EXT) pogl_const$(OBJ_EXT) pogl_gl_top$(OBJ_EXT)',
  'XSPROTOARG'	=> '-noprototypes',
  (map +($_=>$OpenGL::Config->{$_}), qw(DEFINE INC LIBS dynamic_lib LDFROM OPTIMIZE)),
  'META_MERGE' => {
     "meta-spec" => { version => 2 },
     abstract  => 'Perl bindings to the GLUT/FreeGLUT toolkit',
     resources => {
        homepage => 'http://sourceforge.net/projects/pogl/',
        bugtracker  => {web=>'https://github.com/Perl-GPU/OpenGL-GLUT/issues'},
        repository  => {
           url => 'git://github.com/Perl-GPU/OpenGL-GLUT.git',
           type => 'git',
           web => 'https://github.com/Perl-GPU/OpenGL-GLUT',
        },
        x_IRC => 'irc://irc.perl.org/#pogl',
     },
  },
);
