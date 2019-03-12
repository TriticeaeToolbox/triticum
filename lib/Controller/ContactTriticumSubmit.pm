
=head1 NAME

SGN::Controller::AJAX::Contact - a REST controller class to provide the
functions for posting the contact form as an issue on github

=head1 DESCRIPTION

When the contact form is submitted it is posted as an issue to github

=head1 AUTHOR

Nicolas Morales <nm529@cornell.edu>

=cut

package SGN::Controller::AJAX::Contact;

use Moose;
use Data::Dumper;
use LWP::UserAgent;
use JSON;
use MIME::Lite;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default   => 'application/json',
    stash_key => 'rest',
    map       => { 'application/json' => 'JSON', 'text/html' => 'JSON' },
   );

sub submit_contact_form : Path('/ajax/contact_triticum/submit') : ActionClass('REST') { }

sub submit_contact_form_POST : Args(0) {
    my $self = shift;
    my $c = shift;
    my $contact_name = $c->req->param('name');
    my $contact_email = $c->req->param('email');
    my $contact_subject = $c->req->param('subject');
    my $contact_body = $c->req->param('body');

    # Read Config Vars
    my $contact_to = $c->config->{contact_to};
    my $contact_from = $c->config->{contact_from};
    my $smtp_server = $c->config->{smtp_server};
    my $smtp_user = $c->config->{smtp_user};
    my $smtp_pass = $c->config->{smtp_pass};


    # Build the message
    my $msg = MIME::Lite->new(
        From => $contact_name . " <" . $contact_from . ">",
        "Reply-To" => $contact_email,
        To => $contact_to,
        Subject => "[TB] [Feedback] " . $contact_subject,
        Type => "TEXT",
        Data => $contact_body
    );


    # Try to send the message
    eval {
        $msg->send('smtp', $smtp_server, AuthUser => $smtp_user, AuthPass => $smtp_pass);   
    };

    # ERROR
    if ($@) {
        print STDERR Dumper $@;
        $c->stash->{rest} = {error => 'The message could not be sent. Please try again later.<br /><br /><code>' . $@ . '</code>'};
    }

    # SUCCESS
    else {
        $c->stash->{rest} = {success => 1};
    }

}

1;
