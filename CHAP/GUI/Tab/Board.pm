package CHAP::GUI::Tab::Board;

# go ahead and display the current page

# show item being read, along with text of it being read

use CHAP::GUI::Mod::ChessBoard;
use CHAP::GUI::Mod::GoBoard;
use CHAP::GUI::Tab::Board::TabManager;

use base qw(CHAP::GUI::Tab);

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyFrame MyBoard MyTabManager Type /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MyFrame($args{Frame});
  $self->MyTabManager
    (CHAP::GUI::Tab::Board::TabManager->new
     ());
  $self->Type($args{Type} || "Chess");
}

sub Execute {
  my ($self,%args) = @_;
  my $buttonframe = $self->MyFrame->Frame();
  my $buttons = {
		};
  #   foreach my $key () {
  #     $buttonframe->Button
  #       (
  #        -text => $key,
  #        -command => $buttons->{$key}->{Sub},
  #       )->pack(-side => 'right');
  #   }
  $buttonframe->pack;

  if (1) {
    $self->MyTabManager->Execute
      (
       Frame => $self->MyFrame->Frame(),
      );
  }
  if ($self->Type eq "Chess") {
    $self->MyBoard
      (CHAP::GUI::Mod::ChessBoard->new
       (
	Frame => $self->MyFrame->Frame(),
	Flags => $args{Flags},
       ));
  } elsif ($self->Type eq "Go") {
    $self->MyBoard
      (CHAP::GUI::Mod::GoBoard->new
       (
	Frame => $self->MyFrame->Frame(),
	Flags => $args{Flags},
       ));
  }
  $self->MyFrame->pack();
}

1;
