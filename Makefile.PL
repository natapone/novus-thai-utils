use inc::Module::Install;

name 'novus-thai-utils';
all_from 'lib/novus/thai/utils.pm';
perl_version '5.006';

build_requires 'Perl::Critic' => '1.094';

requires 'Bit::Compare';
requires 'Config::JFDI';
requires 'Cwd';
requires 'DateTime::Format::Strptime';
requires 'Try::Tiny';
requires 'Exporter';

test_requires 'Test::More';

auto_install;

novus_ignore('.git');
novus_ignore('.gitignore');

novus;

#install_script glob('bin/*');

WriteAll;