class Server < ApplicationRecord
  TASKS = %i[ kthreadd kworker/0:0H mm_percpu_wq ksoftirqd/0 rcu_sched rcu_bh
              migration/0 watchdog/0 cpuhp/0 kdevtmpfs netns rcu_tasks_kthre
              kauditd khungtaskd oom_reaper writeback kcompactd0 ksmd khugepaged
              crypto kintegrityd kblockd ata_sff md edac-poller devfreq_wq
              watchdogd kswapd0 ecryptfs-kthrea kthrotld acpi_thermal_pm
              scsi_eh_0 scsi_tmf_0 scsi_eh_1 scsi_tmf_1 ipv6_addrconf kstrp
              charger_manager scsi_eh_2 scsi_tmf_2 kworker/0:1H kworker/0:2
              raid5wq ]
  def status
  end

  def ram
    response = HTTParty.get(self.address + '/ram')
    result = response.body.split ' '
    { name: self.name,
      total: result[7] + 'MB',
      avalible: result[12] + 'MB',
      unused: result[9] + 'MB' }
  end

  def disk
    response = HTTParty.get(self.address + '/disk')
    result = response.body.split ' '
    { name: self.name,
      total: result[20],
      avalible: result[22],
      unused: result[21] }
  end

  def tasks
    # response = HTTParty.get(self.address + '/tasks')
    total_usage = 0
    tasks = TASKS.each_with_index.map do |task, _index|
      prng = Random.new
      cpu_usage = prng.rand(2.27).round(4)
      total_usage += cpu_usage
      { name: task.to_s,
        user: 'root',
        pid: _index.to_s,
        cpu: cpu_usage.to_s,
        mem: prng.rand(2.27).round(4).to_s,
        time: prng.rand(1000).to_s }
    end
    {
      name: self.name,
      tasks: tasks,
      total_usage: total_usage
    }
  end

  def reboot
    HTTParty.get(self.address + '/reboot')
  end
end
