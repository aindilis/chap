package CHAP::Study;

use Capability::TextCleaning;
use MyFRDCSA;

use Data::Dumper;
use File::Slurp;
use Lingua::EN::Sentence qw(get_sentences);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / TextDir MyTextCleaning /

  ];

sub init {
  my ($self,%args) = @_;
  $self->TextDir(ConcatDir($UNIVERSAL::systemdir,"data","texts"));
  $self->MyTextCleaning(Capability::TextCleaning->new);
}

sub Study {
  my ($self,%args) = @_;
  my $textdir = $self->TextDir;
  foreach my $file (split /\n/, `find "$textdir"`) {
    if (-f $file) {
      print "<$file>\n";
      # convert it to text (FIXME)
      my $text = read_file($file);

      # now we have to formalize this text.  This is going to be
      # pretty hard.  Seeing the number of OCR errors, etc., I
      # recommend we only accept well formed sentences that contain
      # only dictionary words.

      # I don't know where I put that stuff to clean sentences

      my $sentences = get_sentences($text);
      foreach my $sentence (@$sentences) {
	my $res = $self->MyTextCleaning->CleanText
	  (
	   Text => $sentence,
	  );
	# print Dumper({RES => $res});
	if ($res->{Success}) {
	  foreach my $result (@{$res->{Results}}) {
	    if ($result->{Success}) {
	      my $sentence = $result->{Result};
	      if ($sentence !~ /\d/) {
		print "$sentence\n";
		my $message = $UNIVERSAL::agent->QueryAgent
		  (
		   Receiver => "Formalize2",
		   Data => {
			    Command => "formalize",
			    Text => $sentence,
			    OutputType => "KIF String",
			   },
		  );
		print Dumper($message);
		my $it = <STDIN>;
	      }
	    }
	  }
	}
      }
    }
  }
}

1;
