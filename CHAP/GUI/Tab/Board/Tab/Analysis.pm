package CHAP::GUI::Tab::Board::Tab::Analysis;

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
}



1;
