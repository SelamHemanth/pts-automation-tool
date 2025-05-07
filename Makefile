.PHONY: menuconfig all saveconfig run install clean distclean showresult saveresult

# Define the path where the test result directories are located
RESULTS_PATH := $(HOME)/.phoronix-test-suite/test-results

# Define the common suffix for the result files
RESULT_SUFFIX := txt

menuconfig:
	@host_distro_out=$$(cat /etc/os-release); \
        echo "OS Release Info: $${host_distro_out}"; \
        distroID=$$(echo "$${host_distro_out}" | grep "^ID=" | cut -d'=' -f2 | tr -d '"'); \
        echo "Detected distribution ID: $${distroID}"; \
        case "$${distroID}" in \
                ubuntu) \
                        echo "Configuration : $${distroID}"; \
                        kconfig-mconf Kconfig \
                ;; \
                centos|rocky|openEuler|anolis|opencloudos) \
                        echo "Configuration : $${distroID}"; \
                        ./config \
                ;; \
        esac

all: menuconfig

saveconfig:
	@echo "Saving configuration..."
	@echo -n "NGINX_OPTIONS=" > .config.options
	@if grep -q "CONFIG_NGINX_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_7=y" .config; then echo -n "7," >> .config.options; fi
	@if grep -q "CONFIG_NGINX_OPTION_8=y" .config; then echo -n "8," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PGBENCH_OPTIONS1=" >> .config.options
	@if grep -q "CONFIG_PGBENCH_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PGBENCH_OPTIONS2=" >> .config.options
	@if grep -q "CONFIG_PGBENCH_OPTION_7=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_8=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_9=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_10=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_11=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_12=y" .config; then echo -n "6," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_13=y" .config; then echo -n "7," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_14=y" .config; then echo -n "8," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_15=y" .config; then echo -n "9," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PGBENCH_OPTIONS3=" >> .config.options
	@if grep -q "CONFIG_PGBENCH_OPTION_16=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_17=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_18=y" .config; then echo -n "3," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "STRESSNG_OPTIONS=" >> .config.options
	@if grep -q "CONFIG_STRESSNG_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_7=y" .config; then echo -n "7," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_8=y" .config; then echo -n "8," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_9=y" .config; then echo -n "9," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_10=y" .config; then echo -n "10," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_11=y" .config; then echo -n "11," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_12=y" .config; then echo -n "12," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_13=y" .config; then echo -n "13," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_14=y" .config; then echo -n "14," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_15=y" .config; then echo -n "15," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_16=y" .config; then echo -n "16," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_17=y" .config; then echo -n "17," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_18=y" .config; then echo -n "18," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_19=y" .config; then echo -n "19," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_20=y" .config; then echo -n "20," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_21=y" .config; then echo -n "21," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_22=y" .config; then echo -n "22," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_23=y" .config; then echo -n "23," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_24=y" .config; then echo -n "24," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_25=y" .config; then echo -n "25," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_26=y" .config; then echo -n "26," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_27=y" .config; then echo -n "27," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_28=y" .config; then echo -n "28," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_29=y" .config; then echo -n "29," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_30=y" .config; then echo -n "30," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_31=y" .config; then echo -n "31," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_32=y" .config; then echo -n "32," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_33=y" .config; then echo -n "33," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_34=y" .config; then echo -n "34," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_35=y" .config; then echo -n "35," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_36=y" .config; then echo -n "36," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_37=y" .config; then echo -n "37," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_38=y" .config; then echo -n "38," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_39=y" .config; then echo -n "39," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_40=y" .config; then echo -n "40," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_41=y" .config; then echo -n "41," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_42=y" .config; then echo -n "42," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_43=y" .config; then echo -n "43," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_44=y" .config; then echo -n "44," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_45=y" .config; then echo -n "45," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_46=y" .config; then echo -n "46," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_47=y" .config; then echo -n "47," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_48=y" .config; then echo -n "48," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_49=y" .config; then echo -n "49," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_50=y" .config; then echo -n "50," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_51=y" .config; then echo -n "51," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_52=y" .config; then echo -n "52," >> .config.options; fi
	@if grep -q "CONFIG_STRESSNG_OPTION_53=y" .config; then echo -n "53," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "REDIS_OPTIONS1=" >> .config.options
	@if grep -q "CONFIG_REDIS_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "REDIS_OPTIONS2=" >> .config.options
	@if grep -q "CONFIG_REDIS_OPTION_7=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_8=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_9=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_REDIS_OPTION_10=y" .config; then echo -n "4," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "OPENSSL_OPTIONS=" >> .config.options
	@if grep -q "CONFIG_OPENSSL_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_7=y" .config; then echo -n "7," >> .config.options; fi
	@if grep -q "CONFIG_OPENSSL_OPTION_8=y" .config; then echo -n "7," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "SYSBENCH_OPTIONS=" >> .config.options
	@if grep -q "CONFIG_SYSBENCH_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_SYSBENCH_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi	
	@if grep -q "CONFIG_SYSBENCH_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PENNANT_OPTIONS=" >> .config.options
	@if grep -q "CONFIG_PENNANT_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PENNANT_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PENNANT_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "MEMCACHED_OPTIONS=" >> .config.options
	@if grep -q "CONFIG_MEMCACHED_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_MEMCACHED_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_MEMCACHED_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_MEMCACHED_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_MEMCACHED_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_MEMCACHED_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "HADOOP_OPTIONS1=" >> .config.options
	@if grep -q "CONFIG_HADOOP_OPTION_1=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_2=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_3=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_4=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_5=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_6=y" .config; then echo -n "6," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "HADOOP_OPTIONS2=" >> .config.options
	@if grep -q "CONFIG_HADOOP_OPTION_7=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_8=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_9=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_10=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_11=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_12=y" .config; then echo -n "6," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "HADOOP_OPTIONS3=" >> .config.options
	@if grep -q "CONFIG_HADOOP_OPTION_13=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_14=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_15=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_HADOOP_OPTION_16=y" .config; then echo -n "4," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@cat .config.options
	@echo "Configuration saved to .config.options"

run: saveconfig
	@if grep -q "CONFIG_NGINX=y" .config; then \
		./runs/pts_nginx; \
	else \
		echo "CONFIG_NGINX is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_PGBENCH=y" .config; then \
		./runs/pts_pgbench; \
	else \
		echo "CONFIG_PGBENCH is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_STRESSNG=y" .config; then \
		./runs/pts_stress-ng; \
	else \
		echo "CONFIG_STRESSNG is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_REDIS=y" .config; then \
		./runs/pts_redis; \
	else \
		echo "CONFIG_REDIS is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_OPENSSL=y" .config; then \
		./runs/pts_openssl; \
	else \
		echo "CONFIG_OPENSSL is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_SYSBENCH=y" .config; then \
		./runs/pts_sysbench; \
	else \
		echo "CONFIG_SYSBENCH is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_PENNANT=y" .config; then \
		./runs/pts_pennant; \
	else \
		echo "CONFIG_PENNANT is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_MEMCACHED=y" .config; then \
		./runs/pts_memcached; \
	else \
		echo "CONFIG_MEMCACHED is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_HADOOP=y" .config; then \
		./runs/pts_hadoop; \
	else \
		echo "CONFIG_HADOOP is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_COMPRESS7ZIP=y" .config; then \
		./runs/pts_compress7zip; \
	else \
		echo "CONFIG_COMPRESS7ZIP is not enabled in .config. Skipping test."; \
	fi

install:
	@host_distro_out=$$(cat /etc/os-release); \
	echo "OS Release Info: $${host_distro_out}"; \
	distroID=$$(echo "$${host_distro_out}" | grep "^ID=" | cut -d'=' -f2 | tr -d '"'); \
	echo "Detected distribution ID: $${distroID}"; \
	case "$${distroID}" in \
		ubuntu) \
			echo "Installing packages for ubuntu"; \
			sudo apt install -y libapparmor-dev openssl expat libopenmpi-dev libmpich-dev openmpi-bin libaio-dev mesa-utils vulkan-tools unzip apt-file git gcc make automake fakeroot build-essential libncurses-dev pkg-config expect xz-utils libssl-dev libelf-dev bc flex bison rpm dwarves lz4 python3-rpm software-properties-common cmake libpcre3-dev php-cli php-xml php-json php-zip kconfig-frontends; \
			;; \
		centos|rocky) \
			echo "Installing packages for centos/rocky"; \
			sudo yum install -y expat unzip java-openjdk libevent-devel libjpeg-turbo-devel libjpeg-devel libicu-devel expect newt epel-release gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel  elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel; \
			sudo dnf install -y php-cli php-xml php-json; \
			;; \
		anolis) \
			echo "Installing packages for anolis"; \
			sudo yum install -y openmpi-devel openmpi pcre-devel libevent-devel expect expat unzip java-openjdk libevent-devel libjpeg-turbo-devel libjpeg-devel libicu-devel expect newt gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel  elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel p7zip p7zip-plugins; \
			sudo dnf install -y php-cli php-xml; \
                        ;; \
		openEuler) \
			echo "Installing packages for openEuler"; \
			sudo yum install -y openmpi-devel openmpi pcre-devel libevent-devel expect expat unzip java-openjdk libevent-devel libjpeg-turbo-devel libjpeg-devel libicu-devel expect newt gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel  elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel; \
			sudo dnf install -y php-cli php-xml; \
			;; \
		*) \
			echo "Distro not supported or not matched"; \
			exit 1; \
		;; \
	esac
	@if [ ! -f /usr/bin/phoronix-test-suite ]; then \
                echo "Phoronix Test Suite not found. Installing..."; \
                echo "Downloading the Phoronix Test Suite as a compressed file"; \
                wget -O /tmp/phoronix-test-suite.tar.xz http://sos-jenkins.amd.com/phoronix_test_suite/phoronix-test-suite.tar.xz; \
                tar -xJvf /tmp/phoronix-test-suite.tar.xz -C /tmp; \
                cd /tmp/phoronix-test-suite && sudo ./install-sh; \
                phoronix-test-suite version; \
        else \
                echo "Phoronix Test Suite is already installed."; \
                phoronix-test-suite version; \
        fi

# Target to display the contents of result files
showresult:
	@echo "Displaying contents of result files:"
	@echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	@echo " "
	@for dir in $(RESULTS_PATH)/*; do \
                if [ -d $$dir ]; then \
                        for file in $$dir/*.txt; do \
                                echo "Contents of $$file:"; \
                                cat $$file; \
                                echo ""; \
                        done; \
                fi; \
        done

saveresult:
	@./saveresult
clean:
	@echo "Cleaning the files"
	find  $(HOME)/.phoronix-test-suite/test-results -mindepth 1 ! -name '*.tar.gz' -exec rm -rf {} +

distclean:
	rm -f .config
	rm -f .config.options
	rm -f .config.old
	sudo rm -rf $(HOME)/.phoronix-test-suite/test-results/*

