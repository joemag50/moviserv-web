class Server < ApplicationRecord
  after_create :initialize_tasks

  TASKS = %i[ kthreadd kworker/0:0H mm_percpu_wq ksoftirqd/0 rcu_sched rcu_bh
              migration/0 watchdog/0 cpuhp/0 kdevtmpfs netns rcu_tasks_kthre
              kauditd khungtaskd oom_reaper writeback kcompactd0 ksmd khugepaged
              crypto kintegrityd kblockd ata_sff md edac-poller devfreq_wq
              watchdogd kswapd0 ecryptfs-kthrea kthrotld acpi_thermal_pm
              scsi_eh_0 scsi_tmf_0 scsi_eh_1 scsi_tmf_1 ipv6_addrconf kstrp
              charger_manager scsi_eh_2 scsi_tmf_2 kworker/0:1H kworker/0:2
              raid5wq ]

  has_many :server_tasks

  def initialize_tasks
    TASKS.each_with_index.map do |task, _index|
      prng = Random.new
      cpu_usage = prng.rand(2.27).round(4)
      ServerTask.create({
        name: task.to_s,
        user: 'root',
        pid: _index.to_s,
        cpu: cpu_usage.to_s,
        mem: prng.rand(2.27).round(4).to_s,
        time: prng.rand(1000).to_s,
        server_id: self.id,
        status: 0
      })
    end
  end

  def update_tasks(alpha = 2.27)
    server_tasks.each do |task|
      prng = Random.new
      cpu_usage = prng.rand(alpha).round(4).to_s
      mem_usage = prng.rand(alpha).round(4).to_s
      if task.stoped?
        task.update_attributes({
          cpu: 0,
          mem: 0
        })
      else
        task.update_attributes({
          cpu: cpu_usage,
          mem: mem_usage
        })
      end
    end
  end

  def stop_tasks
    server_tasks.update_all(status: 1)
  end

  def start_tasks
    server_tasks.update_all(status: 0)
  end

  def stop_task(pid)
    server_tasks.find_by(pid: pid).update_attribute(:status, 1)
  end

  def start_task(pid)
    server_tasks.find_by(pid: pid).update_attribute(:status, 0)
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
    {
      name: self.name,
      cpu_total_usage: cpu_total_usage,
      mem_total_usage: mem_total_usage,
      tableHead: ['Name','Pid', 'Status','Stop', 'Start'],
      tableData: server_tasks.order(:pid).map { |x| [x.name, x.pid, x.status, 'button1', 'button2'] }
    }
  end

  def reboot
    HTTParty.get(self.address + '/reboot')
  end

  private

  def cpu_total_usage
    total = 0
    server_tasks.where(status: 'started').each do |task|
      total += task.cpu
    end
    total
  end

  def mem_total_usage
    total = 0
    server_tasks.where(status: 'started').each do |task|
      total += task.mem
    end
    total
  end
end
