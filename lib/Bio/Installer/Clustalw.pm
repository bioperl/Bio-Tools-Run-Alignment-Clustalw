package Bio::Installer::Clustalw;

use utf8;
use strict;
use warnings;

use vars qw(@ISA %DEFAULTS);

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::Installer::Generic;

@ISA = qw(Bio::Installer::Generic );

# ABSTRACT: DESCRIPTION of Object
# AUTHOR: Albert Vilella <avilella@gmail.com>
# OWNER: Albert Vilella <avilella@gmail.com>
# LICENSE: Perl_5

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Describe the object here

=cut

BEGIN {
    %DEFAULTS = ( 'ORIGIN_DOWNLOAD_DIR' => 'ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw',
                  'BIN_FOLDER' => '',
                  'DESTINATION_DOWNLOAD_DIR' => '/tmp',
                  'DESTINATION_INSTALL_DIR' => "$ENV{'HOME'}",
                  'PACKAGE_NAME' => 'clustalw1.83.UNIX.tar.gz',
                  'DIRECTORY_NAME' => 'clustalw1.83',
                  'ENV_NAME' => 'CLUSTALDIR',
                );
}


=method get_default

 Title   : get_default
 Usage   :
 Function:
 Example :
 Returns :
 Args    :


=cut

sub get_default {
    my $self = shift;
    my $param = shift;
    return $DEFAULTS{$param};
}


=method install

 Title   : install
 Usage   : $installer->install();
 Function:
 Example :
 Returns :
 Args    :


=cut

sub install{
   my ($self,@args) = @_;
   my $dir;
   $self->_decompress;
   $self->_execute_make;
   $dir = $self->destination_install_dir;
   $self->_remember_env;
}


=internal _execute_make

 Title   : _execute_make
 Usage   :
 Function:
 Example :
 Returns :
 Args    :


=cut

sub _execute_make{
   my ($self,@args) = @_;
   my $call;

   my $destination = $self->destination_install_dir . "/" . $self->directory_name;

   print "\n\nCompiling with make -- (this might take a while)\n\n";sleep 1;
   if (($^O =~ /dec_osf|linux|unix|bsd|solaris|darwin/i)) {
       chdir $destination or die "Cant cd to $destination $!\n";

       print "\n\nCalling make (this might take a while)\n\n";sleep 1;
       $call = "make";
       system("$call") == 0 or $self->throw("Error when trying to run make");
   } else {
       $self->throw("_execute_make not yet implemented in this platform");
   }
}


1;
