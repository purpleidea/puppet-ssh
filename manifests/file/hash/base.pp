# Fancy SSH server, client and utility module by James
# Copyright (C) 2012-2013+ James Shubin
# Written by James Shubin <james@shubin.ca>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class ssh::file::hash::base() {

	include ssh::file
	include ssh::vardir
	#$vardir = $::ssh::vardir::module_vardir	# with trailing slash
	$vardir = regsubst($::ssh::vardir::module_vardir, '\/$', '')

	file { "${vardir}/file/hash/":
		ensure => directory,	# make sure this is a directory
		recurse => true,	# recurse into directory
		purge => true,		# purge unmanaged files
		force => true,		# purge subdirs and links
		require => File["${vardir}/file/"],
	}

	file { "${vardir}/file/cat/":
		ensure => directory,	# make sure this is a directory
		recurse => true,	# recurse into directory
		purge => true,		# purge unmanaged files
		force => true,		# purge subdirs and links
		require => File["${vardir}/file/"],
	}

	@@ssh::file::hash::cat { "${::fqdn}":
		# since these are cat together, you can grep <name>$ for files!
		content => "${::ssh_file_hash_cat}",	# fact of all hashes...
		tag => 'ssh_file_hash_cat',	# TODO: unused future namespace
	}
}

# vim: ts=8
