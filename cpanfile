requires "Dancer2" => "0.162000";
requires 'Dancer2::Plugin::Database';
requires 'DBD::ODBC';
requires "Template";
requires "FCGI::ProcManager";
requires "Dancer2::Plugin::Auth::Extensible";
#requires "Authen::PAM";
requires "Authen::Simple::PAM";
requires "Unix::Passwd::File";
requires "Dancer2::Session::Cookie";
requires "FCGI";
requires "Dancer2::Plugin::Ajax";
requires "Daemon::Control";
requires "Starman";
requires "DBIx::Class";
requires "Dancer2::Plugin::DBIC";
requires "Config::Any";
requires "Config::General";
requires "DBIx::Class::TimeStamp";
requires "DBIx::Class::Helper::ResultSet::Shortcut";
requires "DBIx::Class::Schema::Config";
requires "List::MoreUtils";
requires "DateTime";

requires "Smart::Comments";
requires "URI";

requires "Test::WWW::Mechanize::PSGI";

recommends "YAML"             => "0";
recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

on "test" => sub {
    requires "Test::More"            => "0";
    requires "HTTP::Request::Common" => "0";
};
