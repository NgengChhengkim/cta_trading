# config/unicorn.rb

# Set the working application directory
# working_directory '/path/to/your/app'
working_directory '/root/cta_trading'

# Unicorn PID file location
# pid '/path/to/pids/unicorn.pid'
pid '/root/cta_trading/tmp/pids/unicorn.pid'

# Path to logs
# stderr_path '/path/to/log/unicorn.log'
# stdout_path '/path/to/log/unicorn.log'
stderr_path '/root/cta_trading/log/unicorn.log'
stdout_path '/root/cta_trading/log/unicorn.log'

# Unicorn socket
# listen '/tmp/unicorn.[application name].sock'
listen '/tmp/unicorn.cta_trading.sock'

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
