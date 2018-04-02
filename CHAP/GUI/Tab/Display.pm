package CHAP::GUI::Tab::Display;

# go ahead and display the current page

# show item being read, along with text of it being read

use base qw(CHAP::GUI::Tab);

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyFrame MyText Doc /

  ];

sub init {
  my ($self,%args) = @_;
  $self->MyFrame($args{Frame});
}

sub Execute {
  my ($self,%args) = @_;
  my $buttonframe = $self->MyFrame->Frame();
  my $buttons = {
		 "Quit" => {Sub => sub {$self->Doc->CommandQuit}},
		 "Restart TTS" => {Sub => sub {$self->Doc->CommandRestartTTS}},
		 "Pause" => {Sub => sub {$self->Doc->CommandPause}},
		 "Jump to Item in ReadList" => {Sub => sub {$self->Doc->CommandJumpTo}},
		 "Ignore Current Item" => {Sub => sub {$self->Doc->CommandIgnore}},
		 "Search" => {Sub => sub {$self->Doc->CommandSearch}},
		 "Volume" => {Sub => sub {$self->Doc->CommandVolume}},
		 "Duration (Voice Speed)" => {Sub => sub {$self->Doc->CommandDuration}},
		 "Goto Sentence" => {Sub => sub {$self->Doc->CommandGoto}},
		};
  foreach my $key (reverse ("Pause","Restart TTS","Jump to Item in ReadList","Ignore Current Item","Search","Duration","Volume","Goto Sentence","Quit")) {
    $buttonframe->Button
      (
       -text => $key,
       -command => $buttons->{$key}->{Sub},
      )->pack(-side => 'right');
  }
  $buttonframe->pack;

  my $searchframe = $self->MyFrame->Frame();
  my $searchtext = "";
  my $search = $searchframe->Entry
    (
     -relief       => 'sunken',
     -borderwidth  => 2,
     -textvariable => \$searchtext,
     -width        => 30,
    )->pack(-side => 'left');
  $searchframe->Button
    (
     -text => "Search",
     -command => sub { },
    )->pack(-side => 'right');
  $searchframe->pack;

  my $textframe = $self->MyFrame->Frame();
  my $text = $textframe->Text
    (
     -width => 120,
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
  $textframe->pack(-fill => "both", -expand => 1);

  $self->MyFrame->pack;
}

1;
