# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'test@test.com', password: '123456')

TASKS = %i[ kthreadd kworker/0:0H mm_percpu_wq ksoftirqd/0 rcu_sched rcu_bh
            migration/0 watchdog/0 cpuhp/0 kdevtmpfs netns rcu_tasks_kthre
            kauditd khungtaskd oom_reaper writeback kcompactd0 ksmd khugepaged
            crypto kintegrityd kblockd ata_sff md edac-poller devfreq_wq
            watchdogd kswapd0 ecryptfs-kthrea kthrotld acpi_thermal_pm
            scsi_eh_0 scsi_tmf_0 scsi_eh_1 scsi_tmf_1 ipv6_addrconf kstrp
            charger_manager scsi_eh_2 scsi_tmf_2 kworker/0:1H kworker/0:2
            raid5wq ]

Server.create({
  name: "Linux - Ubuntu 18.04",
  address: "http://178.128.183.182:8080/",
  user_id: User.first.id
})

Server.create({
  name: "Solaris",
  address: "http://178.128.183.182:8080/",
  user_id: User.first.id
})

Server.create({
  name: "Cent OS",
  address: "http://178.128.183.182:8080/",
  user_id: User.first.id
})

Server.create({
  name: "Debian",
  address: "http://178.128.183.182:8080/",
  user_id: User.first.id
})
