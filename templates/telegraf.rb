Eye.application 'telegraf' do
  working_dir '/opt/telegraf'
  stdall '/var/log/eye/telegraf-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :telegraf do
    pid_file '/var/run/telegraf-eye.pid'
    start_command '/opt/telegraf/telegraf -config /etc/telegraf/telegraf.conf'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
