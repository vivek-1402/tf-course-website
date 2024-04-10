project_id = "roidtc-240408-user504"

project = "space-invaders"

regions =  ["us-central1", "us-east1"]
instance_count = 1
startup_script = "install_space_invaders-version-2.sh"
preemptible = true
machine_type = "e2-micro"

subnet_cidrs = {
    us-central1 = "192.168.1.0/24",
    us-east1    = "192.168.2.0/24"
  }

