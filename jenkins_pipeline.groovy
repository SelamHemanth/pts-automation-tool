//-----------------------------------------------------------------------------
//Groovy Script for run the jenkins pipeline.
//Author: Hemanth Selam
//Email: Hemanth.Selam@amd.com
//-----------------------------------------------------------------------------

build_home="/tests/jenkins/pts/${env.BUILD_NUMBER}"
result_home="/var/lib/phoronix-test-suite/test-results"
pts_home = "/root"
node_name = "hemanth_ubuntu"

pipeline {
    agent {
        node {
            label "${node_name}"
        }
    }
    parameters {
        choice(
            name: 'Install_Phoronix_Test_Suite',
            choices: ['No', 'Yes'],
            description: "Download and install the Phoronix Test Suite and packages"
        )
		choice(
			name: 'Run_Type',
			choices: ['Sanity_Run', 'Full_Run', 'Manual_Configuration'],
			description: """Choose type of run.
			Sanity_Run: Automatically configures with minimum configurations and runs.
			Full_Run: Configures with medium configurations and runs.
			Manual_Configuration: User can choose tests and configurations.
			Note: For Sanity and Full Run, no need to select the configurations."""
		)
        booleanParam(
            name: 'pts_nginx',
            defaultValue: false,
            description: "About: This benchmark measures the performance of the Nginx web server, focusing on handling concurrent web requests, throughput, and response times.\n Enable pts_nginx and choose connections"
        )
        choice(
            name: 'pts_nginx_connections',
            choices: ['1', '20', '100', '200', '500', '1000', '4000', 'Test All Options'],
            description: "Choose connections for pts_nginx test"
        )
		booleanParam(
			name: 'pts_pgbench',
			defaultValue: false,
			description: "About: Pgbench is a benchmarking tool for PostgreSQL. It simulates various database operations to measure the performance of PostgreSQL databases, focusing on transaction processing performance.\n Enable pts_pgbench and choose scaling factor, clients and mode"
		)
		choice(
			name: 'pts_pgbench_scaling_factor',
			choices: ['1', '100', '1000', '10000', '25000 [Intended for very large servers.]', 'Test All Options'],
			description: "Choose scaling factor then choose clients"
		)
		choice(
			name: 'pts_pgbench_clients',
			choices: ['1', '50', '100', '250', '500', '800', '1000', '5000', 'Test All Options'],
			description: "Choose clients then choose mode"
		)
		choice(
			name: 'pts_pgbench_mode',
			choices: ['Read Write', 'Read Only', 'Test All Options'],
			description: "Choose mode"
		)
		booleanParam(
			name: 'pts_stressng',
			defaultValue: false,
			description: "About: Stress NG is a tool for stress testing a computer system. It loads and exercises various components (CPU, memory, I/O, etc.) to assess system stability and performance under heavy load.\n Enable pts_stressng and choose tests"
		)
		choice(
			name: 'pts_stressng_tests',
			choices: ['CPU Stress', 'Crypto', 'Memory Copying', 'Glibc Qsort Data Sorting', 'Glibc C String Functions', 'Vector Math', 'Matrix Math', 'Forking', 'System V Message Passing', 'Semaphores', 'Socket Activity', 'Context Switching', 'Atomic', 'CPU Cache', 'Malloc', 'MEMFD', 'MMAP', 'NUMA', 'x86_64 RdRand', 'SENDFILE', 'IO_uringG', 'Futex', 'Mutex', 'Function Call', 'Poll', 'Hash', 'Pthread', 'Zlib', 'Floating Point', 'Fused Multiply-Add', 'Pipe', 'Matrix 3D Math', 'AVL Tree', 'Vector Floating Point', 'Vector Shuffle', 'Wide Vector Math', 'Cloning', 'AVX-512 VNNI', 'Mixed Scheduler', 'Exponential Math', 'Fractal Generator', 'Logarithmic Math', 'Power Math', 'Trigonometric Math', 'Jpeg Compression', 'Bitonic Integer Sort', 'Radix String Sort', 'Test All Options'],
			description: "Choose tests"
		)
		booleanParam(
			name: 'pts_redis',
			defaultValue: false,
			description: "About: The Redis benchmark evaluates the performance of Redis, an in-memory data structure store. It measures throughput and latency for various data operations.\n Enable pts_redis and choose test and Parallel Connections"
		)
		choice(
			name: 'pts_redis_test',
			choices: ['SET', 'GET', 'LPUSH', 'LPOP', 'SADD', 'Test All Options'],
			description: "Choose test then choose perallel connections"
		)
		choice(
			name: 'pts_redis_perallel_connections',
			choices: ['50', '500', '1000', 'Test All Options'],
			description: "Choose perallel connections"
		)
		booleanParam(
			name: 'pts_openssl',
			defaultValue: false,
			description: "About: The OpenSSL benchmark evaluates the cryptographic performance of a system by testing the speed of various encryption and decryption operations.\n Enable pts_openssl and choose Algorithm"
		)
		choice(
			name: 'pts_openssl_algorithm',
			choices: ['RSA4096', 'SHA256', 'SHA512', 'AES-128-GCM', 'AES-256-GCM', 'ChaCha20', 'ChaCha20-Poly1305', 'Test All Options'],
			description: "Choose algorithm"
		)
		booleanParam(
			name: 'pts_sysbench',
			defaultValue: false,
			description: "About: Sysbench is a multi-purpose benchmark tool used to evaluate the performance of the CPU, memory, I/O, and database systems. It is commonly used for MySQL performance testing.\n Enable pts_sysbench and choose test"
		)
		choice(
			name: 'pts_sysbench_test',
			choices: ['CPU', 'RAM / Memory', 'Test All Options'],
			description: "Choose test"
		)
		booleanParam(
			name: 'pts_pennant',
			defaultValue: false,
			description: "About: Pennant is a benchmark tool for assessing high-performance computing (HPC) systems. It focuses on computational fluid dynamics (CFD) and other scientific computing workloads.\n Enable pts_pennant and choose test"
		)
		choice(
			name: 'pts_pennant_test',
			choices: ['leblancbig', 'sedovbig', 'Test All Options'],
			description: "Choose test"
		)
		booleanParam(
			name: 'pts_memcached',
			defaultValue: false,
			description: "About: The Memcached benchmark evaluates the performance of Memcached, a distributed memory caching system. It measures the speed of storing and retrieving data from the cache.\n Enable pts_memcached and choose test"
		)
		choice(
			name: 'pts_memcached_set_to_get_ratio',
			choices: ['1:100', '1:10', '1:5', '1:1', '5:1', 'Test All Options'],
			description: "Choose set to get ratio"
		)
		booleanParam(
			name: 'pts_hadoop',
			defaultValue: false,
			description: "About: This benchmark measures the performance of Apache Hadoop, focusing on its ability to handle large-scale data processing tasks across distributed computing resources.\n Enable pts_hadoop and choose operation, threads and files"
		)
		choice(
			name: 'pts_hadoop_operation',
			choices: ['Create', 'Open', 'Delete', 'File Status', 'Rename', 'Test All Options'],
			description: "Choose operation then choose threads and files"
		)
		choice(
			name: 'pts_hadoop_threads',
			choices: ['20', '50', '100', '500', '1000', 'Test All Options'],
			description: "Choose operation then choose files"
		)
		choice(
			name: 'pts_hadoop_files',
			choices: ['100000', '1000000', '10000000', 'Test All Options'],
			description: "Choose files"
		)
    }
    stages {
        stage('Initialization') {
            steps {
                script {
                    if (params.Install_Phoronix_Test_Suite == 'Yes') {
                        pipeline_init()
                        echo "Build Number: ${env.BUILD_NUMBER}"
                    } else {
                        echo "PTS not installing now.."
                    }
                }
            }
        }
        stage('Configuration') {
            steps {
                script {
					if (params.Run_Type == 'Sanity_Run') {
						create_config_files()
						sanity_run_config()
					}
					if (params.Run_Type == 'Full_Run') {
						create_config_files()
						full_run_config()
					}
                    if (params.Run_Type == 'Manual_Configuration') {
                        create_config_files()
                        configuration()
                    }
                }
            }
        }
        stage('Testing') {
            steps {
                script {
					if (params.Run_Type == 'Sanity_Run' || params.Run_Type == 'Full_Run') {
						echo "#### ${params.Run_Type.replace('_', ' ')} ####"
						auto_run()
					} else {
						test_run()
					}                    
                }
            }
        }
        stage('Saving Results') {
            steps {
                script {
                    echo "save result"
                    save_result()
                }
            }
        }
    }
}

void sanity_run_config() {
    try {
        echo "#### Sanity Run Configuration ####"
        def configEntries = [
            'CONFIG_NGINX', 'CONFIG_PGBENCH', 'CONFIG_STRESSNG', 'CONFIG_REDIS',
            'CONFIG_OPENSSL', 'CONFIG_SYSBENCH', 'CONFIG_PENNANT', 'CONFIG_MEMCACHED',
            'CONFIG_HADOOP'
        ]		
        def optionsEntries = [
            'NGINX_OPTIONS=3', 'PGBENCH_OPTIONS1=1', 'PGBENCH_OPTIONS2=1', 'PGBENCH_OPTIONS3=1',
            'STRESSNG_OPTIONS=1', 'REDIS_OPTIONS1=1', 'REDIS_OPTIONS2=1', 'OPENSSL_OPTIONS=1',
            'SYSBENCH_OPTIONS=2', 'PENNANT_OPTIONS=1', 'MEMCACHED_OPTIONS=1', 'HADOOP_OPTIONS1=1',
            'HADOOP_OPTIONS2=1', 'HADOOP_OPTIONS3=1'
        ]        
        configEntries.each { entry ->
            sh "echo '${entry}=y' >> ${pts_home}/pts-automation-tool/.config"
        }        
        optionsEntries.each { entry ->
            sh "echo '${entry}' >> ${pts_home}/pts-automation-tool/.config.options"
        }        
    } catch (Exception e) {
        def failure_message = "Error in sanity_run_config(): " + e.getMessage()
        error(failure_message)
    }
}

void full_run_config() {
    try {
        echo "#### Full Run Configuration ####"
        def configEntries = [
            'CONFIG_NGINX', 'CONFIG_PGBENCH', 'CONFIG_STRESSNG', 'CONFIG_REDIS',
            'CONFIG_OPENSSL', 'CONFIG_SYSBENCH', 'CONFIG_PENNANT', 'CONFIG_MEMCACHED',
            'CONFIG_HADOOP'
        ]		
        def optionsEntries = [
            'NGINX_OPTIONS=5', 'PGBENCH_OPTIONS1=2', 'PGBENCH_OPTIONS2=3', 'PGBENCH_OPTIONS3=3',
            'STRESSNG_OPTIONS=48', 'REDIS_OPTIONS1=6', 'REDIS_OPTIONS2=2', 'OPENSSL_OPTIONS=8',
            'SYSBENCH_OPTIONS=3', 'PENNANT_OPTIONS=3', 'MEMCACHED_OPTIONS=6', 'HADOOP_OPTIONS1=6',
            'HADOOP_OPTIONS2=3', 'HADOOP_OPTIONS3=1'
        ]        
        configEntries.each { entry ->
            sh "echo '${entry}=y' >> ${pts_home}/pts-automation-tool/.config"
        }        
        optionsEntries.each { entry ->
            sh "echo '${entry}' >> ${pts_home}/pts-automation-tool/.config.options"
        }        
    } catch (Exception e) {
        def failure_message = "Error in full_run_config(): " + e.getMessage()
        error(failure_message)
    }
}


void save_result() {
    try {
        echo "#### Saving Results ####"
        sh "cd ${pts_home}/pts-automation-tool/ ; sudo make showresult ; sudo make saveresult"
        echo "#### Copying results ####"
        sh "sudo cp ${result_home}/*tar.gz ${build_home}/"
        echo "*******************************************"
        echo "### Tar File : ${build_home}/*.tar.gz ####"
        echo "*******************************************"
        echo "#### Clearing ${env.BUILD_NUMBER} logs ####"
        sh "sudo rm -rf /var/lib/phoronix-test-suite/test-results/*"
        echo "#### Phoronix Test Suite Pipeline completed ####"
    } catch (Exception e) {
        def failure_message = "Error in save_result(): " + e.getMessage()
        error(failure_message)
    } 
}

void test_run() {
    try {
        echo "#### Running Tests ####"
        if (params.pts_nginx) {
            sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_nginx"
        }
		if (params.pts_pgbench) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_pgbench"
		}
		if (params.pts_stressng) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_stress-ng"
		}
		if (params.pts_redis) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_redis"
		}
		if (params.pts_openssl) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_openssl"
		}
		if (params.pts_sysbench) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_sysbench"
		}
		if (params.pts_pennant) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_pennant"
		}
		if (params.pts_memcached) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_memcached"
		}
		if (params.pts_hadoop) {
			sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_hadoop"
		}
        echo "#### All Tests Completed ####"
    } catch (Exception e) {
        def failure_message = "Error in test_run(): " + e.getMessage()
        error(failure_message)
    } 
}

void auto_run() {
	try {
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_nginx"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_pgbench"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_stress-ng"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_redis"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_openssl"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_sysbench"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_pennant"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_memcached"
		sh "cd ${pts_home}/pts-automation-tool/ ; ./runs/pts_hadoop"
	} catch (Exception e) {
        def failure_message = "Error in auto_run(): " + e.getMessage()
        error(failure_message)
    }
}

void configuration() {
    try {
		sh "mkdir -p ${build_home}"
        if (params.pts_nginx) {
            sh "echo 'CONFIG_NGINX=y' >> ${pts_home}/pts-automation-tool/.config"
            switch (params.pts_nginx_connections) {
                case "1":
                    sh "echo 'NGINX_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "20":
                    sh "echo 'NGINX_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "100":
                    sh "echo 'NGINX_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "200":
                    sh "echo 'NGINX_OPTIONS=4' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "500":
                    sh "echo 'NGINX_OPTIONS=5' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "1000":
                    sh "echo 'NGINX_OPTIONS=6' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "4000":
                    sh "echo 'NGINX_OPTIONS=7' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
                case "Test All Options":
                    sh "echo 'NGINX_OPTIONS=8' >> ${pts_home}/pts-automation-tool/.config.options"
                    break
            }
        }
		if (params.pts_pgbench) {
			sh "echo 'CONFIG_PGBENCH=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_pgbench_scaling_factor) {
				case "1":
					sh "echo 'PGBENCH_OPTIONS1=1' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "100":
					sh "echo 'PGBENCH_OPTIONS1=2' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "1000":
					sh "echo 'PGBENCH_OPTIONS1=3' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "10000":
					sh "echo 'PGBENCH_OPTIONS1=4' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "25000 [Intended for very large servers.]":
					sh "echo 'PGBENCH_OPTIONS1=5' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "Test All Options":
					sh "echo 'PGBENCH_OPTIONS1=6' >> ${pts_home}/pts-automation-tool/.config.options"
					break
			}
			switch (params.pts_pgbench_clients) {
				case "1":
					sh "echo 'PGBENCH_OPTIONS2=1' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "50":
					sh "echo 'PGBENCH_OPTIONS2=2' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "100":
					sh "echo 'PGBENCH_OPTIONS2=3' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "250":
					sh "echo 'PGBENCH_OPTIONS2=4' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "500":
					sh "echo 'PGBENCH_OPTIONS2=5' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "800":
					sh "echo 'PGBENCH_OPTIONS2=6' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "1000":
					sh "echo 'PGBENCH_OPTIONS2=7' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "5000":
					sh "echo 'PGBENCH_OPTIONS2=8' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "Test All Options":
					sh "echo 'PGBENCH_OPTIONS2=9' >> ${pts_home}/pts-automation-tool/.config.options"
					break
			}
			switch (params.pts_pgbench_mode) {
				case "Read Write":
					sh "echo 'PGBENCH_OPTIONS3=1' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "Read Only":
					sh "echo 'PGBENCH_OPTIONS3=2' >> ${pts_home}/pts-automation-tool/.config.options"
					break
				case "Test All Options":
					sh "echo 'PGBENCH_OPTIONS3=3' >> ${pts_home}/pts-automation-tool/.config.options"
					break
			}
		}
		if (params.pts_stressng) {
			sh "echo 'CONFIG_STRESSNG=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_stressng_tests) {
			case "CPU Stress":
				sh "echo 'STRESSNG_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Crypto":
				sh "echo 'STRESSNG_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Memory Copying":
				sh "echo 'STRESSNG_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Glibc Qsort Data Sorting":
				sh "echo 'STRESSNG_OPTIONS=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Glibc C String Functions":
				sh "echo 'STRESSNG_OPTIONS=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Vector Math":
				sh "echo 'STRESSNG_OPTIONS=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Matrix Math":
				sh "echo 'STRESSNG_OPTIONS=7' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Forking":
				sh "echo 'STRESSNG_OPTIONS=8' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "System V Message Passing":
				sh "echo 'STRESSNG_OPTIONS=9' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Semaphores":
				sh "echo 'STRESSNG_OPTIONS=10' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Socket Activity":
				sh "echo 'STRESSNG_OPTIONS=11' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Context Switching":
				sh "echo 'STRESSNG_OPTIONS=12' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Atomic":
				sh "echo 'STRESSNG_OPTIONS=13' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "CPU Cache":
				sh "echo 'STRESSNG_OPTIONS=14' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Malloc":
				sh "echo 'STRESSNG_OPTIONS=15' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "MEMFD":
				sh "echo 'STRESSNG_OPTIONS=16' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "MMAP":
				sh "echo 'STRESSNG_OPTIONS=17' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "NUMA":
				sh "echo 'STRESSNG_OPTIONS=18' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "x86_64 RdRand":
				sh "echo 'STRESSNG_OPTIONS=19' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "SENDFILE":
				sh "echo 'STRESSNG_OPTIONS=20' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "IO_uringG":
				sh "echo 'STRESSNG_OPTIONS=21' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Futex":
				sh "echo 'STRESSNG_OPTIONS=22' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Mutex":
				sh "echo 'STRESSNG_OPTIONS=23' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Function Call":
				sh "echo 'STRESSNG_OPTIONS=24' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Poll":
				sh "echo 'STRESSNG_OPTIONS=25' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Hash":
				sh "echo 'STRESSNG_OPTIONS=26' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Pthread":
				sh "echo 'STRESSNG_OPTIONS=27' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Zlib":
				sh "echo 'STRESSNG_OPTIONS=28' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Floating Point":
				sh "echo 'STRESSNG_OPTIONS=29' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Fused Multiply-Add":
				sh "echo 'STRESSNG_OPTIONS=30' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Pipe":
				sh "echo 'STRESSNG_OPTIONS=31' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Matrix 3D Math":
				sh "echo 'STRESSNG_OPTIONS=32' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "AVL Tree":
				sh "echo 'STRESSNG_OPTIONS=33' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Vector Floating Point":
				sh "echo 'STRESSNG_OPTIONS=34' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Vector Shuffle":
				sh "echo 'STRESSNG_OPTIONS=35' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Wide Vector Math":
				sh "echo 'STRESSNG_OPTIONS=36' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Cloning":
				sh "echo 'STRESSNG_OPTIONS=37' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "AVX-512 VNNI":
				sh "echo 'STRESSNG_OPTIONS=38' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Mixed Scheduler":
				sh "echo 'STRESSNG_OPTIONS=39' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Exponential Math":
				sh "echo 'STRESSNG_OPTIONS=40' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Fractal Generator":
				sh "echo 'STRESSNG_OPTIONS=41' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Logarithmic Math":
				sh "echo 'STRESSNG_OPTIONS=42' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Power Math":
				sh "echo 'STRESSNG_OPTIONS=43' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Trigonometric Math":
				sh "echo 'STRESSNG_OPTIONS=44' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Jpeg Compression":
				sh "echo 'STRESSNG_OPTIONS=45' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Bitonic Integer Sort":
				sh "echo 'STRESSNG_OPTIONS=46' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Radix String Sort":
				sh "echo 'STRESSNG_OPTIONS=47' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'STRESSNG_OPTIONS=48' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_redis) {
			sh "echo 'CONFIG_REDIS=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_redis_test) {
			case "SET":
				sh "echo 'REDIS_OPTIONS1=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "GET":
				sh "echo 'REDIS_OPTIONS1=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "LPUSH":
				sh "echo 'REDIS_OPTIONS1=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "LPOP":
				sh "echo 'REDIS_OPTIONS1=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "SADD":
				sh "echo 'REDIS_OPTIONS1=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'REDIS_OPTIONS1=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
			switch (params.pts_redis_perallel_connections) {
			case "50":
				sh "echo 'REDIS_OPTIONS2=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "500":
				sh "echo 'REDIS_OPTIONS2=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1000":
				sh "echo 'REDIS_OPTIONS2=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'REDIS_OPTIONS2=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_openssl) {
			sh "echo 'CONFIG_OPENSSL=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_openssl_algorithm) {
			case "RSA4096":
				sh "echo 'OPENSSL_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "SHA256":
				sh "echo 'OPENSSL_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "SHA512":
				sh "echo 'OPENSSL_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "AES-128-GCM":
				sh "echo 'OPENSSL_OPTIONS=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "AES-256-GCM":
				sh "echo 'OPENSSL_OPTIONS=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "ChaCha20":
				sh "echo 'OPENSSL_OPTIONS=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "ChaCha20-Poly1305":
				sh "echo 'OPENSSL_OPTIONS=7' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'OPENSSL_OPTIONS=8' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_sysbench) {
			sh "echo 'CONFIG_SYSBENCH=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_sysbench_test) {
			case "CPU":
				sh "echo 'SYSBENCH_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "RAM / Memory":
				sh "echo 'SYSBENCH_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'SYSBENCH_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_pennant) {
			sh "echo 'CONFIG_PENNANT=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_pennant_test) {
			case "leblancbig":
				sh "echo 'PENNANT_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "sedovbig":
				sh "echo 'PENNANT_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'PENNANT_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_memcached) {
			sh "echo 'CONFIG_MEMCACHED=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_memcached_set_to_get_ratio) {
			case "1:100":
				sh "echo 'MEMCACHED_OPTIONS=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1:10":
				sh "echo 'MEMCACHED_OPTIONS=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1:5":
				sh "echo 'MEMCACHED_OPTIONS=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1:1":
				sh "echo 'MEMCACHED_OPTIONS=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "5:1":
				sh "echo 'MEMCACHED_OPTIONS=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'MEMCACHED_OPTIONS=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
		if (params.pts_hadoop) {
			sh "echo 'CONFIG_HADOOP=y' >> ${pts_home}/pts-automation-tool/.config"
			switch (params.pts_hadoop_operation) {
			case "Create":
				sh "echo 'HADOOP_OPTIONS1=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Open":
				sh "echo 'HADOOP_OPTIONS1=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Delete":
				sh "echo 'HADOOP_OPTIONS1=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "File Status":
				sh "echo 'HADOOP_OPTIONS1=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Rename":
				sh "echo 'HADOOP_OPTIONS1=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'HADOOP_OPTIONS1=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
			switch (params.pts_hadoop_threads) {
			case "20":
				sh "echo 'HADOOP_OPTIONS2=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "50":
				sh "echo 'HADOOP_OPTIONS2=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "100":
				sh "echo 'HADOOP_OPTIONS2=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "500":
				sh "echo 'HADOOP_OPTIONS2=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1000":
				sh "echo 'HADOOP_OPTIONS2=5' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'HADOOP_OPTIONS2=6' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
			switch (params.pts_hadoop_files) {
			case "100000":
				sh "echo 'HADOOP_OPTIONS3=1' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "1000000":
				sh "echo 'HADOOP_OPTIONS3=2' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "10000000":
				sh "echo 'HADOOP_OPTIONS3=3' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			case "Test All Options":
				sh "echo 'HADOOP_OPTIONS3=4' >> ${pts_home}/pts-automation-tool/.config.options"
				break
			}
		}
    } catch (Exception e) {
        def failure_message = "Error in configuration(): " + e.getMessage()
        error(failure_message)
    }    
}

void create_config_files() {
    try {
        if (fileExists("${pts_home}/pts-automation-tool/.config")) {
            echo "creating .comfig file"
            sh "rm ${pts_home}/pts-automation-tool/.config ; touch ${pts_home}/pts-automation-tool/.config"
        } else {
            sh "touch ${pts_home}/pts-automation-tool/.config"
        }
        if (fileExists("${pts_home}/pts-automation-tool/.config.options")) {
            echo "creating .comfig.options file"
            sh "rm ${pts_home}/pts-automation-tool/.config.options ; touch ${pts_home}/pts-automation-tool/.config.options"
        } else {
            sh "touch ${pts_home}/pts-automation-tool/.config.options"
        }
        echo "#### Configuration files are generated ####"
    } catch (Exception e) {
        def failure_message = "Error in create_config_files(): " + e.getMessage()
        error(failure_message)
    } 
}

void pipeline_init() {
    try {
        echo "#### Processing Pipeline Init ####"
        sh "cd ${pts_home} ; git init"
        if (fileExists("${pts_home}/pts-automation-tool/")) {
            echo "pts-automation-tools already exists"
        } else {
        sh "git clone https://github.com/SelamHemanth/pts-automation-tool.git ${pts_home}/pts-automation-tool"
        sh "cd ${pts_home}/pts-automation-tool/ ; git checkout jenkins ; sudo make install"
        }
        echo "#### Pipeline Init Completed ####"
    } catch (Exception e) {
        def failure_message = "Error in pipeline_init(): " + e.getMessage()
        error(failure_message)
    }
}
