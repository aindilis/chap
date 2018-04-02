package CHAP::GUI::Tab::Board::TabManager;

use Data::Dumper;

use Tk::NoteBook;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / MyFrame MyNoteBook MainMenu MyMenu Tabs TabInfo /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Tabs({});
  $self->TabInfo
    ({
      "Analysis" => {
		     Module => "Analysis",
		     Default => 1,
		    },
      "Query" => {
		     Module => "Query",
		     Default => 1,
		    },
     });
}

sub Execute {
  my ($self,%args) = @_;
  $self->StartGUI(%args);
}

sub StartGUI {
  my ($self,%args) = @_;
  $self->MyFrame($args{Frame});
  $self->MyNoteBook($self->MyFrame->NoteBook());
  foreach my $tabname (qw(Analysis Query)) {
    my $open = 0;
    if ($self->TabInfo->{$tabname}->{Default}) {
      $self->StartTab
	(
	 Tabname => $tabname,
	);
      $open = 1;
    }
    $self->AddTabToTabMenu
      (
       Tabname => $tabname,
       Open => $open,
      );
  }
  $self->MyNoteBook->pack(-expand => 1, -fill => "both");
  $self->MyFrame->pack(-side => "left");
}

sub StartTab {
  my ($self,%args) = @_;
  my $myframe = $self->MyNoteBook->add($args{Tabname}, -label => $args{Tabname});
  my $modulename = "CHAP::GUI::Tab::Board::Tab::".$self->TabInfo->{$args{Tabname}}->{Module};
  # print Dumper({Modulename => $modulename});
  my $require = $modulename;
  $require =~ s/::/\//g;
  $require .= ".pm";
  my $fullrequire = "/var/lib/myfrdcsa/codebases/minor/chap/$require";
  if (! -f $fullrequire) {
    print "ERROR, no <<<$fullrequire>>>\n";
    return;
  }
  require $fullrequire;

  my $newtab = eval "$modulename->new(Frame => \$myframe)";
  my $errorstring = $@;
  if (defined $newtab) {
    $self->Tabs->{$args{Tabname}} = $newtab;
    $newtab->Execute();
  } else {
    print Dumper($args{Tabname});
    print $errorstring."\n";
  }
}

sub AddTabToTabMenu {
  my ($self,%args) = @_;
  my $open = $args{Open};
  # $self->MyMenu->checkbutton(-label => $args{Tabname}, -variable => \$open);
}

1;
