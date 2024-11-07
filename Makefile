.PHONY: run install showresult saveresult

# Define the path where the test result directories are located
RESULTS_PATH := /var/lib/phoronix-test-suite/test-results

# Define the common suffix for the result files
RESULT_SUFFIX := txt

install:
	@host_distro_out=$$(cat /etc/os-release); \
	echo "OS Release Info: $${host_distro_out}"; \
	distroID=$$(echo "$${host_distro_out}" | grep "^ID=" | cut -d'=' -f2 | tr -d '"'); \
	echo "Detected distribution ID: $${distroID}"; \
	case "$${distroID}" in \
		ubuntu) \
			echo "Installing packages for ubuntu"; \
			sudo apt install -y openssl expat libopenmpi-dev libmpich-dev openmpi-bin libaio-dev mesa-utils vulkan-tools unzip apt-file git gcc make automake fakeroot build-essential libncurses-dev pkg-config expect xz-utils libssl-dev libelf-dev bc flex bison rpm dwarves lz4 python3-rpm software-properties-common cmake libpcre3-dev php-cli php-xml php-json php-zip kconfig-frontends; \
			;; \
		centos|rocky) \
			echo "Installing packages for centos/rocky"; \
			sudo yum install -y expat unzip java-openjdk libevent-devel libjpeg-turbo-devel libjpeg-devel libicu-devel expect newt epel-release gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel  elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel; \
			sudo dnf install -y php-cli php-xml php-json; \
			;; \
		anolis) \
			echo "Installing packages for anolis"; \
			sudo yum install -y openmpi-devel openmpi pcre-devel libevent-devel expect expat unzip java-openjdk libevent-devel libjpeg-turbo-devel libjpeg-devel libicu-devel expect newt gcc git vim time gcc-c++ kernel-devel perl make numactl openssl openssl-devel libmpc mpfr ncurses-devel bison tar rsync libstdc++-devel libtool bison flex zlib zlib-devel pcre-devel  elfutils-libelf-devel ncurses-devel createrepo rpm-build rpmdevtools cmake pcre-devel; \
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
