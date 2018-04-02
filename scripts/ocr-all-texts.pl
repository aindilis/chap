#!/usr/bin/perl -w

use Capability::OCR;

use Data::Dumper;

my $documentsdir = "/var/lib/myfrdcsa/codebases/minor/chap/data/texts";
my $ocr = Capability::OCR->new
  (
   EngineName => "NonFreeOmnipageBatchAgent",
   Rewrite => sub {
     my %args = @_;
     my $head = $args{Head};
     $head =~ s/\.pdf$//i;
     return [
	     $head.".htm",
	     $head."_Dir",
	    ];
   },
   Origin => $documentsdir,
   Destination => "/var/lib/myfrdcsa/codebases/minor/chap/data/texts/ocred",
   OCRFolderWatch => "/home/andrewdo/Media/shared/data/chap/ocr-folder-watch",
   OCRFolderWatchOutput => "/home/andrewdo/Media/shared/data/chap/ocr-folder-watch-output",
   Debug => 1,
  );

my $regex = $documentsdir;
foreach my $item (split /\n/, `find "$documentsdir" -follow`) {
  if ($item =~ /^($regex)(\/(.+))?\/([^\/]+)$/) {
    my ($tmp,$base,$head) = ($1,$3,$4);
    my $basehead;
    if (defined $base) {
      $basehead = "$base/$head";
    } else {
      $basehead = "$head";
    }
    if (-f $item) {
      if ($item =~ /\.pdf$/i) {
	my $ocrfileargs = {
			   InputFile => $item,
			   Base => $base,
			   Head => $head,
			   BaseHead => $basehead,
			  };
	print "<$item>\n";
	print Dumper($ocrfileargs);
	my $res = $ocr->OCRFile
	  (%$ocrfileargs);
	print Dumper($res)."\n\n\n";
      } else {
	print "ERROR: $item\n";
      }
    }
  }
}
