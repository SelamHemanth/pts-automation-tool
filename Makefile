.PHONY: menuconfig all saveconfig run install clean deepclean showresult saveresult

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
                centos|rocky|openEuler|anolis) \
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
	@if grep -q "CONFIG_PGBENCH_OPTION_7=y" .config; then echo -n "7," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PGBENCH_OPTIONS2=" >> .config.options
	@if grep -q "CONFIG_PGBENCH_OPTION_8=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_9=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_10=y" .config; then echo -n "3," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_11=y" .config; then echo -n "4," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_12=y" .config; then echo -n "5," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_13=y" .config; then echo -n "6," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_14=y" .config; then echo -n "7," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_15=y" .config; then echo -n "8," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_16=y" .config; then echo -n "9," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@echo -n "PGBENCH_OPTIONS3=" >> .config.options
	@if grep -q "CONFIG_PGBENCH_OPTION_17=y" .config; then echo -n "1," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_18=y" .config; then echo -n "2," >> .config.options; fi
	@if grep -q "CONFIG_PGBENCH_OPTION_19=y" .config; then echo -n "3," >> .config.options; fi
	@sed -i 's/,$$//' .config.options
	@echo "" >> .config.options

	@cat .config.options
	@echo "Configuration saved to .config.options"

run: saveconfig
	@if grep -q "CONFIG_NGINX=y" .config; then \
		./pts_nginx.sh; \
	else \
		echo "CONFIG_NGINX is not enabled in .config. Skipping test."; \
	fi
	@if grep -q "CONFIG_PGBENCH=y" .config; then \
		./pts_pgbench.sh; \
	else \
		echo "CONFIG_PGBENCH is not enabled in .config. Skipping test."; \
	fi

install:
	@host_distro_out=$$(cat /etc/os-release); \
	echo "OS Release Info: $${host_distro_out}"; \
	distroID=$$(echo "$${host_distro_out}" | grep "^ID=" | cut -d'=' -f2 | tr -d '"'); \
	echo "Detected distribution ID: $${distroID}"; \
	case "$${distroID}" in \
		ubuntu) \
			echo "Installing packages for ubuntu"; \
			sudo apt update; \
			sudo apt install -y sshpass git gcc make automake fakeroot build-essential ncurses-dev pkg-config expect xz-utils libssl-dev libelf-dev bc flex bison rpm dwarves lz4 python3-rpm software-properties-common cmake libpcre3-dev php-cli php-xml php-json php-zip kconfig-frontends; \
			;; \
		centos|rocky|openEuler|anolis) \
			echo "Installing packages for centos/rocky"; \
			sudo yum install -y  expect newt epel-release gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel openssl-devel elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel; \
			sudo dnf install -y php-cli php-xml php-json; \
			;; \
		*) \
			echo "Distro not supported or not matched"; \
			exit 1; \
		;; \
	esac
	echo "Downloading the Phoronix Test Suite as a compressed file"; \
	wget -O /tmp/phoronix-test-suite.tar.xz http://sos-jenkins.amd.com/phoronix_test_suite/phoronix-test-suite.tar.xz; \
	tar -xJvf /tmp/phoronix-test-suite.tar.xz -C /tmp; \
	cd /tmp/phoronix-test-suite && sudo ./install-sh; \
	phoronix-test-suite version

showresult:
	@echo "Displaying contents of result files:"
	@echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	@echo " "
	@for file in $(RESULT_FILES); do \
		echo "Contents of $$file:"; \
		cat $$file; \
		echo ""; \
	done

saveresult:
	@./saveresult
clean:
	@echo "Cleaning the files"
	sudo rm -rf /tmp/sshpass-1.10
	sudo rm -f /tmp/sshpass-1.08.tar.gz
	find  $(HOME)/.phoronix-test-suite/test-results -mindepth 1 ! -name '*.tar.gz' -exec rm -rf {} +

deepclean:
	rm -f .config
	rm -f .config.options
	sudo rm -rf /tmp/sshpass-1.10
	sudo rm -f /tmp/sshpass-1.08.tar.gz
	sudo rm -rf $(HOME)/.phoronix-test-suite/test-results/*

