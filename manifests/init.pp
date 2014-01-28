# == Class: audit
#
# Full description of class audit here.
#
class audit {

  package {'audit':
    ensure => 'present',
  }

  service {'auditd':
    enable  => true,
    require => Package['audit'],
  }

  file {'/etc/audit/auditd.conf':
    source  => 'puppet:///modules/audit/auditd.conf',
    owner   => root,
    group   => root,
    mode    => '0640',
    notify  => Service['auditd'],
  }

  # Per CIS Rules:
  # Configure auditd to:
  # - Record events that modify data and time information
  # - Record events that modify user or group information
  # - Record events that modify the system's network environment
  # - Record events that modify the system's mandatory access controls
  # - Collect login and logout events
  # - Collect session initiation information
  # - Collect discretionary access control permission modification events
  # - Collect unsuccessful unauthorized access attempts to files
  # - Collect successful file system mounts
  # - Collect file deletion events by user
  # - Collect changes to system administration scope
  # - Collect system administrator actions (sudolog)
  # - Collect kernel module loading and unloading
  # - Make the audit configuration immutable
  file { '/etc/audit/audit.rules':
    source => "puppet:///modules/audit/audit.rules.${::architecture}",
    owner   => root,
    group   => root,
    mode    => '0640',
    notify  => Service['auditd'],
  }

}
