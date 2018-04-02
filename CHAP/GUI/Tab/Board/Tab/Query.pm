package CHAP::GUI::Tab::Board::Tab::Query;

# go ahead and display the current page

# show item being read, along with text of it being read

use base qw(CHAP::GUI::Tab::Board::Tab);

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyFrame MyText /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MyFrame($args{Frame});
}

sub Execute {
  my ($self,%args) = @_;
  # probably add some buttons here
  # my $frame = $self->MyFrame->Frame();
  my $textframe = $self->MyFrame->Frame();
  my $text = $textframe->Text
    (
     -width => 80,
     -height => 30,
    );
  $self->MyText($text);
  my $scrollbar = $textframe->Scrollbar
    ();
  $scrollbar->pack(-side => "right", -fill => "y");
  $text->pack(-side => "left", -fill => "both", -expand => 1);
  $scrollbar->configure
    (
     -command => ['yview', $text],
    );
  $text->configure
    (
     -yscrollcommand => ['set', $scrollbar],
    );
  $textframe->pack(-fill => "both", -expand => 1, -side => "left");
  $self->MyFrame->pack(-fill => "both", -expand => 1, -side => "left");

  # we need natural language translations of common queries

  my $questions = {
  		   "What are all the ranks?" => '("rank" var-RANK)',
		   "On which squares are all the pieces in the current position?" => '("in" ("on" var-PIECE var-SQUARE) var-POSITION)',
		   "What are the notation abbrevations for the common names of the chess pieces?" => '("abbreviation" var-NAME var-ABBREV)',
		   # "Which squares are colinear in terms of rank, file, or diagonal?" => '("colinear" var-SQUARE1 var-SQUARE2 var-Element)',
		   # "What is the theoretical range of the pieces?" => '("theoretical_range" ("piece" var-Color "pawn") "capture" ("square" var-X1 var-Y1) ("square" var-X2 var-Y2))',
		   "What pieces are attacking other pieces in the current position?" => '("attacking" ("on" var-PIECE1 var-SQUARE1) ("on" var-PIECE2 var-SQUARE2) var-POSITION)',
		  };

  #   my $res = $client->Send
  #     (
  #      Debug => 1,
  #      QueryAgent => 1,
  #      Query => $query,
  #      InputType => "Emacs String",
  #      Flags => {
  # 	       OutputType => "CycL String",
  # 	      },
  #     );
  #   # extract here the bindings, in a cycl format for ease of display
  #   print $res->Data->{Result}->{CycL}."\n";
}

1;
