requires "Dancer2" => "0.162000";
requires 'Dancer2::Plugin::Database';
requires 'DBD::ODBC';
requires "Template";
requires "FCGI::ProcManager";
requires "Dancer2::Plugin::Auth::Extensible", "0.502";
requires "Authen::PAM";
requires "Authen::Simple::PAM";
requires "Dancer2::Session::Cookie";
requires "FCGI";

recommends "YAML"             => "0";
recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

on "test" => sub {
    requires "Test::More"            => "0";
    requires "HTTP::Request::Common" => "0";
};
