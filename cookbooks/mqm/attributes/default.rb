cb = :mqm

default[cb][:source_file] = "mqadv_dev75_linux_x86-64.tar.gz"

default[cb][:mq_version] = "7.5.0"

default[cb][:mq_packages] = case node.mqm.mq_version
when "7.5.0"
  [ 
    "MQSeriesRuntime-7.5.0-2.x86_64.rpm",
    "MQSeriesServer-7.5.0-2.x86_64.rpm"
  ]
end