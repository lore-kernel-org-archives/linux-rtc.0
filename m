Return-Path: <rtc-linux+bncBDRYNGFX7EDBBWHPTDAAKGQEISG4XNQ@googlegroups.com>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2001:1868:205::9])
        by gmr-mx.google.com with ESMTPS id um12si5942937pab.2.2016.10.18.07.55.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 07:55:20 -0700 (PDT)
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Karsten Keil <isdn@linux-pingi.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
	Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Harry Wei <harryxiyou@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Harald Welte <laforge@gnumonks.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Martyn Welch <martyn@welchs.me.uk>,
	Manohar Vanga <manohar.vanga@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Shuah Khan <shuah@kernel.org>,
	Diego Viola <diego.viola@gmail.com>,
	=?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Greg Hackmann <ghackmann@google.com>,
	=?UTF-8?q?Manuel=20P=C3=A9gouri=C3=A9-Gonnard?= <mpg@elzevir.fr>,
	Jiri Kosina <jkosina@suse.cz>,
	Li Zefan <lizefan@huawei.com>,
	Yuan Sun <sunyuan3@huawei.com>,
	Haosdent Huang <haosdent@gmail.com>,
	Li RongQing <roy.qing.li@gmail.com>,
	Masanari Iida <standby24x7@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	SeongJae Park <sj38.park@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Markus Heiser <markus.heiser@darmarIT.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Askar Safin <safinaskar@mail.ru>,
	Thomas Gardner <tmg@fastmail.com>,
	Peter Loeffler <peter.loeffler@guruz.at>,
	Philippe Loctaux <phil@philippeloctaux.com>,
	Doug Smythies <doug.smythies@gmail.com>,
	Chris Metcalf <cmetcalf@ezchip.com>,
	Jakub Wilk <jwilk@jwilk.net>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Finn Thain <fthain@telegraphics.com.au>,
	Hannes Reinicke <hare@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	"seokhoon.yoon" <iamyooon@gmail.com>,
	Egor Uleyskiy <egor.ulieiskii@gmail.com>,
	Ryan Swan <ryan@ryanswan.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Garnier <thgarnie@google.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Prarit Bhargava <prarit@redhat.com>,
	Yang Shi <yang.shi@linaro.org>,
	Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Darren Hart <dvhart@linux.intel.com>,
	Wei Jiangang <weijg.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org,
	rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	alsa-devel@alsa-project.org,
	kvm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@zh-kernel.org,
	linux-ide@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-nvdimm@ml01.01.org,
	devel@driverdev.osuosl.org,
	linux-fbdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 34/37] docs: fix locations of several documents
 that got moved
Date: Tue, 18 Oct 2016 12:53:54 -0200
Message-Id: <28c1f5d3867174a7017e3f3d9e9e4ebb096ceed8.1476801354.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1476801354.git.mchehab@s-opensource.com>
References: <cover.1476801354.git.mchehab@s-opensource.com>
MIME-Version: 1.0
In-Reply-To: <cover.1476801354.git.mchehab@s-opensource.com>
References: <cover.1476801354.git.mchehab@s-opensource.com>
Content-Type: text/plain; charset=UTF-8
Sender: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The previous patch renamed several files that are cross-referenced
along the Kernel documentation. Adjust the links to point to
the right places.

Most of the work here was made via a perl script. Two files
that got renamed (HOWTO and Changes) required manual work, as
there's a high number of false positives.

<script>
#!/usr/bin/perl
use File::Find;

my $show_string;

$show_string=3Dshift or $show_string=3D"git show";


open IN,"$show_string|";

my %map;

my $from;

#rename from Documentation/applying-patches.txt
#rename to Documentation/process/applying-patches.rst

while (<IN>) {
	if (m,^rename from\s+Documentation/(.*),) {
		$from =3D $1;
		next;
	}
	if (m,^rename to\s+Documentation/(.*),) {
		my $to =3D $1;

		if ($from =3D~ m/^(Changes|HOWTO)$/) {
			printf "Ignoring $from -> $to\n";
		} else {
			$map{$from} =3D $to;

			printf "'$from' -> '$to'\n";
		}
		next;
	}
	if (m,^rename from\s+(.*),) {
		$from =3D $1;
		next;
	}
	if (m,^rename to\s+(.*),) {
		my $to =3D $1;

		if ($from =3D~ m/^(Changes|HOWTO)$/) {
			printf "Ignoring $from -> $to\n";
		} else {
			$map{$from} =3D $to;

			printf "'$from' -> '$to'\n";
		}
		next;
	}
}

close IN;


foreach my $k (keys %map) {
	open FILE, "git grep -l $k|";

	while (<FILE>) {
		local $/=3Dundef;
		my $file =3D $_;
		$file =3D~ s/\n//;

		open IN, $file;
		my $data =3D <IN>;
		close IN;

		my $new_data =3D $data;

		$v =3D $map{$k};

		$new_data =3D~ s/\b($k)\b/$v/g;
		$new_data =3D~ s,\b(Documentation/$k)\b,Documentation/$v,g;

		if ($data ne $new_data) {
			printf "Writing $file, due to $k -> $v\n";

			my ($dev,$ino,$mode) =3D stat($file);

			open OUT, ">$file";
			print OUT $new_data;
			close OUT;

			chmod $mode, $file;
		}
	}
	close FILE;
}
</script>

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/00-INDEX                             | 54 +++++++++++-------=
----
 Documentation/ABI/README                           |  2 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |  2 +-
 Documentation/DocBook/kernel-hacking.tmpl          |  4 +-
 Documentation/acpi/video_extension.txt             |  2 +-
 Documentation/admin-guide/README.rst               | 13 +++---
 Documentation/admin-guide/bad-memory.rst           |  2 +-
 Documentation/admin-guide/binfmt-misc.rst          |  4 +-
 Documentation/admin-guide/braille-console.rst      |  6 +--
 Documentation/admin-guide/bug-hunting.rst          |  7 +--
 Documentation/admin-guide/devices.rst              |  4 +-
 Documentation/admin-guide/kernel-parameters.rst    |  6 +--
 Documentation/admin-guide/oops-tracing.rst         |  2 +-
 Documentation/admin-guide/ramoops.rst              |  2 +-
 Documentation/admin-guide/reporting-bugs.rst       |  6 +--
 Documentation/admin-guide/security-bugs.rst        |  2 +-
 Documentation/admin-guide/unicode.rst              |  2 +-
 Documentation/arm/Booting                          |  2 +-
 Documentation/atomic_ops.txt                       |  2 +-
 Documentation/blockdev/ramdisk.txt                 |  2 +-
 Documentation/cgroup-v1/00-INDEX                   |  2 +-
 .../devicetree/bindings/rtc/maxim,ds3231.txt       |  2 +-
 Documentation/devicetree/bindings/rtc/pcf8563.txt  |  2 +-
 .../devicetree/bindings/submitting-patches.txt     |  2 +-
 Documentation/filesystems/locks.txt                |  2 +-
 Documentation/filesystems/nfs/nfsroot.txt          |  4 +-
 Documentation/frv/booting.txt                      |  2 +-
 Documentation/hwmon/submitting-patches             |  8 ++--
 Documentation/isdn/README                          |  2 +-
 Documentation/ja_JP/HOWTO                          | 24 +++++-----
 Documentation/ja_JP/SubmitChecklist                |  8 ++--
 Documentation/ja_JP/SubmittingPatches              | 18 ++++----
 Documentation/ja_JP/stable_api_nonsense.txt        |  4 +-
 Documentation/ja_JP/stable_kernel_rules.txt        |  6 +--
 Documentation/kernel-per-CPU-kthreads.txt          |  2 +-
 Documentation/ko_KR/HOWTO                          | 30 ++++++------
 Documentation/ko_KR/stable_api_nonsense.txt        |  4 +-
 Documentation/lockup-watchdogs.txt                 |  4 +-
 Documentation/m68k/kernel-options.txt              |  2 +-
 Documentation/media/uapi/v4l/diff-v4l.rst          |  4 +-
 Documentation/media/v4l-drivers/bttv.rst           |  4 +-
 Documentation/memory-hotplug.txt                   |  2 +-
 Documentation/networking/netconsole.txt            |  2 +-
 Documentation/networking/netdev-FAQ.txt            |  8 ++--
 Documentation/networking/vortex.txt                |  2 +-
 Documentation/power/00-INDEX                       |  2 +-
 Documentation/power/pci.txt                        | 10 ++--
 Documentation/power/runtime_pm.txt                 |  2 +-
 Documentation/power/swsusp-dmcrypt.txt             |  2 +-
 Documentation/process/4.Coding.rst                 |  4 +-
 Documentation/process/5.Posting.rst                | 12 ++---
 Documentation/process/8.Conclusion.rst             |  6 +--
 Documentation/process/adding-syscalls.rst          |  2 +-
 Documentation/process/coding-style.rst             |  2 +-
 Documentation/process/howto.rst                    | 24 +++++-----
 Documentation/process/management-style.rst         |  2 +-
 Documentation/process/stable-kernel-rules.rst      |  4 +-
 Documentation/process/submit-checklist.rst         |  6 +--
 Documentation/process/submitting-drivers.rst       |  8 ++--
 Documentation/process/submitting-patches.rst       | 14 +++---
 Documentation/rfkill.txt                           |  2 +-
 Documentation/scsi/scsi-parameters.txt             |  2 +-
 Documentation/scsi/scsi_mid_low_api.txt            |  2 +-
 Documentation/scsi/sym53c8xx_2.txt                 |  2 +-
 Documentation/sound/alsa/alsa-parameters.txt       |  2 +-
 Documentation/sound/oss/oss-parameters.txt         |  2 +-
 Documentation/sysctl/kernel.txt                    |  4 +-
 Documentation/virtual/kvm/review-checklist.txt     |  4 +-
 Documentation/vm/numa                              |  2 +-
 .../watchdog/convert_drivers_to_kernel_api.txt     |  2 +-
 Documentation/watchdog/watchdog-parameters.txt     |  2 +-
 Documentation/x86/boot.txt                         |  2 +-
 Documentation/zh_CN/CodingStyle                    |  6 +--
 Documentation/zh_CN/HOWTO                          | 30 ++++++------
 Documentation/zh_CN/SecurityBugs                   |  6 +--
 Documentation/zh_CN/SubmittingDrivers              | 12 ++---
 Documentation/zh_CN/SubmittingPatches              | 14 +++---
 Documentation/zh_CN/arm/Booting                    |  2 +-
 Documentation/zh_CN/email-clients.txt              |  4 +-
 Documentation/zh_CN/oops-tracing.txt               |  6 +--
 Documentation/zh_CN/stable_api_nonsense.txt        |  4 +-
 Documentation/zh_CN/stable_kernel_rules.txt        |  6 +--
 .../zh_CN/volatile-considered-harmful.txt          |  4 +-
 MAINTAINERS                                        | 10 ++--
 arch/x86/Kconfig                                   |  2 +-
 drivers/acpi/Kconfig                               |  2 +-
 drivers/ata/libata-core.c                          |  2 +-
 drivers/char/pcmcia/cm4000_cs.c                    |  4 +-
 drivers/net/can/grcan.c                            |  2 +-
 drivers/nvdimm/Kconfig                             |  2 +-
 drivers/staging/vme/devices/vme_user.c             |  2 +-
 drivers/video/fbdev/skeletonfb.c                   |  8 ++--
 drivers/virtio/Kconfig                             |  2 +-
 fs/Kconfig.binfmt                                  |  4 +-
 fs/pstore/Kconfig                                  |  2 +-
 include/linux/device.h                             |  2 +-
 include/linux/pm.h                                 |  2 +-
 include/uapi/linux/major.h                         |  2 +-
 init/Kconfig                                       |  2 +-
 init/main.c                                        |  2 +-
 lib/Kconfig.debug                                  |  2 +-
 scripts/checkpatch.pl                              |  6 +--
 tools/testing/selftests/futex/README               |  2 +-
 103 files changed, 281 insertions(+), 279 deletions(-)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index d07575a8499e..39caa6544d1f 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -15,11 +15,11 @@ Following translations are available on the WWW:
 ABI/
 	- info on kernel <-> userspace ABI and relative interface stability.
=20
-BUG-HUNTING
+admin-guide/bug-hunting.rst
 	- brute force method of doing binary search of patches to find bug.
-Changes
+process/changes.rst
 	- list of changes that break older software packages.
-CodingStyle
+process/coding-style.rst
 	- how the maintainers expect the C code in the kernel to look.
 DMA-API.txt
 	- DMA API, pci_ API & extensions for non-consistent memory machines.
@@ -33,7 +33,7 @@ DocBook/
 	- directory with DocBook templates etc. for kernel documentation.
 EDID/
 	- directory with info on customizing EDID for broken gfx/displays.
-HOWTO
+process/howto.rst
 	- the process and procedures of how to do Linux kernel development.
 IPMI.txt
 	- info on Linux Intelligent Platform Management Interface (IPMI) Driver.
@@ -48,7 +48,7 @@ Intel-IOMMU.txt
 Makefile
 	- This file does nothing. Removing it breaks make htmldocs and
 	  make distclean.
-ManagementStyle
+process/management-style.rst
 	- how to (attempt to) manage kernel hackers.
 RCU/
 	- directory with info on RCU (read-copy update).
@@ -56,13 +56,13 @@ SAK.txt
 	- info on Secure Attention Keys.
 SM501.txt
 	- Silicon Motion SM501 multimedia companion chip
-SecurityBugs
+admin-guide/security-bugs.rst
 	- procedure for reporting security bugs found in the kernel.
-SubmitChecklist
+process/submit-checklist.rst
 	- Linux kernel patch submission checklist.
-SubmittingDrivers
+process/submitting-drivers.rst
 	- procedure to get a new driver source included into the kernel tree.
-SubmittingPatches
+process/submitting-patches.rst
 	- procedure to get a source patch included into the kernel tree.
 VGA-softcursor.txt
 	- how to change your VGA cursor from a blinking underscore.
@@ -72,7 +72,7 @@ acpi/
 	- info on ACPI-specific hooks in the kernel.
 aoe/
 	- description of AoE (ATA over Ethernet) along with config examples.
-applying-patches.txt
+process/applying-patches.rst
 	- description of various trees and how to apply their patches.
 arm/
 	- directory with info about Linux on the ARM architecture.
@@ -86,7 +86,7 @@ auxdisplay/
 	- misc. LCD driver documentation (cfag12864b, ks0108).
 backlight/
 	- directory with info on controlling backlights in flat panel displays
-bad_memory.txt
+admin-guide/bad-memory.rst
 	- how to use kernel parameters to exclude bad RAM regions.
 basic_profiling.txt
 	- basic instructions for those who wants to profile Linux kernel.
@@ -154,7 +154,7 @@ process/
 	- how to work with the mainline kernel development process.
 device-mapper/
 	- directory with info on Device Mapper.
-devices.txt
+admin-guide/devices.rst
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s.
 devicetree/
 	- directory with info on device tree files used by OF/PowerPC/ARM
@@ -178,7 +178,7 @@ efi-stub.txt
 	- How to use the EFI boot stub to bypass GRUB or elilo on EFI systems.
 eisa.txt
 	- info on EISA bus support.
-email-clients.txt
+process/email-clients.rst
 	- info on how to use e-mail to send un-mangled (git) patches.
 extcon/
 	- directory with porting guide for Android kernel switch driver.
@@ -226,9 +226,9 @@ ia64/
 	- directory with info about Linux on Intel 64 bit architecture.
 infiniband/
 	- directory with documents concerning Linux InfiniBand support.
-init.txt
+admin-guide/init.rst
 	- what to do when the kernel can't find the 1st process to run.
-initrd.txt
+admin-guide/initrd.rst
 	- how to use the RAM disk as an initial/temporary root filesystem.
 input/
 	- info on Linux input device support.
@@ -248,7 +248,7 @@ isapnp.txt
 	- info on Linux ISA Plug & Play support.
 isdn/
 	- directory with info on the Linux ISDN support, and supported cards.
-java.txt
+admin-guide/java.rst
 	- info on the in-kernel binary support for Java(tm).
 ja_JP/
 	- directory with Japanese translations of various documents
@@ -256,11 +256,11 @@ kbuild/
 	- directory with info about the kernel build process.
 kdump/
 	- directory with mini HowTo on getting the crash dump code to work.
-kernel-docs.txt
+process/kernel-docs.rst
 	- listing of various WWW + books that document kernel internals.
 kernel-documentation.rst
 	- how to write and format reStructuredText kernel documentation
-kernel-parameters.txt
+admin-guide/kernel-parameters.rst
 	- summary listing of command line / boot prompt args for the kernel.
 kernel-per-CPU-kthreads.txt
 	- List of all per-CPU kthreads and how they introduce jitter.
@@ -302,7 +302,7 @@ magic-number.txt
 	- list of magic numbers used to mark/protect kernel data structures.
 mailbox.txt
 	- How to write drivers for the common mailbox framework (IPC).
-md.txt
+admin-guide/md.rst
 	- info on boot arguments for the multiple devices driver.
 media-framework.txt
 	- info on media framework, its data structures, functions and usage.
@@ -326,7 +326,7 @@ module-signing.txt
 	- Kernel module signing for increased security when loading modules.
 mtd/
 	- directory with info about memory technology devices (flash)
-mono.txt
+admin-guide/mono.rst
 	- how to execute Mono-based .NET binaries with the help of BINFMT_MISC.
 namespaces/
 	- directory with various information about namespaces
@@ -340,7 +340,7 @@ nommu-mmap.txt
 	- documentation about no-mmu memory mapping support.
 numastat.txt
 	- info on how to read Numa policy hit/miss statistics in sysfs.
-oops-tracing.txt
+admin-guide/oops-tracing.rst
 	- how to decode those nasty internal kernel error dump messages.
 padata.txt
 	- An introduction to the "padata" parallel execution API
@@ -378,7 +378,7 @@ ptp/
 	- directory with info on support for IEEE 1588 PTP clocks in Linux.
 pwm.txt
 	- info on the pulse width modulation driver subsystem
-ramoops.txt
+admin-guide/ramoops.rst
 	- documentation of the ramoops oops/panic logging module.
 rapidio/
 	- directory with info on RapidIO packet-based fabric interconnect
@@ -406,7 +406,7 @@ security/
 	- directory that contains security-related info
 serial/
 	- directory with info on the low level serial API.
-serial-console.txt
+admin-guide/serial-console.rst
 	- how to set up Linux with a serial line console as the default.
 sgi-ioc4.txt
 	- description of the SGI IOC4 PCI (multi function) device.
@@ -420,9 +420,9 @@ sparse.txt
 	- info on how to obtain and use the sparse tool for typechecking.
 spi/
 	- overview of Linux kernel Serial Peripheral Interface (SPI) support.
-stable_api_nonsense.txt
+process/stable-api-nonsense.rst
 	- info on why the kernel does not have a stable in-kernel api or abi.
-stable_kernel_rules.txt
+process/stable-kernel-rules.rst
 	- rules and procedures for the -stable kernel releases.
 static-keys.txt
 	- info on how static keys allow debug code in hotpaths via patching
@@ -444,7 +444,7 @@ trace/
 	- directory with info on tracing technologies within linux
 unaligned-memory-access.txt
 	- info on how to avoid arch breaking unaligned memory access in code.
-unicode.txt
+admin-guide/unicode.rst
 	- info on the Unicode character/font mapping used in Linux.
 unshare.txt
 	- description of the Linux unshare system call.
@@ -466,7 +466,7 @@ vm/
 	- directory with info on the Linux vm code.
 vme_api.txt
 	- file relating info on the VME bus API in linux
-volatile-considered-harmful.txt
+process/volatile-considered-harmful.rst
 	- Why the "volatile" type class should not be used
 w1/
 	- directory with documents regarding the 1-wire (w1) subsystem.
diff --git a/Documentation/ABI/README b/Documentation/ABI/README
index 1fafc4b0753b..3121029dce21 100644
--- a/Documentation/ABI/README
+++ b/Documentation/ABI/README
@@ -84,4 +84,4 @@ stable:
=20
 - Kernel-internal symbols.  Do not rely on the presence, absence, location=
, or
   type of any kernel symbol, either in System.map files or the kernel bina=
ry
-  itself.  See Documentation/stable_api_nonsense.txt.
+  itself.  See Documentation/process/stable-api-nonsense.rst.
diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/AB=
I/testing/sysfs-kernel-slab
index 91bd6ca5440f..2cc0a72b64be 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -347,7 +347,7 @@ Description:
 		because of fragmentation, SLUB will retry with the minimum order
 		possible depending on its characteristics.
 		When debug_guardpage_minorder=3DN (N > 0) parameter is specified
-		(see Documentation/kernel-parameters.txt), the minimum possible
+		(see Documentation/admin-guide/kernel-parameters.rst), the minimum possi=
ble
 		order is used and this sysfs entry can not be used to change
 		the order at run time.
=20
diff --git a/Documentation/DocBook/kernel-hacking.tmpl b/Documentation/DocB=
ook/kernel-hacking.tmpl
index 2a272275c81b..da5c087462b1 100644
--- a/Documentation/DocBook/kernel-hacking.tmpl
+++ b/Documentation/DocBook/kernel-hacking.tmpl
@@ -1208,8 +1208,8 @@ static struct block_device_operations opt_fops =3D {
   =20
    <listitem>
     <para>
-     Finally, don't forget to read <filename>Documentation/SubmittingPatch=
es</filename>
-     and possibly <filename>Documentation/SubmittingDrivers</filename>.
+     Finally, don't forget to read <filename>Documentation/process/submitt=
ing-patches.rst</filename>
+     and possibly <filename>Documentation/process/submitting-drivers.rst</=
filename>.
     </para>
    </listitem>
   </itemizedlist>
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/vi=
deo_extension.txt
index 78b32ac02466..79bf6a4921be 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.txt
@@ -101,6 +101,6 @@ received a notification, it will set the backlight leve=
l accordingly. This does
 not affect the sending of event to user space, they are always sent to use=
r
 space regardless of whether or not the video module controls the backlight=
 level
 directly. This behaviour can be controlled through the brightness_switch_e=
nabled
-module parameter as documented in kernel-parameters.txt. It is recommended=
 to
+module parameter as documented in admin-guide/kernel-parameters.rst. It is=
 recommended to
 disable this behaviour once a GUI environment starts up and wants to have =
full
 control of the backlight level.
diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-gui=
de/README.rst
index 3335b3b2973a..f3cf12d4bcdd 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -50,7 +50,8 @@ Documentation
  - There are various README files in the Documentation/ subdirectory:
    these typically contain kernel-specific installation notes for some
    drivers for example. See Documentation/00-INDEX for a list of what
-   is contained in each file.  Please read the Changes file, as it
+   is contained in each file.  Please read the
+   :ref:`Documentation/process/changes.rst <changes>` file, as it
    contains information about the problems, which may result by upgrading
    your kernel.
=20
@@ -96,7 +97,7 @@ Installing the kernel source
    and 4.0.2 patches. Similarly, if you are running kernel version 4.0.2 a=
nd
    want to jump to 4.0.3, you must first reverse the 4.0.2 patch (that is,
    patch -R) **before** applying the 4.0.3 patch. You can read more on thi=
s in
-   :ref:`Documentation/applying-patches.txt <applying_patches>`.
+   :ref:`Documentation/process/applying-patches.rst <applying_patches>`.
=20
    Alternatively, the script patch-kernel can be used to automate this
    process.  It determines the current kernel version and applies any
@@ -120,7 +121,7 @@ Software requirements
=20
    Compiling and running the 4.x kernels requires up-to-date
    versions of various software packages.  Consult
-   :ref:`Documentation/Changes <changes>` for the minimum version numbers
+   :ref:`Documentation/process/changes.rst <changes>` for the minimum vers=
ion numbers
    required and how to get updates for these packages.  Beware that using
    excessively old versions of these packages can cause indirect
    errors that are very difficult to track down, so don't assume that
@@ -254,7 +255,7 @@ Compiling the kernel
 --------------------
=20
  - Make sure you have at least gcc 3.2 available.
-   For more information, refer to :ref:`Documentation/Changes <changes>`.
+   For more information, refer to :ref:`Documentation/process/changes.rst =
<changes>`.
=20
    Please note that you can still run a.out user programs with this kernel=
.
=20
@@ -355,7 +356,7 @@ If something goes wrong
    help debugging the problem.  The text above the dump is also
    important: it tells something about why the kernel dumped code (in
    the above example, it's due to a bad kernel pointer). More information
-   on making sense of the dump is in Documentation/oops-tracing.txt
+   on making sense of the dump is in Documentation/admin-guide/oops-tracin=
g.rst
=20
  - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
    as is, otherwise you will have to use the ``ksymoops`` program to make
@@ -393,7 +394,7 @@ If something goes wrong
=20
    If you for some reason cannot do the above (you have a pre-compiled
    kernel image or similar), telling me as much about your setup as
-   possible will help.  Please read the :ref:`REPORTING-BUGS <reportingbug=
s>`
+   possible will help.  Please read the :ref:`admin-guide/reporting-bugs.r=
st <reportingbugs>`
    document for details.
=20
  - Alternatively, you can use gdb on a running kernel. (read-only; i.e. yo=
u
diff --git a/Documentation/admin-guide/bad-memory.rst b/Documentation/admin=
-guide/bad-memory.rst
index 5cac93e27a97..ec5aafd1b3f1 100644
--- a/Documentation/admin-guide/bad-memory.rst
+++ b/Documentation/admin-guide/bad-memory.rst
@@ -33,7 +33,7 @@ memmap is already in the kernel and usable as kernel-para=
meter at
 boot-time.  Its syntax is slightly strange and you may need to
 calculate the values by yourself!
=20
-Syntax to exclude a memory area (see kernel-parameters.txt for details)::
+Syntax to exclude a memory area (see admin-guide/kernel-parameters.rst for=
 details)::
=20
 	memmap=3D<size>$<address>
=20
diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admi=
n-guide/binfmt-misc.rst
index 9c5ff8f260bf..97b0d7927078 100644
--- a/Documentation/admin-guide/binfmt-misc.rst
+++ b/Documentation/admin-guide/binfmt-misc.rst
@@ -124,7 +124,7 @@ A few examples (assumed you are in ``/proc/sys/fs/binfm=
t_misc``):
=20
     echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
=20
-For java support see Documentation/java.txt
+For java support see Documentation/admin-guide/java.rst
=20
=20
 You can enable/disable binfmt_misc or one binary type by echoing 0 (to dis=
able)
@@ -140,7 +140,7 @@ Hints
 -----
=20
 If you want to pass special arguments to your interpreter, you can
-write a wrapper script for it. See Documentation/java.txt for an
+write a wrapper script for it. See Documentation/admin-guide/java.rst for =
an
 example.
=20
 Your interpreter should NOT look in the PATH for the filename; the kernel
diff --git a/Documentation/admin-guide/braille-console.rst b/Documentation/=
admin-guide/braille-console.rst
index fa3702dc04ab..18e79337dcfd 100644
--- a/Documentation/admin-guide/braille-console.rst
+++ b/Documentation/admin-guide/braille-console.rst
@@ -3,7 +3,7 @@ Linux Braille Console
=20
 To get early boot messages on a braille device (before userspace screen
 readers can start), you first need to compile the support for the usual se=
rial
-console (see :ref:`Documentation/serial-console.txt <serial_console>`), an=
d
+console (see :ref:`Documentation/admin-guide/serial-console.rst <serial_co=
nsole>`), and
 for braille device
 (in :menuselection:`Device Drivers --> Accessibility support --> Console o=
n braille device`).
=20
@@ -13,7 +13,7 @@ format is::
 	console=3Dbrl,serial_options...
=20
 where ``serial_options...`` are the same as described in
-:ref:`Documentation/serial-console.txt <serial_console>`.
+:ref:`Documentation/admin-guide/serial-console.rst <serial_console>`.
=20
 So for instance you can use ``console=3Dbrl,ttyS0`` if the braille device =
is connected to the first serial port, and ``console=3Dbrl,ttyS0,115200`` t=
o
 override the baud rate to 115200, etc.
@@ -31,7 +31,7 @@ parameter.
 For simplicity, only one braille console can be enabled, other uses of
 ``console=3Dbrl,...`` will be discarded.  Also note that it does not inter=
fere with
 the console selection mechanism described in
-:ref:`Documentation/serial-console.txt <serial_console>`.
+:ref:`Documentation/admin-guide/serial-console.rst <serial_console>`.
=20
 For now, only the VisioBraille device is supported.
=20
diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admi=
n-guide/bug-hunting.rst
index a8ef794aadae..d35dd9fd1af0 100644
--- a/Documentation/admin-guide/bug-hunting.rst
+++ b/Documentation/admin-guide/bug-hunting.rst
@@ -15,7 +15,7 @@ give up. Report as much as you have found to the relevant=
 maintainer. See
 MAINTAINERS for who that is for the subsystem you have worked on.
=20
 Before you submit a bug report read
-:ref:`Documentation/REPORTING-BUGS <reportingbugs>`.
+:ref:`Documentation/admin-guide/reporting-bugs.rst <reportingbugs>`.
=20
 Devices not appearing
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -244,5 +244,6 @@ Once you have worked out a fix please submit it upstrea=
m. After all open
 source is about sharing what you do and don't you want to be recognised fo=
r
 your genius?
=20
-Please do read :ref:`Documentation/SubmittingPatches <submittingpatches>`
-though to help your code get accepted.
+Please do read
+ref:`Documentation/process/submitting-patches.rst <submittingpatches>` tho=
ugh
+to help your code get accepted.
diff --git a/Documentation/admin-guide/devices.rst b/Documentation/admin-gu=
ide/devices.rst
index 17b365331f23..36c279ad64ed 100644
--- a/Documentation/admin-guide/devices.rst
+++ b/Documentation/admin-guide/devices.rst
@@ -9,8 +9,8 @@ system.
 The LaTeX version of this document is no longer maintained, nor is
 the document that used to reside at lanana.org.  This version in the
 mainline Linux kernel is the master document.  Updates shall be sent
-as patches to the kernel maintainers (see the
-:ref:`Documentation/SubmittingPatches <submittingpatches>` document).
+as patches to the kernel maintainers (see the=20
+:ref:`Documentation/process/submitting-patches.rst` document).
 Specifically explore the sections titled "CHAR and MISC DRIVERS", and
 "BLOCK LAYER" in the MAINTAINERS file to find the right maintainers
 to involve for character and block devices.
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentatio=
n/admin-guide/kernel-parameters.rst
index b0804273b6e3..d2f2725f032e 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -815,7 +815,7 @@ bytes respectively. Such letter suffixes can also be en=
tirely omitted::
 			bits, and "f" is flow control ("r" for RTS or
 			omit it).  Default is "9600n8".
=20
-			See Documentation/serial-console.txt for more
+			See Documentation/admin-guide/serial-console.rst for more
 			information.  See
 			Documentation/networking/netconsole.txt for an
 			alternative.
@@ -2239,7 +2239,7 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted::
 	mce=3Doption	[X86-64] See Documentation/x86/x86_64/boot-options.txt
=20
 	md=3D		[HW] RAID subsystems devices and level
-			See Documentation/md.txt.
+			See Documentation/admin-guide/md.rst.
=20
 	mdacon=3D		[MDA]
 			Format: <first>,<last>
@@ -3322,7 +3322,7 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted::
 	r128=3D		[HW,DRM]
=20
 	raid=3D		[HW,RAID]
-			See Documentation/md.txt.
+			See Documentation/admin-guide/md.rst.
=20
 	ramdisk_size=3D	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
diff --git a/Documentation/admin-guide/oops-tracing.rst b/Documentation/adm=
in-guide/oops-tracing.rst
index 3e25ea7349ee..13be8d7bcfe7 100644
--- a/Documentation/admin-guide/oops-tracing.rst
+++ b/Documentation/admin-guide/oops-tracing.rst
@@ -44,7 +44,7 @@ the disk is not available then you have three options :
     so won't help for 'early' oopses)
=20
 (2) Boot with a serial console (see
-    :ref:`Documentation/serial-console.txt <serial_console>`),
+    :ref:`Documentation/admin-guide/serial-console.rst <serial_console>`),
     run a null modem to a second machine and capture the output there
     using your favourite communication program.  Minicom works well.
=20
diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-gu=
ide/ramoops.rst
index 7eaf1e71c083..fe95c027e37c 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -61,7 +61,7 @@ Setting the ramoops parameters can be done in several dif=
ferent manners:
 	mem=3D128M ramoops.mem_address=3D0x8000000 ramoops.ecc=3D1
=20
  B. Use Device Tree bindings, as described in
- ``Documentation/device-tree/bindings/reserved-memory/ramoops.txt``.
+ ``Documentation/device-tree/bindings/reserved-memory/admin-guide/ramoops.=
rst``.
  For example::
=20
 	reserved-memory {
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/a=
dmin-guide/reporting-bugs.rst
index 05c53ac7fa76..0c0f2698ec5a 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -61,7 +61,7 @@ files to the get_maintainer.pl script::
=20
 If it is a security bug, please copy the Security Contact listed in the
 MAINTAINERS file.  They can help coordinate bugfix and disclosure.  See
-:ref:`Documentation/SecurityBugs <securitybugs>` for more information.
+:ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>` for more=
 information.
=20
 If you can't figure out which subsystem caused the issue, you should file
 a bug in kernel.org bugzilla and send email to
@@ -94,7 +94,7 @@ step-by-step instructions for how a user can trigger the =
bug.
=20
 If the failure includes an "OOPS:", take a picture of the screen, capture
 a netconsole trace, or type the message from your screen into the bug
-report.  Please read "Documentation/oops-tracing.txt" before posting your
+report.  Please read "Documentation/admin-guide/oops-tracing.rst" before p=
osting your
 bug report. This explains what you should do with the "Oops" information
 to make it useful to the recipient.
=20
@@ -120,7 +120,7 @@ summary from [1.]>" for easy identification by the deve=
lopers::
   [4.2.] Kernel .config file:
   [5.] Most recent kernel version which did not have the bug:
   [6.] Output of Oops.. message (if applicable) with symbolic information
-       resolved (see Documentation/oops-tracing.txt)
+       resolved (see Documentation/admin-guide/oops-tracing.rst)
   [7.] A small shell script or example program which triggers the
        problem (if possible)
   [8.] Environment
diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/ad=
min-guide/security-bugs.rst
index df795e22d08b..4f7414cad586 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -19,7 +19,7 @@ area maintainers to understand and fix the security vulne=
rability.
=20
 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
-REPORTING-BUGS if you are unclear about what information is helpful.
+admin-guide/reporting-bugs.rst if you are unclear about what information i=
s helpful.
 Any exploit code is very helpful and will not be released without
 consent from the reporter unless it has already been made public.
=20
diff --git a/Documentation/admin-guide/unicode.rst b/Documentation/admin-gu=
ide/unicode.rst
index 012e8e895842..4e5c3df9d55f 100644
--- a/Documentation/admin-guide/unicode.rst
+++ b/Documentation/admin-guide/unicode.rst
@@ -7,7 +7,7 @@ This file is maintained by H. Peter Anvin <unicode@lanana.o=
rg> as part
 of the Linux Assigned Names And Numbers Authority (LANANA) project.
 The current version can be found at:
=20
-	    http://www.lanana.org/docs/unicode/unicode.txt
+	    http://www.lanana.org/docs/unicode/admin-guide/unicode.rst
=20
 Introdution
 -----------
diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 83c1df2fc758..259f00af3ab3 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -51,7 +51,7 @@ As an alternative, the boot loader can pass the relevant =
'console=3D'
 option to the kernel via the tagged lists specifying the port, and
 serial format options as described in
=20
-       Documentation/kernel-parameters.txt.
+       Documentation/admin-guide/kernel-parameters.rst.
=20
=20
 3. Detect the machine type
diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index c9d1cacb4395..7281bf939779 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -16,7 +16,7 @@ will fail.  Something like the following should suffice:
 	typedef struct { long counter; } atomic_long_t;
=20
 Historically, counter has been declared volatile.  This is now discouraged=
.
-See Documentation/volatile-considered-harmful.txt for the complete rationa=
le.
+See Documentation/process/volatile-considered-harmful.rst for the complete=
 rationale.
=20
 local_t is very similar to atomic_t. If the counter is per CPU and only
 updated by one CPU, local_t is probably more appropriate. Please see
diff --git a/Documentation/blockdev/ramdisk.txt b/Documentation/blockdev/ra=
mdisk.txt
index fe2ef978d85a..501e12e0323e 100644
--- a/Documentation/blockdev/ramdisk.txt
+++ b/Documentation/blockdev/ramdisk.txt
@@ -14,7 +14,7 @@ Contents:
=20
 The RAM disk driver is a way to use main system memory as a block device. =
 It
 is required for initrd, an initial filesystem used if you need to load mod=
ules
-in order to access the root filesystem (see Documentation/initrd.txt).  It=
 can
+in order to access the root filesystem (see Documentation/admin-guide/init=
rd.rst).  It can
 also be used for a temporary filesystem for crypto work, since the content=
s
 are erased on reboot.
=20
diff --git a/Documentation/cgroup-v1/00-INDEX b/Documentation/cgroup-v1/00-=
INDEX
index 106885ad670d..13e0c85e7b35 100644
--- a/Documentation/cgroup-v1/00-INDEX
+++ b/Documentation/cgroup-v1/00-INDEX
@@ -8,7 +8,7 @@ cpuacct.txt
 	- CPU Accounting Controller; account CPU usage for groups of tasks.
 cpusets.txt
 	- documents the cpusets feature; assign CPUs and Mem to a set of tasks.
-devices.txt
+admin-guide/devices.rst
 	- Device Whitelist Controller; description, interface and security.
 freezer-subsystem.txt
 	- checkpointing; rationale to not use signals, interface.
diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt b/Docum=
entation/devicetree/bindings/rtc/maxim,ds3231.txt
index ddef330d2709..1ad4c1c2b3b3 100644
--- a/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
+++ b/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
@@ -1,7 +1,7 @@
 * Maxim DS3231 Real Time Clock
=20
 Required properties:
-see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
+see: Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
=20
 Optional property:
 - #clock-cells: Should be 1.
diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentat=
ion/devicetree/bindings/rtc/pcf8563.txt
index 72f6d2c9665e..086c998c5561 100644
--- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -3,7 +3,7 @@
 Philips PCF8563/Epson RTC8564 Real Time Clock
=20
 Required properties:
-see: Documentation/devicetree/bindings/i2c/trivial-devices.txt
+see: Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
=20
 Optional property:
 - #clock-cells: Should be 0.
diff --git a/Documentation/devicetree/bindings/submitting-patches.txt b/Doc=
umentation/devicetree/bindings/submitting-patches.txt
index 7d44eae7ab0b..274058c583dd 100644
--- a/Documentation/devicetree/bindings/submitting-patches.txt
+++ b/Documentation/devicetree/bindings/submitting-patches.txt
@@ -3,7 +3,7 @@
=20
 I. For patch submitters
=20
-  0) Normal patch submission rules from Documentation/SubmittingPatches
+  0) Normal patch submission rules from Documentation/process/submitting-p=
atches.rst
      applies.
=20
   1) The Documentation/ portion of the patch should be a separate patch.
diff --git a/Documentation/filesystems/locks.txt b/Documentation/filesystem=
s/locks.txt
index 2cf81082581d..5368690f412e 100644
--- a/Documentation/filesystems/locks.txt
+++ b/Documentation/filesystems/locks.txt
@@ -19,7 +19,7 @@ forever.
=20
 This should not cause problems for anybody, since everybody using a
 2.1.x kernel should have updated their C library to a suitable version
-anyway (see the file "Documentation/Changes".)
+anyway (see the file "Documentation/process/changes.rst".)
=20
 1.2 Allow Mixed Locks Again
 ---------------------------
diff --git a/Documentation/filesystems/nfs/nfsroot.txt b/Documentation/file=
systems/nfs/nfsroot.txt
index 0b2883b17d4c..5efae00f6c7f 100644
--- a/Documentation/filesystems/nfs/nfsroot.txt
+++ b/Documentation/filesystems/nfs/nfsroot.txt
@@ -11,7 +11,7 @@ Updated 2006 by Horms <horms@verge.net.au>
 In order to use a diskless system, such as an X-terminal or printer server
 for example, it is necessary for the root filesystem to be present on a
 non-disk device. This may be an initramfs (see Documentation/filesystems/
-ramfs-rootfs-initramfs.txt), a ramdisk (see Documentation/initrd.txt) or a
+ramfs-rootfs-initramfs.txt), a ramdisk (see Documentation/admin-guide/init=
rd.rst) or a
 filesystem mounted via NFS. The following text describes on how to use NFS
 for the root filesystem. For the rest of this text 'client' means the
 diskless system, and 'server' means the NFS server.
@@ -284,7 +284,7 @@ They depend on various facilities being available:
 	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
 	are passed to the kernel by adding them to the "append" line.
 	It is common to use serial console in conjunction with pxeliunx,
-	see Documentation/serial-console.txt for more information.
+	see Documentation/admin-guide/serial-console.rst for more information.
=20
 	For more information on isolinux, including how to create bootdisks
 	for prebuilt kernels, see http://syslinux.zytor.com/
diff --git a/Documentation/frv/booting.txt b/Documentation/frv/booting.txt
index 9bdf4b46e741..cd9dc1dfb144 100644
--- a/Documentation/frv/booting.txt
+++ b/Documentation/frv/booting.txt
@@ -119,7 +119,7 @@ separated by spaces:
 	253:0		Device with major 253 and minor 0
=20
       Authoritative information can be found in
-      "Documentation/kernel-parameters.txt".
+      "Documentation/admin-guide/kernel-parameters.rst".
=20
   (*) rw
=20
diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/s=
ubmitting-patches
index 57f60307accc..f88221b46153 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches
@@ -10,10 +10,10 @@ increase the chances of your change being accepted.
 ----------
=20
 * It should be unnecessary to mention, but please read and follow
-    Documentation/SubmitChecklist
-    Documentation/SubmittingDrivers
-    Documentation/SubmittingPatches
-    Documentation/CodingStyle
+    Documentation/process/submit-checklist.rst
+    Documentation/process/submitting-drivers.rst
+    Documentation/process/submitting-patches.rst
+    Documentation/process/coding-style.rst
=20
 * Please run your patch through 'checkpatch --strict'. There should be no
   errors, no warnings, and few if any check messages. If there are any
diff --git a/Documentation/isdn/README b/Documentation/isdn/README
index cfb1884342ee..32d4e80c2c03 100644
--- a/Documentation/isdn/README
+++ b/Documentation/isdn/README
@@ -332,7 +332,7 @@ README for the ISDN-subsystem
 4. Device-inodes
=20
    The major and minor numbers and their names are described in
-   Documentation/devices.txt. The major numbers are:
+   Documentation/admin-guide/devices.rst. The major numbers are:
=20
      43 for the ISDN-tty's.
      44 for the ISDN-callout-tty's.
diff --git a/Documentation/ja_JP/HOWTO b/Documentation/ja_JP/HOWTO
index 581c14bdd7be..b03fc8047f03 100644
--- a/Documentation/ja_JP/HOWTO
+++ b/Documentation/ja_JP/HOWTO
@@ -127,15 +127,15 @@ linux-api@ver.kernel.org =E3=81=AB=E9=80=81=E3=82=8B=
=E3=81=93=E3=81=A8=E3=82=92=E5=8B=A7=E3=82=81=E3=81=BE=E3=81=99=E3=80=82
      =E5=B0=8F=E9=99=90=E3=81=AE=E3=83=AC=E3=83=99=E3=83=AB=E3=81=A7=E5=BF=
=85=E8=A6=81=E3=81=AA=E6=95=B0=E3=80=85=E3=81=AE=E3=82=BD=E3=83=95=E3=83=88=
=E3=82=A6=E3=82=A7=E3=82=A2=E3=83=91=E3=83=83=E3=82=B1=E3=83=BC=E3=82=B8=E3=
=81=AE=E4=B8=80=E8=A6=A7=E3=82=92=E7=A4=BA=E3=81=97=E3=81=A6=E3=81=84
      =E3=81=BE=E3=81=99=E3=80=82
=20
-  Documentation/CodingStyle
+  Documentation/process/coding-style.rst
     =E3=81=93=E3=82=8C=E3=81=AF Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=
=E3=81=AE=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0=E3=82=B9=E3=
=82=BF=E3=82=A4=E3=83=AB=E3=81=A8=E8=83=8C=E6=99=AF=E3=81=AB=E3=81=82=E3=82=
=8B=E7=90=86=E7=94=B1=E3=82=92=E8=A8=98=E8=BF=B0
     =E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82=E5=85=A8=E3=81=
=A6=E3=81=AE=E6=96=B0=E3=81=97=E3=81=84=E3=82=B3=E3=83=BC=E3=83=89=E3=81=AF=
=E3=81=93=E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=
=81=AB=E3=81=82=E3=82=8B=E3=82=AC=E3=82=A4=E3=83=89=E3=83=A9=E3=82=A4=E3=83=
=B3
     =E3=81=AB=E5=BE=93=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E3=81=93=E3=81=
=A8=E3=82=92=E6=9C=9F=E5=BE=85=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E3=80=82=E5=A4=A7=E9=83=A8=E5=88=86=E3=81=AE=E3=83=A1=E3=83=B3=E3=
=83=86=E3=83=8A=E3=81=AF=E3=81=93=E3=82=8C=E3=82=89=E3=81=AE=E3=83=AB=E3=83=
=BC
     =E3=83=AB=E3=81=AB=E5=BE=93=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E3=82=
=82=E3=81=AE=E3=81=A0=E3=81=91=E3=82=92=E5=8F=97=E3=81=91=E4=BB=98=E3=81=91=
=E3=80=81=E5=A4=9A=E3=81=8F=E3=81=AE=E4=BA=BA=E3=81=AF=E6=AD=A3=E3=81=97=E3=
=81=84=E3=82=B9=E3=82=BF=E3=82=A4=E3=83=AB=E3=81=AE=E3=82=B3=E3=83=BC=E3=83=
=89
     =E3=81=A0=E3=81=91=E3=82=92=E3=83=AC=E3=83=93=E3=83=A5=E3=83=BC=E3=81=
=97=E3=81=BE=E3=81=99=E3=80=82
=20
-  Documentation/SubmittingPatches
-  Documentation/SubmittingDrivers
+  Documentation/process/submitting-patches.rst
+  Documentation/process/submitting-drivers.rst
      =E3=81=93=E3=82=8C=E3=82=89=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=
=AB=E3=81=AB=E3=81=AF=E3=80=81=E3=81=A9=E3=81=86=E3=82=84=E3=81=A3=E3=81=A6=
=E3=81=86=E3=81=BE=E3=81=8F=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E4=BD=9C=E3=
=81=A3=E3=81=A6=E6=8A=95=E7=A8=BF=E3=81=99=E3=82=8B=E3=81=8B=E3=81=AB
      =E3=81=A4=E3=81=84=E3=81=A6=E9=9D=9E=E5=B8=B8=E3=81=AB=E8=A9=B3=E3=81=
=97=E3=81=8F=E6=9B=B8=E3=81=8B=E3=82=8C=E3=81=A6=E3=81=8A=E3=82=8A=E3=80=81=
=E4=BB=A5=E4=B8=8B=E3=82=92=E5=90=AB=E3=81=BF=E3=81=BE=E3=81=99(=E3=81=93=
=E3=82=8C=E3=81=A0=E3=81=91=E3=81=AB=E9=99=90=E3=82=89=E3=81=AA=E3=81=84
      =E3=81=91=E3=82=8C=E3=81=A9=E3=82=82)
@@ -153,7 +153,7 @@ linux-api@ver.kernel.org =E3=81=AB=E9=80=81=E3=82=8B=E3=
=81=93=E3=81=A8=E3=82=92=E5=8B=A7=E3=82=81=E3=81=BE=E3=81=99=E3=80=82
 	"Linux kernel patch submission format"
 		http://linux.yyz.us/patch-format.html
=20
-  Documentation/stable_api_nonsense.txt
+  Documentation/process/stable-api-nonsense.rst
      =E3=81=93=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AF=E3=82=
=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AE=E4=B8=AD=E3=81=AB=E4=B8=8D=E5=A4=89=
=E3=81=AEAPI=E3=82=92=E6=8C=81=E3=81=9F=E3=81=AA=E3=81=84=E3=81=93=E3=81=A8=
=E3=81=AB=E3=81=97=E3=81=9F=E6=84=8F=E8=AD=98=E7=9A=84=E3=81=AA
      =E6=B1=BA=E6=96=AD=E3=81=AE=E8=83=8C=E6=99=AF=E3=81=AB=E3=81=82=E3=82=
=8B=E7=90=86=E7=94=B1=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=E6=9B=B8=E3=81=8B=
=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82=E4=BB=A5=E4=B8=8B=E3=
=81=AE=E3=82=88=E3=81=86=E3=81=AA=E3=81=93=E3=81=A8=E3=82=92=E5=90=AB
      =E3=82=93=E3=81=A7=E3=81=84=E3=81=BE=E3=81=99-
@@ -164,29 +164,29 @@ linux-api@ver.kernel.org =E3=81=AB=E9=80=81=E3=82=8B=
=E3=81=93=E3=81=A8=E3=82=92=E5=8B=A7=E3=82=81=E3=81=BE=E3=81=99=E3=80=82
      =E3=81=93=E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=
=88=E3=81=AF Linux =E9=96=8B=E7=99=BA=E3=81=AE=E6=80=9D=E6=83=B3=E3=82=92=
=E7=90=86=E8=A7=A3=E3=81=99=E3=82=8B=E3=81=AE=E3=81=AB=E9=9D=9E=E5=B8=B8=E3=
=81=AB=E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82
      =E3=81=9D=E3=81=97=E3=81=A6=E3=80=81=E4=BB=96=E3=81=AEOS=E3=81=A7=E3=
=81=AE=E9=96=8B=E7=99=BA=E8=80=85=E3=81=8C Linux =E3=81=AB=E7=A7=BB=E3=82=
=8B=E6=99=82=E3=81=AB=E3=81=A8=E3=81=A6=E3=82=82=E9=87=8D=E8=A6=81=E3=81=A7=
=E3=81=99=E3=80=82
=20
-  Documentation/SecurityBugs
+  Documentation/admin-guide/security-bugs.rst
     =E3=82=82=E3=81=97 Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=A7=
=E3=82=BB=E3=82=AD=E3=83=A5=E3=83=AA=E3=83=86=E3=82=A3=E5=95=8F=E9=A1=8C=E3=
=82=92=E7=99=BA=E8=A6=8B=E3=81=97=E3=81=9F=E3=82=88=E3=81=86=E3=81=AB=E6=80=
=9D=E3=81=A3=E3=81=9F=E3=82=89=E3=80=81=E3=81=93
     =E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=81=
=AE=E3=82=B9=E3=83=86=E3=83=83=E3=83=97=E3=81=AB=E5=BE=93=E3=81=A3=E3=81=A6=
=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=BA=E8=80=85=E3=81=AB=E9=
=80=A3=E7=B5=A1=E3=81=97=E3=80=81=E5=95=8F=E9=A1=8C=E8=A7=A3=E6=B1=BA=E3=82=
=92
     =E6=94=AF=E6=8F=B4=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=
=84=E3=80=82
=20
-  Documentation/ManagementStyle
+  Documentation/process/management-style.rst
     =E3=81=93=E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=
=88=E3=81=AF Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AE=E3=83=A1=
=E3=83=B3=E3=83=86=E3=83=8A=E9=81=94=E3=81=8C=E3=81=A9=E3=81=86=E8=A1=8C=E5=
=8B=95=E3=81=99=E3=82=8B=E3=81=8B=E3=80=81
     =E5=BD=BC=E3=82=89=E3=81=AE=E6=89=8B=E6=B3=95=E3=81=AE=E8=83=8C=E6=99=
=AF=E3=81=AB=E3=81=82=E3=82=8B=E5=85=B1=E6=9C=89=E3=81=95=E3=82=8C=E3=81=A6=
=E3=81=84=E3=82=8B=E7=B2=BE=E7=A5=9E=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=E8=
=A8=98=E8=BF=B0=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82=E3=81=
=93
     =E3=82=8C=E3=81=AF=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=
=BA=E3=81=AE=E5=88=9D=E5=BF=83=E8=80=85=E3=81=AA=E3=82=89=EF=BC=88=E3=82=82=
=E3=81=97=E3=81=8F=E3=81=AF=E3=80=81=E5=8D=98=E3=81=AB=E8=88=88=E5=91=B3=E3=
=81=8C=E3=81=82=E3=82=8B=E3=81=A0=E3=81=91=E3=81=AE=E4=BA=BA=E3=81=A7=E3=82=
=82=EF=BC=89
     =E9=87=8D=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82=E3=81=AA=E3=81=9C=E3=81=
=AA=E3=82=89=E3=81=93=E3=81=AE=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=
=E3=83=88=E3=81=AF=E3=80=81=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=A1=E3=
=83=B3=E3=83=86=E3=83=8A=E9=81=94=E3=81=AE=E7=8B=AC=E7=89=B9=E3=81=AA
     =E8=A1=8C=E5=8B=95=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=E3=81=AE=E5=A4=
=9A=E3=81=8F=E3=81=AE=E8=AA=A4=E8=A7=A3=E3=82=84=E6=B7=B7=E4=B9=B1=E3=82=92=
=E8=A7=A3=E6=B6=88=E3=81=99=E3=82=8B=E3=81=8B=E3=82=89=E3=81=A7=E3=81=99=E3=
=80=82
=20
-  Documentation/stable_kernel_rules.txt
+  Documentation/process/stable-kernel-rules.rst
     =E3=81=93=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AF=E3=81=
=A9=E3=81=AE=E3=82=88=E3=81=86=E3=81=AB stable =E3=82=AB=E3=83=BC=E3=83=8D=
=E3=83=AB=E3=81=AE=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=81=8C=E8=A1=8C=E3=
=82=8F=E3=82=8C=E3=82=8B=E3=81=8B=E3=81=AE=E3=83=AB=E3=83=BC
     =E3=83=AB=E3=81=8C=E8=A8=98=E8=BF=B0=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99=E3=80=82=E3=81=9D=E3=81=97=E3=81=A6=E3=81=93=E3=82=8C=
=E3=82=89=E3=81=AE=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=B9=E3=81=AE=E4=B8=AD=E3=
=81=AE=E3=81=A9=E3=81=93=E3=81=8B=E3=81=A7=E5=A4=89=E6=9B=B4=E3=82=92=E5=8F=
=96
     =E3=82=8A=E5=85=A5=E3=82=8C=E3=81=A6=E3=82=82=E3=82=89=E3=81=84=E3=81=
=9F=E3=81=84=E5=A0=B4=E5=90=88=E3=81=AB=E4=BD=95=E3=82=92=E3=81=99=E3=82=8C=
=E3=81=B0=E8=89=AF=E3=81=84=E3=81=8B=E3=81=8C=E7=A4=BA=E3=81=95=E3=82=8C=E3=
=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82
=20
-  Documentation/kernel-docs.txt
+  Documentation/process/kernel-docs.rst
 =E3=80=80=E3=80=80=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=BA=
=E3=81=AB=E4=BB=98=E9=9A=8F=E3=81=99=E3=82=8B=E5=A4=96=E9=83=A8=E3=83=89=E3=
=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=81=AE=E3=83=AA=E3=82=B9=E3=83=
=88=E3=81=A7=E3=81=99=E3=80=82=E3=82=82=E3=81=97=E3=81=82=E3=81=AA=E3=81=9F=
=E3=81=8C
     =E6=8E=A2=E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=82=82=E3=81=AE=E3=81=
=8C=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E5=86=85=E3=81=AE=E3=83=89=E3=82=AD=
=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=81=A7=E3=81=BF=E3=81=A4=E3=81=8B=E3=
=82=89=E3=81=AA=E3=81=8B=E3=81=A3=E3=81=9F=E5=A0=B4=E5=90=88=E3=80=81
     =E3=81=93=E3=81=AE=E3=83=AA=E3=82=B9=E3=83=88=E3=82=92=E3=81=82=E3=81=
=9F=E3=81=A3=E3=81=A6=E3=81=BF=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=
=E3=80=82
=20
-  Documentation/applying-patches.txt
+  Documentation/process/applying-patches.rst
     =E3=83=91=E3=83=83=E3=83=81=E3=81=A8=E3=81=AF=E3=81=AA=E3=81=AB=E3=81=
=8B=E3=80=81=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=81=A9=E3=81=86=E3=82=84=
=E3=81=A3=E3=81=A6=E6=A7=98=E3=80=85=E3=81=AA=E3=82=AB=E3=83=BC=E3=83=8D=E3=
=83=AB=E3=81=AE=E9=96=8B=E7=99=BA=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=
=AB
     =E9=81=A9=E7=94=A8=E3=81=99=E3=82=8B=E3=81=AE=E3=81=8B=E3=81=AB=E3=81=
=A4=E3=81=84=E3=81=A6=E6=AD=A3=E7=A2=BA=E3=81=AB=E8=A8=98=E8=BF=B0=E3=81=97=
=E3=81=9F=E8=89=AF=E3=81=84=E5=85=A5=E9=96=80=E6=9B=B8=E3=81=A7=E3=81=99=E3=
=80=82
=20
@@ -314,7 +314,7 @@ Andrew Morton =E3=81=8C Linux-kernel =E3=83=A1=E3=83=BC=
=E3=83=AA=E3=83=B3=E3=82=B0=E3=83=AA=E3=82=B9=E3=83=88=E3=81=AB=E3=82=AB=E3=
=83=BC=E3=83=8D=E3=83=AB=E3=83=AA=E3=83=AA=E3=83=BC
 =E3=81=9F=E5=95=8F=E9=A1=8C=E3=81=8C=E3=81=AA=E3=81=91=E3=82=8C=E3=81=B0=
=E3=82=82=E3=81=86=E5=B0=91=E3=81=97=E9=95=B7=E3=81=8F=E3=81=AA=E3=82=8B=E3=
=81=93=E3=81=A8=E3=82=82=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=E3=82=
=BB=E3=82=AD=E3=83=A5=E3=83=AA=E3=83=86=E3=82=A3=E9=96=A2=E9=80=A3=E3=81=AE=
=E5=95=8F=E9=A1=8C
 =E3=81=AE=E5=A0=B4=E5=90=88=E3=81=AF=E3=81=93=E3=82=8C=E3=81=AB=E5=AF=BE=
=E3=81=97=E3=81=A6=E3=81=A0=E3=81=84=E3=81=9F=E3=81=84=E3=81=AE=E5=A0=B4=E5=
=90=88=E3=80=81=E3=81=99=E3=81=90=E3=81=AB=E3=83=AA=E3=83=AA=E3=83=BC=E3=82=
=B9=E3=81=8C=E3=81=95=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82
=20
-=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=84=E3=83=AA=E3=83=BC=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E3=80=81Documentation/stable_=
kernel_rules.txt =E3=83=95=E3=82=A1
+=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=84=E3=83=AA=E3=83=BC=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E3=80=81Documentation/process=
/stable-kernel-rules.rst =E3=83=95=E3=82=A1
 =E3=82=A4=E3=83=AB=E3=81=AB=E3=81=AF=E3=81=A9=E3=81=AE=E3=82=88=E3=81=86=
=E3=81=AA=E7=A8=AE=E9=A1=9E=E3=81=AE=E5=A4=89=E6=9B=B4=E3=81=8C -stable =E3=
=83=84=E3=83=AA=E3=83=BC=E3=81=AB=E5=8F=97=E3=81=91=E5=85=A5=E3=82=8C=E5=8F=
=AF=E8=83=BD=E3=81=8B=E3=80=81=E3=81=BE=E3=81=9F=E3=83=AA
 =E3=83=AA=E3=83=BC=E3=82=B9=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=8C=
=E3=81=A9=E3=81=86=E5=8B=95=E3=81=8F=E3=81=8B=E3=81=8C=E8=A8=98=E8=BF=B0=E3=
=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E3=80=82
=20
@@ -372,7 +372,7 @@ bugzilla.kernel.org =E3=81=AF Linux =E3=82=AB=E3=83=BC=
=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=BA=E8=80=85=E3=81=8C=E3=82=AB=E3=83=BC=E3=
=83=8D=E3=83=AB=E3=81=AE=E3=83=90=E3=82=B0=E3=82=92
 =E5=A0=B4=E6=89=80=E3=81=A7=E3=81=99=E3=80=82=E3=83=A6=E3=83=BC=E3=82=B6=
=E3=81=AF=E8=A6=8B=E3=81=A4=E3=81=91=E3=81=9F=E3=83=90=E3=82=B0=E3=81=AE=E5=
=85=A8=E3=81=A6=E3=82=92=E3=81=93=E3=81=AE=E3=83=84=E3=83=BC=E3=83=AB=E3=81=
=A7=E5=A0=B1=E5=91=8A=E3=81=99=E3=81=B9=E3=81=8D=E3=81=A7=E3=81=99=E3=80=82
 =E3=81=A9=E3=81=86 kernel bugzilla =E3=82=92=E4=BD=BF=E3=81=86=E3=81=8B=E3=
=81=AE=E8=A9=B3=E7=B4=B0=E3=81=AF=E3=80=81=E4=BB=A5=E4=B8=8B=E3=82=92=E5=8F=
=82=E7=85=A7=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84-
 	http://bugzilla.kernel.org/page.cgi?id=3Dfaq.html
-=E3=83=A1=E3=82=A4=E3=83=B3=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=82=BD=
=E3=83=BC=E3=82=B9=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=
=81=AB=E3=81=82=E3=82=8B=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB REPORTING-BUGS=
 =E3=81=AF=E3=82=AB=E3=83=BC=E3=83=8D
+=E3=83=A1=E3=82=A4=E3=83=B3=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=82=BD=
=E3=83=BC=E3=82=B9=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=
=81=AB=E3=81=82=E3=82=8B=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB admin-guide/re=
porting-bugs.rst =E3=81=AF=E3=82=AB=E3=83=BC=E3=83=8D
 =E3=83=AB=E3=83=90=E3=82=B0=E3=82=89=E3=81=97=E3=81=84=E3=82=82=E3=81=AE=
=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=E3=81=A9=E3=81=86=E3=83=AC=E3=83=9D=E3=
=83=BC=E3=83=88=E3=81=99=E3=82=8B=E3=81=8B=E3=81=AE=E8=89=AF=E3=81=84=E3=83=
=86=E3=83=B3=E3=83=97=E3=83=AC=E3=83=BC=E3=83=88=E3=81=A7=E3=81=82=E3=82=8A=
=E3=80=81=E5=95=8F
 =E9=A1=8C=E3=81=AE=E8=BF=BD=E8=B7=A1=E3=82=92=E5=8A=A9=E3=81=91=E3=82=8B=
=E3=81=9F=E3=82=81=E3=81=AB=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=
=99=BA=E8=80=85=E3=81=AB=E3=81=A8=E3=81=A3=E3=81=A6=E3=81=A9=E3=82=93=E3=81=
=AA=E6=83=85=E5=A0=B1=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=AA=E3=81=AE=E3=81=8B=
=E3=81=AE=E8=A9=B3
 =E7=B4=B0=E3=81=8C=E6=9B=B8=E3=81=8B=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E3=80=82
@@ -438,7 +438,7 @@ MAINTAINERS =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=
=AB=E3=83=AA=E3=82=B9=E3=83=88=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=
=E3=81=AE=E3=81=A7=E5=8F=82=E7=85=A7=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=
=81=95
 =E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AE=E5=85=88=E9=A0=AD=E3=81=A7=E3=81=AA=
=E3=81=8F=E3=80=81=E5=90=84=E5=BC=95=E7=94=A8=E8=A1=8C=E3=81=AE=E9=96=93=E3=
=81=AB=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E8=A8=80=E3=81=84=E3=81=9F=E3=81=
=84=E3=81=93=E3=81=A8=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=99=E3=82=8B=E3=81=B9=
=E3=81=8D=E3=81=A7
 =E3=81=99=E3=80=82
=20
-=E3=82=82=E3=81=97=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=83=A1=E3=83=BC=
=E3=83=AB=E3=81=AB=E4=BB=98=E3=81=91=E3=82=8B=E5=A0=B4=E5=90=88=E3=81=AF=E3=
=80=81Documentation/SubmittingPatches =E3=81=AB=E6=8F=90
+=E3=82=82=E3=81=97=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=83=A1=E3=83=BC=
=E3=83=AB=E3=81=AB=E4=BB=98=E3=81=91=E3=82=8B=E5=A0=B4=E5=90=88=E3=81=AF=E3=
=80=81Documentation/process/submitting-patches.rst =E3=81=AB=E6=8F=90
 =E7=A4=BA=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B=E3=82=88=E3=81=86=
=E3=81=AB=E3=80=81=E3=81=9D=E3=82=8C=E3=81=AF =E3=83=97=E3=83=AC=E3=83=BC=
=E3=83=B3=E3=81=AA=E5=8F=AF=E8=AA=AD=E3=83=86=E3=82=AD=E3=82=B9=E3=83=88=E3=
=81=AB=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=E3=82=92=E5=BF=98=E3=82=8C=E3=81=
=AA=E3=81=84
 =E3=82=88=E3=81=86=E3=81=AB=E3=81=97=E3=81=BE=E3=81=97=E3=82=87=E3=81=86=
=E3=80=82=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E9=96=8B=E7=99=BA=E8=80=85=E3=
=81=AF =E6=B7=BB=E4=BB=98=E3=82=84=E5=9C=A7=E7=B8=AE=E3=81=97=E3=81=9F=E3=
=83=91=E3=83=83=E3=83=81=E3=82=92=E6=89=B1=E3=81=84=E3=81=9F=E3=81=8C=E3=82=
=8A=E3=81=BE
 =E3=81=9B=E3=82=93-
diff --git a/Documentation/ja_JP/SubmitChecklist b/Documentation/ja_JP/Subm=
itChecklist
index cb5507b1ac81..60c7c35ac517 100644
--- a/Documentation/ja_JP/SubmitChecklist
+++ b/Documentation/ja_JP/SubmitChecklist
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/SubmitChecklist into Japanese.
+This is a version of Documentation/process/submit-checklist.rst into Japan=
ese.
 This document is maintained by Takenori Nagano <t-nagano@ah.jp.nec.com>
 and the JF Project team <http://www.linux.or.jp/JF/>.
 If you find any difference between this document and the original file
@@ -14,7 +14,7 @@ to update the original English file first.
 Last Updated: 2008/07/14
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
-linux-2.6.26/Documentation/SubmitChecklist =E3=81=AE=E5=92=8C=E8=A8=B3=E3=
=81=A7=E3=81=99=E3=80=82
+linux-2.6.26/Documentation/process/submit-checklist.rst =E3=81=AE=E5=92=8C=
=E8=A8=B3=E3=81=A7=E3=81=99=E3=80=82
=20
 =E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=E3=82=
=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
 =E7=BF=BB=E8=A8=B3=E6=97=A5=EF=BC=9A 2008/07/14
@@ -27,7 +27,7 @@ Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=91=E3=83=
=83=E3=83=81=E6=8A=95=E7=A8=BF=E8=80=85=E5=90=91=E3=81=91=E3=83=81=E3=82=A7=
=E3=83=83=E3=82=AF=E3=83=AA=E3=82=B9=E3=83=88
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 =E6=9C=AC=E6=9B=B8=E3=81=A7=E3=81=AF=E3=80=81=E3=83=91=E3=83=83=E3=83=81=
=E3=82=92=E3=82=88=E3=82=8A=E7=B4=A0=E6=97=A9=E3=81=8F=E5=8F=96=E3=82=8A=E8=
=BE=BC=E3=82=93=E3=81=A7=E3=82=82=E3=82=89=E3=81=84=E3=81=9F=E3=81=84=E9=96=
=8B=E7=99=BA=E8=80=85=E3=81=8C=E5=AE=9F=E8=B7=B5=E3=81=99=E3=81=B9=E3=81=8D=
=E5=9F=BA=E6=9C=AC=E7=9A=84=E3=81=AA=E4=BA=8B=E6=9F=84
-=E3=82=92=E3=81=84=E3=81=8F=E3=81=A4=E3=81=8B=E7=B4=B9=E4=BB=8B=E3=81=97=
=E3=81=BE=E3=81=99=E3=80=82=E3=81=93=E3=81=93=E3=81=AB=E3=81=82=E3=82=8B=E5=
=85=A8=E3=81=A6=E3=81=AE=E4=BA=8B=E6=9F=84=E3=81=AF=E3=80=81Documentation/S=
ubmittingPatches
+=E3=82=92=E3=81=84=E3=81=8F=E3=81=A4=E3=81=8B=E7=B4=B9=E4=BB=8B=E3=81=97=
=E3=81=BE=E3=81=99=E3=80=82=E3=81=93=E3=81=93=E3=81=AB=E3=81=82=E3=82=8B=E5=
=85=A8=E3=81=A6=E3=81=AE=E4=BA=8B=E6=9F=84=E3=81=AF=E3=80=81Documentation/p=
rocess/submitting-patches.rst
 =E3=81=AA=E3=81=A9=E3=81=AELinux=E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=
=91=E3=83=83=E3=83=81=E6=8A=95=E7=A8=BF=E3=81=AB=E9=9A=9B=E3=81=97=E3=81=A6=
=E3=81=AE=E5=BF=83=E5=BE=97=E3=82=92=E8=A3=9C=E8=B6=B3=E3=81=99=E3=82=8B=E3=
=82=82=E3=81=AE=E3=81=A7=E3=81=99=E3=80=82
=20
  1: =E5=A6=A5=E5=BD=93=E3=81=AACONFIG=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=84=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9FCONFIG=E3=82=
=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E3=80=81=E3=81=A4=E3=81=BE=E3=82=8A=
 =3Dy, =3Dm, =3Dn
@@ -84,7 +84,7 @@ Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=83=91=E3=83=
=83=E3=83=81=E6=8A=95=E7=A8=BF=E8=80=85=E5=90=91=E3=81=91=E3=83=81=E3=82=A7=
=E3=83=83=E3=82=AF=E3=83=AA=E3=82=B9=E3=83=88
     =E5=BF=85=E3=81=9A=E3=83=89=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=
=88=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=
=E3=81=84=E3=80=82
=20
 17: =E6=96=B0=E3=81=97=E3=81=84=E3=83=96=E3=83=BC=E3=83=88=E3=83=91=E3=83=
=A9=E3=83=A1=E3=83=BC=E3=82=BF=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=9F=
=E5=A0=B4=E5=90=88=E3=81=AB=E3=81=AF=E3=80=81
-    =E5=BF=85=E3=81=9ADocumentation/kernel-parameters.txt =E3=81=AB=E8=AA=
=AC=E6=98=8E=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=
=E3=81=95=E3=81=84=E3=80=82
+    =E5=BF=85=E3=81=9ADocumentation/admin-guide/kernel-parameters.rst =E3=
=81=AB=E8=AA=AC=E6=98=8E=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=A6=E3=81=
=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
=20
 18: =E6=96=B0=E3=81=97=E3=81=8Fmodule=E3=81=AB=E3=83=91=E3=83=A9=E3=83=A1=
=E3=83=BC=E3=82=BF=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=97=E3=81=9F=E5=A0=B4=E5=
=90=88=E3=81=AB=E3=81=AF=E3=80=81MODULE_PARM_DESC()=E3=82=92
     =E5=88=A9=E7=94=A8=E3=81=97=E3=81=A6=E5=BF=85=E3=81=9A=E3=81=9D=E3=81=
=AE=E8=AA=AC=E6=98=8E=E3=82=92=E8=A8=98=E8=BF=B0=E3=81=97=E3=81=A6=E3=81=8F=
=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
diff --git a/Documentation/ja_JP/SubmittingPatches b/Documentation/ja_JP/Su=
bmittingPatches
index 5d6ae639bfa0..02139656463e 100644
--- a/Documentation/ja_JP/SubmittingPatches
+++ b/Documentation/ja_JP/SubmittingPatches
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/SubmittingPatches into Japanese.
+This is a version of Documentation/process/submitting-patches.rst into Jap=
anese.
 This document is maintained by Keiichi KII <k-keiichi@bx.jp.nec.com>
 and the JF Project team <http://www.linux.or.jp/JF/>.
 If you find any difference between this document and the original file
@@ -15,7 +15,7 @@ Last Updated: 2011/06/09
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
-linux-2.6.39/Documentation/SubmittingPatches =E3=81=AE=E5=92=8C=E8=A8=B3
+linux-2.6.39/Documentation/process/submitting-patches.rst =E3=81=AE=E5=92=
=8C=E8=A8=B3
 =E3=81=A7=E3=81=99=E3=80=82
 =E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=E3=82=
=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
 =E7=BF=BB=E8=A8=B3=E6=97=A5=EF=BC=9A 2011/06/09
@@ -34,9 +34,9 @@ Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=83=AB=E3=81=AB=E5=A4=
=89=E6=9B=B4=E3=82=92=E5=8A=A0=E3=81=88=E3=81=9F=E3=81=84=E3=81=A8=E6=80=9D=
=E3=81=A3=E3=81=A6=E3=81=84=E3=82=8B=E5=80=8B=E4=BA=BA=E5=8F=88=E3=81=AF=E4=
=BC=9A=E7=A4=BE
 =E3=81=8A=E3=81=98=E3=81=91=E3=81=A5=E3=81=8B=E3=81=9B=E3=82=8B=E3=81=93=
=E3=81=A8=E3=82=82=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=E3=81=93=E3=
=81=AE=E6=96=87=E7=AB=A0=E3=81=AF=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E5=A4=
=89=E6=9B=B4=E3=82=92=E5=A4=A7=E3=81=84=E3=81=AB=E5=8F=97=E3=81=91=E5=85=A5=
=E3=82=8C
 =E3=81=A6=E3=82=82=E3=82=89=E3=81=88=E3=82=84=E3=81=99=E3=81=8F=E3=81=99=
=E3=82=8B=E6=8F=90=E6=A1=88=E3=82=92=E9=9B=86=E3=82=81=E3=81=9F=E3=82=82=E3=
=81=AE=E3=81=A7=E3=81=99=E3=80=82
=20
-=E3=82=B3=E3=83=BC=E3=83=89=E3=82=92=E6=8A=95=E7=A8=BF=E3=81=99=E3=82=8B=
=E5=89=8D=E3=81=AB=E3=80=81Documentation/SubmitChecklist =E3=81=AE=E9=A0=85=
=E7=9B=AE=E3=83=AA=E3=82=B9=E3=83=88=E3=81=AB=E7=9B=AE
+=E3=82=B3=E3=83=BC=E3=83=89=E3=82=92=E6=8A=95=E7=A8=BF=E3=81=99=E3=82=8B=
=E5=89=8D=E3=81=AB=E3=80=81Documentation/process/submit-checklist.rst =E3=
=81=AE=E9=A0=85=E7=9B=AE=E3=83=AA=E3=82=B9=E3=83=88=E3=81=AB=E7=9B=AE
 =E3=82=92=E9=80=9A=E3=81=97=E3=81=A6=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82=E3=82=82=E3=
=81=97=E3=81=82=E3=81=AA=E3=81=9F=E3=81=8C=E3=83=89=E3=83=A9=E3=82=A4=E3=83=
=90=E3=83=BC=E3=82=92=E6=8A=95=E7=A8=BF=E3=81=97=E3=82=88=E3=81=86=E3=81=A8=
=E3=81=97
-=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AA=E3=82=89=E3=80=81Documentation/Submit=
tingDrivers =E3=81=AB=E3=82=82=E7=9B=AE=E3=82=92=E9=80=9A=E3=81=97=E3=81=A6=
=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
+=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AA=E3=82=89=E3=80=81Documentation/proces=
s/submitting-drivers.rst =E3=81=AB=E3=82=82=E7=9B=AE=E3=82=92=E9=80=9A=E3=
=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
=20
 --------------------------------------------
 =E3=82=BB=E3=82=AF=E3=82=B7=E3=83=A7=E3=83=B31 =E3=83=91=E3=83=83=E3=83=81=
=E3=81=AE=E4=BD=9C=E3=82=8A=E6=96=B9=E3=81=A8=E9=80=81=E3=82=8A=E6=96=B9
@@ -148,7 +148,7 @@ http://savannah.nongnu.org/projects/quilt
 4) =E3=83=91=E3=83=83=E3=83=81=E3=81=AE=E3=82=B9=E3=82=BF=E3=82=A4=E3=83=
=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF
=20
 =E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=81=8C=
=E5=9F=BA=E6=9C=AC=E7=9A=84=E3=81=AA( Linux =E3=82=AB=E3=83=BC=E3=83=8D=E3=
=83=AB=E3=81=AE)=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0=E3=
=82=B9=E3=82=BF=E3=82=A4=E3=83=AB=E3=81=AB=E9=81=95=E5=8F=8D=E3=81=97
-=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E3=81=8B=E3=82=92=E3=83=81=E3=82=A7=
=E3=83=83=E3=82=AF=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82=E3=
=81=9D=E3=81=AE=E8=A9=B3=E7=B4=B0=E3=82=92 Documentation/CodingStyle =E3=81=
=A7
+=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E3=81=8B=E3=82=92=E3=83=81=E3=82=A7=
=E3=83=83=E3=82=AF=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82=E3=
=81=9D=E3=81=AE=E8=A9=B3=E7=B4=B0=E3=82=92 Documentation/process/coding-sty=
le.rst =E3=81=A7
 =E8=A6=8B=E3=81=A4=E3=81=91=E3=82=8B=E3=81=93=E3=81=A8=E3=81=8C=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=99=E3=80=82=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=
=83=B3=E3=82=B0=E3=82=B9=E3=82=BF=E3=82=A4=E3=83=AB=E3=81=AE=E9=81=95=E5=8F=
=8D=E3=81=AF=E3=83=AC=E3=83=93=E3=83=A5=E3=83=BC=E3=81=99=E3=82=8B=E4=BA=BA=
=E3=81=AE
 =E6=99=82=E9=96=93=E3=82=92=E7=84=A1=E9=A7=84=E3=81=AB=E3=81=99=E3=82=8B=
=E3=81=A0=E3=81=91=E3=81=AA=E3=81=AE=E3=81=A7=E3=80=81=E6=81=90=E3=82=89=E3=
=81=8F=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=81=
=AF=E8=AA=AD=E3=81=BE=E3=82=8C=E3=82=8B=E3=81=93=E3=81=A8=E3=81=99=E3=82=89=
=E3=81=AA=E3=81=8F
 =E6=8B=92=E5=90=A6=E3=81=95=E3=82=8C=E3=82=8B=E3=81=A7=E3=81=97=E3=82=87=
=E3=81=86=E3=80=82
@@ -246,7 +246,7 @@ MIME =E5=BD=A2=E5=BC=8F=E3=81=AE=E6=B7=BB=E4=BB=98=E3=
=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AF Linus =E3=81=AB=E6=89=8B=E9=96=
=93=E3=82=92=E5=8F=96=E3=82=89=E3=81=9B=E3=82=8B=E3=81=93=E3=81=A8=E3=81=AB=
=E3=81=AA
 =E3=81=82=E3=82=8C=E3=81=B0=E3=80=81=E8=AA=B0=E3=81=8B=E3=81=8C MIME =E5=
=BD=A2=E5=BC=8F=E3=81=AE=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E5=86=8D=E9=80=
=81=E3=81=99=E3=82=8B=E3=82=88=E3=81=86=E6=B1=82=E3=82=81=E3=82=8B=E3=81=8B=
=E3=82=82=E3=81=97=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82
=20
 =E4=BD=99=E8=A8=88=E3=81=AA=E5=A4=89=E6=9B=B4=E3=82=92=E5=8A=A0=E3=81=88=
=E3=81=9A=E3=81=AB=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E3=83=91=E3=83=83=E3=
=83=81=E3=82=92=E9=80=81=E4=BF=A1=E3=81=99=E3=82=8B=E3=81=9F=E3=82=81=E3=81=
=AE=E9=9B=BB=E5=AD=90=E3=83=A1=E3=83=BC=E3=83=AB=E3=82=AF=E3=83=A9=E3=82=A4=
=E3=82=A2=E3=83=B3=E3=83=88=E3=81=AE=E8=A8=AD=E5=AE=9A
-=E3=81=AE=E3=83=92=E3=83=B3=E3=83=88=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=
=E3=81=AF Documentation/email-clients.txt =E3=82=92=E5=8F=82=E7=85=A7=E3=81=
=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
+=E3=81=AE=E3=83=92=E3=83=B3=E3=83=88=E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6=
=E3=81=AF Documentation/process/email-clients.rst =E3=82=92=E5=8F=82=E7=85=
=A7=E3=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82
=20
 8) =E9=9B=BB=E5=AD=90=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AE=E3=82=B5=E3=82=
=A4=E3=82=BA
=20
@@ -609,7 +609,7 @@ diffstat =E3=81=AE=E7=B5=90=E6=9E=9C=E3=82=92=E7=94=9F=
=E6=88=90=E3=81=99=E3=82=8B=E3=81=9F=E3=82=81=E3=81=AB=E3=80=8C git diff -M=
 --stat --summary =E3=80=8D
 =E3=81=97=E4=BE=8B=E5=A4=96=E3=82=92=E9=81=A9=E7=94=A8=E3=81=99=E3=82=8B=
=E3=81=AB=E3=81=AF=E3=80=81=E6=9C=AC=E5=BD=93=E3=81=AB=E5=A6=A5=E5=BD=93=E3=
=81=AA=E7=90=86=E7=94=B1=E3=81=8C=E4=B8=8D=E5=8F=AF=E6=AC=A0=E3=81=A7=E3=81=
=99=E3=80=82=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AF=E6=81=90=E3=82=89=E3=81=8F=
=E3=81=93=E3=81=AE
 =E3=82=BB=E3=82=AF=E3=82=B7=E3=83=A7=E3=83=B3=E3=82=92 Linus =E3=81=AE=E3=
=82=B3=E3=83=B3=E3=83=94=E3=83=A5=E3=83=BC=E3=82=BF=E3=83=BB=E3=82=B5=E3=82=
=A4=E3=82=A8=E3=83=B3=E3=82=B9101=E3=81=A8=E5=91=BC=E3=81=B6=E3=81=A7=E3=81=
=97=E3=82=87=E3=81=86=E3=80=82
=20
-1) Documentation/CodingStyle=E3=82=92=E5=8F=82=E7=85=A7
+1) Documentation/process/coding-style.rst=E3=82=92=E5=8F=82=E7=85=A7
=20
 =E8=A8=80=E3=81=86=E3=81=BE=E3=81=A7=E3=82=82=E3=81=AA=E3=81=8F=E3=80=81=
=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E3=82=B3=E3=83=BC=E3=83=89=E3=81=8C=E3=
=81=93=E3=81=AE=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0=E3=82=
=B9=E3=82=BF=E3=82=A4=E3=83=AB=E3=81=8B=E3=82=89=E3=81=82=E3=81=BE=E3=82=8A=
=E3=81=AB
 =E3=82=82=E9=80=B8=E8=84=B1=E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=A8=
=E3=80=81=E3=83=AC=E3=83=93=E3=83=A5=E3=83=BC=E3=82=84=E3=82=B3=E3=83=A1=E3=
=83=B3=E3=83=88=E3=81=AA=E3=81=97=E3=81=AB=E5=8F=97=E3=81=91=E5=8F=96=E3=81=
=A3=E3=81=A6=E3=82=82=E3=82=89=E3=81=88=E3=81=AA=E3=81=84=E3=81=8B=E3=82=82=
=E3=81=97
@@ -704,8 +704,8 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem=
 maintainer".
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lkml.org/lkml/2005/7/11/336>
=20
-Kernel Documentation/CodingStyle:
-  <http://users.sosdg.org/~qiyong/lxr/source/Documentation/CodingStyle>
+Kernel Documentation/process/coding-style.rst:
+  <http://users.sosdg.org/~qiyong/lxr/source/Documentation/process/coding-=
style.rst>
=20
 Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
diff --git a/Documentation/ja_JP/stable_api_nonsense.txt b/Documentation/ja=
_JP/stable_api_nonsense.txt
index 7653b5cbfed2..a3b40a4bdcfd 100644
--- a/Documentation/ja_JP/stable_api_nonsense.txt
+++ b/Documentation/ja_JP/stable_api_nonsense.txt
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/stable_api_nonsense.txt into Japanese.
+This is a version of Documentation/process/stable-api-nonsense.rst into Ja=
panese.
 This document is maintained by IKEDA, Munehiro <m-ikeda@ds.jp.nec.com>
 and the JF Project team <http://www.linux.or.jp/JF/>.
 If you find any difference between this document and the original file
@@ -14,7 +14,7 @@ to update the original English file first.
 Last Updated: 2007/07/18
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
-linux-2.6.22-rc4/Documentation/stable_api_nonsense.txt =E3=81=AE=E5=92=8C=
=E8=A8=B3
+linux-2.6.22-rc4/Documentation/process/stable-api-nonsense.rst =E3=81=AE=
=E5=92=8C=E8=A8=B3
 =E3=81=A7=E3=81=99=E3=80=82
 =E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=E3=82=
=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
 =E7=BF=BB=E8=A8=B3=E6=97=A5 =EF=BC=9A 2007/06/11
diff --git a/Documentation/ja_JP/stable_kernel_rules.txt b/Documentation/ja=
_JP/stable_kernel_rules.txt
index 9dbda9b5d21e..f9249aecba64 100644
--- a/Documentation/ja_JP/stable_kernel_rules.txt
+++ b/Documentation/ja_JP/stable_kernel_rules.txt
@@ -1,5 +1,5 @@
 NOTE:
-This is Japanese translated version of "Documentation/stable_kernel_rules.=
txt".
+This is Japanese translated version of "Documentation/process/stable-kerne=
l-rules.rst".
 This one is maintained by Tsugikazu Shibata <tshibata@ab.jp.nec.com>
 and JF Project team <www.linux.or.jp/JF>.
 If you find difference with original file or problem in translation,
@@ -12,7 +12,7 @@ file at first.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =E3=81=93=E3=82=8C=E3=81=AF=E3=80=81
-linux-2.6.29/Documentation/stable_kernel_rules.txt
+linux-2.6.29/Documentation/process/stable-kernel-rules.rst
 =E3=81=AE=E5=92=8C=E8=A8=B3=E3=81=A7=E3=81=99=E3=80=82
=20
 =E7=BF=BB=E8=A8=B3=E5=9B=A3=E4=BD=93=EF=BC=9A JF =E3=83=97=E3=83=AD=E3=82=
=B8=E3=82=A7=E3=82=AF=E3=83=88 < http://www.linux.or.jp/JF/ >
@@ -43,7 +43,7 @@ linux-2.6.29/Documentation/stable_kernel_rules.txt
    "=E7=90=86=E8=AB=96=E7=9A=84=E3=81=AB=E3=81=AF=E7=AB=B6=E5=90=88=E7=8A=
=B6=E6=85=8B=E3=81=AB=E3=81=AA=E3=82=8B"=E3=82=88=E3=81=86=E3=81=AA=E3=82=
=82=E3=81=AE=E3=81=AF=E4=B8=8D=E5=8F=AF=E3=80=82
  - =E3=81=84=E3=81=8B=E3=81=AA=E3=82=8B=E4=BA=9B=E7=B4=B0=E3=81=AA=E4=BF=
=AE=E6=AD=A3=E3=82=82=E5=90=AB=E3=82=81=E3=82=8B=E3=81=93=E3=81=A8=E3=81=AF=
=E3=81=A7=E3=81=8D=E3=81=AA=E3=81=84=E3=80=82(=E3=82=B9=E3=83=9A=E3=83=AB=
=E3=81=AE=E4=BF=AE=E6=AD=A3=E3=80=81=E7=A9=BA=E7=99=BD=E3=81=AE=E3=82=AF=E3=
=83=AA=E3=83=BC
    =E3=83=B3=E3=82=A2=E3=83=83=E3=83=97=E3=81=AA=E3=81=A9)
- - Documentation/SubmittingPatches =E3=81=AE=E8=A6=8F=E5=89=87=E3=81=AB=E5=
=BE=93=E3=81=A3=E3=81=9F=E3=82=82=E3=81=AE=E3=81=A7=E3=81=AA=E3=81=91=E3=82=
=8C=E3=81=B0=E3=81=AA=E3=82=89=E3=81=AA=E3=81=84=E3=80=82
+ - Documentation/process/submitting-patches.rst =E3=81=AE=E8=A6=8F=E5=89=
=87=E3=81=AB=E5=BE=93=E3=81=A3=E3=81=9F=E3=82=82=E3=81=AE=E3=81=A7=E3=81=AA=
=E3=81=91=E3=82=8C=E3=81=B0=E3=81=AA=E3=82=89=E3=81=AA=E3=81=84=E3=80=82
  - =E3=83=91=E3=83=83=E3=83=81=E8=87=AA=E4=BD=93=E3=81=8B=E5=90=8C=E7=AD=
=89=E3=81=AE=E4=BF=AE=E6=AD=A3=E3=81=8C Linus =E3=81=AE=E3=83=84=E3=83=AA=
=E3=83=BC=E3=81=AB=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=AA=E3=
=81=91=E3=82=8C=E3=81=B0=E3=81=AA=E3=82=89=E3=81=AA=E3=81=84=E3=80=82
 =E3=80=80 Linus =E3=81=AE=E3=83=84=E3=83=AA=E3=83=BC=E3=81=A7=E3=81=AE=E3=
=82=B3=E3=83=9F=E3=83=83=E3=83=88ID =E3=82=92 -stable =E3=81=B8=E3=81=AE=E3=
=83=91=E3=83=83=E3=83=81=E6=8A=95=E7=A8=BF=E3=81=AE=E9=9A=9B=E3=81=AB=E5=BC=
=95=E7=94=A8=E3=81=99
    =E3=82=8B=E3=81=93=E3=81=A8=E3=80=82
diff --git a/Documentation/kernel-per-CPU-kthreads.txt b/Documentation/kern=
el-per-CPU-kthreads.txt
index bbc3a8b8cff4..df31e30b6a02 100644
--- a/Documentation/kernel-per-CPU-kthreads.txt
+++ b/Documentation/kernel-per-CPU-kthreads.txt
@@ -264,7 +264,7 @@ To reduce its OS jitter, do at least one of the followi=
ng:
 	kthreads from being created in the first place.
 2.	Boot with "nosoftlockup=3D0", which will also prevent these kthreads
 	from being created.  Other related watchdog and softlockup boot
-	parameters may be found in Documentation/kernel-parameters.txt
+	parameters may be found in Documentation/admin-guide/kernel-parameters.rs=
t
 	and Documentation/watchdog/watchdog-parameters.txt.
 3.	Echo a zero to /proc/sys/kernel/watchdog to disable the
 	watchdog timer.
diff --git a/Documentation/ko_KR/HOWTO b/Documentation/ko_KR/HOWTO
index 9a3e65924d54..025252731af5 100644
--- a/Documentation/ko_KR/HOWTO
+++ b/Documentation/ko_KR/HOWTO
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/HOWTO translated into korean
+This is a version of Documentation/process/howto.rst translated into korea=
n
 This document is maintained by Minchan Kim <minchan@kernel.org>
 If you find any difference between this document and the original file or
 a problem with the translation, please contact the maintainer of this file=
.
@@ -11,7 +11,7 @@ try to update the original English file first.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94
-Documentation/HOWTO
+Documentation/process/howto.rst
 =EC=9D=98 =ED=95=9C=EA=B8=80 =EB=B2=88=EC=97=AD=EC=9E=85=EB=8B=88=EB=8B=A4=
.
=20
 =EC=97=AD=EC=9E=90=EF=BC=9A =EA=B9=80=EB=AF=BC=EC=B0=AC <minchan@kernel.or=
g>
@@ -98,18 +98,18 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
     =EB=B9=8C=EB=93=9C=ED=95=98=EA=B8=B0 =EC=9C=84=ED=95=B4 =ED=95=84=EC=
=9A=94=ED=95=9C =EA=B2=83=EC=9D=84 =EC=84=A4=EB=AA=85=ED=95=9C=EB=8B=A4. =
=EC=BB=A4=EB=84=90=EC=97=90 =EC=9E=85=EB=AC=B8=ED=95=98=EB=8A=94 =EC=82=AC=
=EB=9E=8C=EB=93=A4=EC=9D=80 =EC=97=AC=EA=B8=B0=EC=84=9C
     =EC=8B=9C=EC=9E=91=ED=95=B4=EC=95=BC =ED=95=9C=EB=8B=A4.
=20
-  Documentation/Changes
+  Documentation/process/changes.rst
     =EC=9D=B4 =ED=8C=8C=EC=9D=BC=EC=9D=80 =EC=BB=A4=EB=84=90=EC=9D=84 =EC=
=84=B1=EA=B3=B5=EC=A0=81=EC=9C=BC=EB=A1=9C =EB=B9=8C=EB=93=9C=ED=95=98=EA=
=B3=A0 =EC=8B=A4=ED=96=89=EC=8B=9C=ED=82=A4=EA=B8=B0 =EC=9C=84=ED=95=B4 =ED=
=95=84=EC=9A=94=ED=95=9C =EB=8B=A4=EC=96=91=ED=95=9C
     =EC=86=8C=ED=94=84=ED=8A=B8=EC=9B=A8=EC=96=B4 =ED=8C=A8=ED=82=A4=EC=A7=
=80=EB=93=A4=EC=9D=98 =EC=B5=9C=EC=86=8C =EB=B2=84=EC=A0=BC=EC=9D=84 =EB=82=
=98=EC=97=B4=ED=95=9C=EB=8B=A4.
=20
-  Documentation/CodingStyle
+  Documentation/process/coding-style.rst
     =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94 =EB=A6=AC=EB=88=85=EC=8A=A4 =EC=
=BB=A4=EB=84=90 =EC=BD=94=EB=94=A9 =EC=8A=A4=ED=83=80=EC=9D=BC=EA=B3=BC =EA=
=B7=B8=EB=A0=87=EA=B2=8C =ED=95=9C =EB=AA=87=EB=AA=87 =EC=9D=B4=EC=9C=A0=EB=
=A5=BC =EC=84=A4=EB=AA=85=ED=95=9C=EB=8B=A4.
     =EB=AA=A8=EB=93=A0 =EC=83=88=EB=A1=9C=EC=9A=B4 =EC=BD=94=EB=93=9C=EB=
=8A=94 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EC=97=90 =EA=B0=80=EC=9D=B4=EB=93=9C=EB=
=9D=BC=EC=9D=B8=EB=93=A4=EC=9D=84 =EB=94=B0=EB=9D=BC=EC=95=BC =ED=95=9C=EB=
=8B=A4. =EB=8C=80=EB=B6=80=EB=B6=84=EC=9D=98
     =EB=A9=94=EC=9D=B8=ED=85=8C=EC=9D=B4=EB=84=88=EB=93=A4=EC=9D=80 =EC=9D=
=B4 =EA=B7=9C=EC=B9=99=EC=9D=84 =EB=94=B0=EB=A5=B4=EB=8A=94 =ED=8C=A8=EC=B9=
=98=EB=93=A4=EB=A7=8C=EC=9D=84 =EB=B0=9B=EC=95=84=EB=93=A4=EC=9D=BC =EA=B2=
=83=EC=9D=B4=EA=B3=A0 =EB=A7=8E=EC=9D=80 =EC=82=AC=EB=9E=8C=EB=93=A4=EC=9D=
=B4
     =EA=B7=B8 =ED=8C=A8=EC=B9=98=EA=B0=80 =EC=98=AC=EB=B0=94=EB=A5=B8 =EC=
=8A=A4=ED=83=80=EC=9D=BC=EC=9D=BC =EA=B2=BD=EC=9A=B0=EB=A7=8C =EC=BD=94=EB=
=93=9C=EB=A5=BC =EA=B2=80=ED=86=A0=ED=95=A0 =EA=B2=83=EC=9D=B4=EB=8B=A4.
=20
-  Documentation/SubmittingPatches
-  Documentation/SubmittingDrivers
+  Documentation/process/submitting-patches.rst
+  Documentation/process/submitting-drivers.rst
     =EC=9D=B4 =ED=8C=8C=EC=9D=BC=EB=93=A4=EC=9D=80 =EC=84=B1=EA=B3=B5=EC=
=A0=81=EC=9C=BC=EB=A1=9C =ED=8C=A8=EC=B9=98=EB=A5=BC =EB=A7=8C=EB=93=A4=EA=
=B3=A0 =EB=B3=B4=EB=82=B4=EB=8A=94 =EB=B2=95=EC=9D=84 =EB=8B=A4=EC=9D=8C=EC=
=9D=98 =EB=82=B4=EC=9A=A9=EB=93=A4=EB=A1=9C
     =EA=B5=89=EC=9E=A5=ED=9E=88 =EC=83=81=EC=84=B8=ED=9E=88 =EC=84=A4=EB=
=AA=85=ED=95=98=EA=B3=A0 =EC=9E=88=EB=8B=A4(=EA=B7=B8=EB=9F=AC=EB=82=98 =EB=
=8B=A4=EC=9D=8C=EC=9C=BC=EB=A1=9C =ED=95=9C=EC=A0=95=EB=90=98=EC=A7=84 =EC=
=95=8A=EB=8A=94=EB=8B=A4).
        - Email =EB=82=B4=EC=9A=A9=EB=93=A4
@@ -126,7 +126,7 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
     "Linux kernel patch submission format"
         http://linux.yyz.us/patch-format.html
=20
-   Documentation/stable_api_nonsense.txt
+   Documentation/process/stable-api-nonsense.rst
     =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94 =EC=9D=98=EB=8F=84=EC=A0=81=EC=
=9C=BC=EB=A1=9C =EC=BB=A4=EB=84=90=EC=9D=B4 =EB=B6=88=EB=B3=80=ED=95=98=EB=
=8A=94 API=EB=A5=BC =EA=B0=96=EC=A7=80 =EC=95=8A=EB=8F=84=EB=A1=9D =EA=B2=
=B0=EC=A0=95=ED=95=9C
     =EC=9D=B4=EC=9C=A0=EB=A5=BC =EC=84=A4=EB=AA=85=ED=95=98=EB=A9=B0 =EB=
=8B=A4=EC=9D=8C=EA=B3=BC =EA=B0=99=EC=9D=80 =EA=B2=83=EB=93=A4=EC=9D=84 =ED=
=8F=AC=ED=95=A8=ED=95=9C=EB=8B=A4.
        - =EC=84=9C=EB=B8=8C=EC=8B=9C=EC=8A=A4=ED=85=9C shim-layer(=ED=98=
=B8=ED=99=98=EC=84=B1=EC=9D=84 =EC=9C=84=ED=95=B4?)
@@ -136,12 +136,12 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
     =EB=A6=AC=EB=88=85=EC=8A=A4=EB=A1=9C =EC=A0=84=ED=96=A5=ED=95=98=EB=8A=
=94 =EC=82=AC=EB=9E=8C=EB=93=A4=EC=97=90=EA=B2=8C=EB=8A=94 =EB=A7=A4=EC=9A=
=B0 =EC=A4=91=EC=9A=94=ED=95=98=EB=8B=A4.
=20
=20
-  Documentation/SecurityBugs
+  Documentation/admin-guide/security-bugs.rst
     =EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =EB=A6=AC=EB=88=85=EC=8A=
=A4 =EC=BB=A4=EB=84=90=EC=9D=98 =EB=B3=B4=EC=95=88 =EB=AC=B8=EC=A0=9C=EB=A5=
=BC =EB=B0=9C=EA=B2=AC=ED=96=88=EB=8B=A4=EA=B3=A0 =EC=83=9D=EA=B0=81=ED=95=
=9C=EB=8B=A4=EB=A9=B4 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EC=97=90
     =EB=82=98=EC=98=A8 =EB=8B=A8=EA=B3=84=EC=97=90 =EB=94=B0=EB=9D=BC=EC=
=84=9C =EC=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=9E=90=EB=93=A4=EC=97=90=EA=
=B2=8C =EC=95=8C=EB=A6=AC=EA=B3=A0 =EA=B7=B8 =EB=AC=B8=EC=A0=9C=EB=A5=BC =
=ED=95=B4=EA=B2=B0=ED=95=A0 =EC=88=98 =EC=9E=88=EB=8F=84=EB=A1=9D
     =EB=8F=84=EC=99=80 =EB=8B=AC=EB=9D=BC.
=20
-  Documentation/ManagementStyle
+  Documentation/process/management-style.rst
     =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94 =EB=A6=AC=EB=88=85=EC=8A=A4 =EC=
=BB=A4=EB=84=90 =EB=A9=94=EC=9D=B8=ED=85=8C=EC=9D=B4=EB=84=88=EB=93=A4=EC=
=9D=B4 =EA=B7=B8=EB=93=A4=EC=9D=98 =EB=B0=A9=EB=B2=95=EB=A1=A0=EC=97=90 =EB=
=85=B9=EC=95=84 =EC=9E=88=EB=8A=94
     =EC=A0=95=EC=8B=A0=EC=9D=84 =EC=96=B4=EB=96=BB=EA=B2=8C =EA=B3=B5=EC=
=9C=A0=ED=95=98=EA=B3=A0 =EC=9A=B4=EC=98=81=ED=95=98=EB=8A=94=EC=A7=80=EB=
=A5=BC =EC=84=A4=EB=AA=85=ED=95=9C=EB=8B=A4. =EC=9D=B4=EA=B2=83=EC=9D=80 =
=EC=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=97=90 =EC=9E=85=EB=AC=B8=ED=95=98=
=EB=8A=94
     =EB=AA=A8=EB=93=A0 =EC=82=AC=EB=9E=8C=EB=93=A4(=EB=98=90=EB=8A=94 =EC=
=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=97=90 =EC=9E=91=EC=9D=80 =ED=98=B8=EA=
=B8=B0=EC=8B=AC=EC=9D=B4=EB=9D=BC=EB=8F=84 =EC=9E=88=EB=8A=94 =EC=82=AC=EB=
=9E=8C=EB=93=A4)=EC=9D=B4
@@ -149,17 +149,17 @@ mtk.manpages@gmail.com=EC=9D=98 =EB=A9=94=EC=9D=B8=ED=
=85=8C=EC=9D=B4=EB=84=88=EC=97=90=EA=B2=8C =EB=B3=B4=EB=82=BC =EA=B2=83=EC=
=9D=84 =EA=B6=8C=EC=9E=A5=ED=95=9C=EB=8B=A4.
     =EB=8F=85=ED=8A=B9=ED=95=9C =ED=96=89=EB=8F=99=EC=97=90 =EA=B4=80=ED=
=95=98=EC=97=AC =ED=9D=94=ED=9E=88 =EC=9E=88=EB=8A=94 =EC=98=A4=ED=95=B4=EB=
=93=A4=EA=B3=BC =ED=98=BC=EB=9E=80=EB=93=A4=EC=9D=84 =ED=95=B4=EC=86=8C=ED=
=95=98=EA=B3=A0 =EC=9E=88=EA=B8=B0
     =EB=95=8C=EB=AC=B8=EC=9D=B4=EB=8B=A4.
=20
-  Documentation/stable_kernel_rules.txt
+  Documentation/process/stable-kernel-rules.rst
     =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94 =EC=95=88=EC=A0=95=EC=A0=81=EC=
=9D=B8 =EC=BB=A4=EB=84=90 =EB=B0=B0=ED=8F=AC=EA=B0=80 =EC=9D=B4=EB=A3=A8=EC=
=96=B4=EC=A7=80=EB=8A=94 =EA=B7=9C=EC=B9=99=EC=9D=84 =EC=84=A4=EB=AA=85=ED=
=95=98=EA=B3=A0 =EC=9E=88=EC=9C=BC=EB=A9=B0
     =EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =EC=9D=B4=EB=9F=AC=ED=95=
=9C =EB=B0=B0=ED=8F=AC=EB=93=A4 =EC=A4=91 =ED=95=98=EB=82=98=EC=97=90 =EB=
=B3=80=EA=B2=BD=EC=9D=84 =ED=95=98=EA=B8=B8 =EC=9B=90=ED=95=9C=EB=8B=A4=EB=
=A9=B4
     =EB=AC=B4=EC=97=87=EC=9D=84 =ED=95=B4=EC=95=BC =ED=95=98=EB=8A=94=EC=
=A7=80=EB=A5=BC =EC=84=A4=EB=AA=85=ED=95=9C=EB=8B=A4.
=20
-  Documentation/kernel-docs.txt
+  Documentation/process/kernel-docs.rst
     =EC=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=97=90 =EA=B4=80=EA=B3=84=EB=
=90=9C =EC=99=B8=EB=B6=80 =EB=AC=B8=EC=84=9C=EC=9D=98 =EB=A6=AC=EC=8A=A4=ED=
=8A=B8=EC=9D=B4=EB=8B=A4. =EC=BB=A4=EB=84=90 =EB=82=B4=EC=9D=98 =ED=8F=AC=
=ED=95=A8=EB=90=9C =EB=AC=B8=EC=84=9C=EB=93=A4
     =EC=A4=91=EC=97=90 =EC=97=AC=EB=9F=AC=EB=B6=84=EC=9D=B4 =EC=B0=BE=EA=
=B3=A0 =EC=8B=B6=EC=9D=80 =EB=AC=B8=EC=84=9C=EB=A5=BC =EB=B0=9C=EA=B2=AC=ED=
=95=98=EC=A7=80 =EB=AA=BB=ED=95=A0 =EA=B2=BD=EC=9A=B0 =EC=9D=B4 =EB=A6=AC=
=EC=8A=A4=ED=8A=B8=EB=A5=BC
     =EC=82=B4=ED=8E=B4=EB=B3=B4=EB=9D=BC.
=20
-  Documentation/applying-patches.txt
+  Documentation/process/applying-patches.rst
     =ED=8C=A8=EC=B9=98=EA=B0=80 =EB=AC=B4=EC=97=87=EC=9D=B4=EB=A9=B0 =EA=
=B7=B8=EA=B2=83=EC=9D=84 =EC=BB=A4=EB=84=90=EC=9D=98 =EB=8B=A4=EB=A5=B8 =EA=
=B0=9C=EB=B0=9C =EB=B8=8C=EB=9E=9C=EC=B9=98=EB=93=A4=EC=97=90 =EC=96=B4=EB=
=96=BB=EA=B2=8C
     =EC=A0=81=EC=9A=A9=ED=95=98=EB=8A=94=EC=A7=80=EC=97=90 =EA=B4=80=ED=95=
=98=EC=97=AC =EC=9E=90=EC=84=B8=ED=9E=88 =EC=84=A4=EB=AA=85=ED=95=98=EA=B3=
=A0 =EC=9E=88=EB=8A=94 =EC=A2=8B=EC=9D=80 =EC=9E=85=EB=AC=B8=EC=84=9C=EC=9D=
=B4=EB=8B=A4.
=20
@@ -276,7 +276,7 @@ Andrew Morton=EC=9D=98 =EA=B8=80=EC=9D=B4 =EC=9E=88=EB=
=8B=A4.
 4.x.y=EB=8A=94 "stable" =ED=8C=80<stable@vger.kernel.org>=EC=97=90 =EC=9D=
=98=ED=95=B4 =EA=B4=80=EB=A6=AC=EB=90=98=EB=A9=B0 =EA=B1=B0=EC=9D=98 =EB=A7=
=A4=EB=B2=88 =EA=B2=A9=EC=A3=BC=EB=A1=9C
 =EB=B0=B0=ED=8F=AC=EB=90=9C=EB=8B=A4.
=20
-=EC=BB=A4=EB=84=90 =ED=8A=B8=EB=A6=AC =EB=AC=B8=EC=84=9C=EB=93=A4 =EB=82=
=B4=EC=97=90 Documentation/stable_kernel_rules.txt =ED=8C=8C=EC=9D=BC=EC=9D=
=80 =EC=96=B4=EB=96=A4
+=EC=BB=A4=EB=84=90 =ED=8A=B8=EB=A6=AC =EB=AC=B8=EC=84=9C=EB=93=A4 =EB=82=
=B4=EC=97=90 Documentation/process/stable-kernel-rules.rst =ED=8C=8C=EC=9D=
=BC=EC=9D=80 =EC=96=B4=EB=96=A4
 =EC=A2=85=EB=A5=98=EC=9D=98 =EB=B3=80=EA=B2=BD=EB=93=A4=EC=9D=B4 -stable =
=ED=8A=B8=EB=A6=AC=EB=A1=9C =EB=93=A4=EC=96=B4=EC=99=94=EB=8A=94=EC=A7=80=
=EC=99=80 =EB=B0=B0=ED=8F=AC =ED=94=84=EB=A1=9C=EC=84=B8=EC=8A=A4=EA=B0=80 =
=EC=96=B4=EB=96=BB=EA=B2=8C
 =EC=A7=84=ED=96=89=EB=90=98=EB=8A=94=EC=A7=80=EB=A5=BC =EC=84=A4=EB=AA=85=
=ED=95=9C=EB=8B=A4.
=20
@@ -328,7 +328,7 @@ bugzilla.kernel.org=EB=8A=94 =EB=A6=AC=EB=88=85=EC=8A=
=A4 =EC=BB=A4=EB=84=90 =EA=B0=9C=EB=B0=9C=EC=9E=90=EB=93=A4=EC=9D=B4 =EC=BB=
=A4=EB=84=90=EC=9D=98 =EB=B2=84=EA=B7=B8=EB=A5=BC =EC=B6=94
 kernel bugzilla=EB=A5=BC =EC=82=AC=EC=9A=A9=ED=95=98=EB=8A=94 =EC=9E=90=EC=
=84=B8=ED=95=9C =EB=B0=A9=EB=B2=95=EC=9D=80 =EB=8B=A4=EC=9D=8C=EC=9D=84 =EC=
=B0=B8=EC=A1=B0=ED=95=98=EB=9D=BC.
     http://test.kernel.org/bugzilla/faq.html
=20
-=EB=A9=94=EC=9D=B8 =EC=BB=A4=EB=84=90 =EC=86=8C=EC=8A=A4 =EB=94=94=EB=A0=
=89=ED=86=A0=EB=A6=AC=EC=97=90 =EC=9E=88=EB=8A=94 REPORTING-BUGS =ED=8C=8C=
=EC=9D=BC=EC=9D=80 =EC=BB=A4=EB=84=90 =EB=B2=84=EA=B7=B8=EB=9D=BC=EA=B3=A0 =
=EC=83=9D=EA=B0=81=EB=90=98=EB=8A=94
+=EB=A9=94=EC=9D=B8 =EC=BB=A4=EB=84=90 =EC=86=8C=EC=8A=A4 =EB=94=94=EB=A0=
=89=ED=86=A0=EB=A6=AC=EC=97=90 =EC=9E=88=EB=8A=94 admin-guide/reporting-bug=
s.rst =ED=8C=8C=EC=9D=BC=EC=9D=80 =EC=BB=A4=EB=84=90 =EB=B2=84=EA=B7=B8=EB=
=9D=BC=EA=B3=A0 =EC=83=9D=EA=B0=81=EB=90=98=EB=8A=94
 =EA=B2=83=EC=9D=84 =EB=B3=B4=EA=B3=A0=ED=95=98=EB=8A=94 =EB=B0=A9=EB=B2=95=
=EC=97=90 =EA=B4=80=ED=95=9C =EC=A2=8B=EC=9D=80 =ED=85=9C=ED=94=8C=EB=A6=BF=
=EC=9D=B4=EB=A9=B0 =EB=AC=B8=EC=A0=9C=EB=A5=BC =EC=B6=94=EC=A0=81=ED=95=98=
=EA=B8=B0 =EC=9C=84=ED=95=B4=EC=84=9C =EC=BB=A4=EB=84=90
 =EA=B0=9C=EB=B0=9C=EC=9E=90=EB=93=A4=EC=9D=B4 =ED=95=84=EC=9A=94=EB=A1=9C =
=ED=95=98=EB=8A=94 =EC=A0=95=EB=B3=B4=EA=B0=80 =EB=AC=B4=EC=97=87=EB=93=A4=
=EC=9D=B8=EC=A7=80=EB=A5=BC =EC=83=81=EC=84=B8=ED=9E=88 =EC=84=A4=EB=AA=85=
=ED=95=98=EA=B3=A0 =EC=9E=88=EB=8B=A4.
=20
@@ -391,7 +391,7 @@ bugme-janitor =EB=A9=94=EC=9D=BC=EB=A7=81 =EB=A6=AC=EC=
=8A=A4=ED=8A=B8(bugzilla=EC=97=90 =EB=AA=A8=EB=93=A0 =EB=B3=80=ED=99=94=EB=
=93=A4=EC=9D=B4 =EC=97=AC=EA=B8=B0=EC=84=9C =EB=A9=94
 "John =EC=BB=A4=EB=84=90=ED=95=B4=EC=BB=A4=EB=8A=94 =EC=9E=91=EC=84=B1=ED=
=96=88=EB=8B=A4...."=EB=A5=BC =EC=9C=A0=EC=A7=80=ED=95=98=EB=A9=B0 =EC=97=
=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=98 =EC=9D=98=EA=B2=AC=EC=9D=84 =EA=B7=
=B8 =EB=A9=94=EC=9D=BC=EC=9D=98 =EC=9C=97=EB=B6=80=EB=B6=84=EC=97=90
 =EC=9E=91=EC=84=B1=ED=95=98=EC=A7=80 =EB=A7=90=EA=B3=A0 =EA=B0=81 =EC=9D=
=B8=EC=9A=A9=ED=95=9C =EB=8B=A8=EB=9D=BD=EB=93=A4 =EC=82=AC=EC=9D=B4=EC=97=
=90 =EB=84=A3=EC=96=B4=EB=9D=BC.
=20
-=EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =ED=8C=A8=EC=B9=98=EB=93=A4=
=EC=9D=84 =EB=A9=94=EC=9D=BC=EC=97=90 =EB=84=A3=EB=8A=94=EB=8B=A4=EB=A9=B4 =
=EA=B7=B8=EA=B2=83=EB=93=A4=EC=9D=80 Documentation/SubmittingPatches=EC=97=
=90
+=EC=97=AC=EB=9F=AC=EB=B6=84=EB=93=A4=EC=9D=B4 =ED=8C=A8=EC=B9=98=EB=93=A4=
=EC=9D=84 =EB=A9=94=EC=9D=BC=EC=97=90 =EB=84=A3=EB=8A=94=EB=8B=A4=EB=A9=B4 =
=EA=B7=B8=EA=B2=83=EB=93=A4=EC=9D=80 Documentation/process/submitting-patch=
es.rst=EC=97=90
 =EB=82=98=EC=99=80=EC=9E=88=EB=8A=94=EB=8D=B0=EB=A1=9C =EB=AA=85=EB=B0=B1=
=ED=9E=88(plain) =EC=9D=BD=EC=9D=84 =EC=88=98 =EC=9E=88=EB=8A=94 =ED=85=8D=
=EC=8A=A4=ED=8A=B8=EC=97=AC=EC=95=BC =ED=95=9C=EB=8B=A4. =EC=BB=A4=EB=84=90=
 =EA=B0=9C=EB=B0=9C=EC=9E=90=EB=93=A4=EC=9D=80
 =EC=B2=A8=EB=B6=80=ED=8C=8C=EC=9D=BC=EC=9D=B4=EB=82=98 =EC=95=95=EC=B6=95=
=EB=90=9C =ED=8C=A8=EC=B9=98=EB=93=A4=EC=9D=84 =EC=9B=90=ED=95=98=EC=A7=80 =
=EC=95=8A=EB=8A=94=EB=8B=A4. =EA=B7=B8=EB=93=A4=EC=9D=80 =EC=97=AC=EB=9F=AC=
=EB=B6=84=EB=93=A4=EC=9D=98 =ED=8C=A8=EC=B9=98=EC=9D=98
 =EA=B0=81 =EB=9D=BC=EC=9D=B8 =EB=8B=A8=EC=9C=84=EB=A1=9C =EC=BD=94=EB=A9=
=98=ED=8A=B8=EB=A5=BC =ED=95=98=EA=B8=B8 =EC=9B=90=ED=95=98=EB=A9=B0 =EC=95=
=95=EC=B6=95=ED=95=98=EA=B1=B0=EB=82=98 =EC=B2=A8=EB=B6=80=ED=95=98=EC=A7=
=80 =EC=95=8A=EA=B3=A0 =EB=B3=B4=EB=82=B4=EB=8A=94 =EA=B2=83=EC=9D=B4
diff --git a/Documentation/ko_KR/stable_api_nonsense.txt b/Documentation/ko=
_KR/stable_api_nonsense.txt
index 3ba10b11d556..4d93af1efd61 100644
--- a/Documentation/ko_KR/stable_api_nonsense.txt
+++ b/Documentation/ko_KR/stable_api_nonsense.txt
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/stable_api_nonsense.txt translated
+This is a version of Documentation/process/stable-api-nonsense.rst transla=
ted
 into korean
 This document is maintained by Minchan Kim <minchan@kernel.org>
 If you find any difference between this document and the original file or
@@ -12,7 +12,7 @@ try to update the original English file first.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94
-Documentation/stable_api_nonsense.txt
+Documentation/process/stable-api-nonsense.rst
 =EC=9D=98 =ED=95=9C=EA=B8=80 =EB=B2=88=EC=97=AD=EC=9E=85=EB=8B=88=EB=8B=A4=
.
=20
 =EC=97=AD=EC=9E=90=EF=BC=9A =EA=B9=80=EB=AF=BC=EC=B0=AC <minchan@kernel.or=
g>
diff --git a/Documentation/lockup-watchdogs.txt b/Documentation/lockup-watc=
hdogs.txt
index 4a6e33e1af61..c8b8378513d6 100644
--- a/Documentation/lockup-watchdogs.txt
+++ b/Documentation/lockup-watchdogs.txt
@@ -11,7 +11,7 @@ details), without giving other tasks a chance to run. The=
 current
 stack trace is displayed upon detection and, by default, the system
 will stay locked up. Alternatively, the kernel can be configured to
 panic; a sysctl, "kernel.softlockup_panic", a kernel parameter,
-"softlockup_panic" (see "Documentation/kernel-parameters.txt" for
+"softlockup_panic" (see "Documentation/admin-guide/kernel-parameters.rst" =
for
 details), and a compile option, "BOOTPARAM_SOFTLOCKUP_PANIC", are
 provided for this.
=20
@@ -23,7 +23,7 @@ upon detection and the system will stay locked up unless =
the default
 behavior is changed, which can be done through a sysctl,
 'hardlockup_panic', a compile time knob, "BOOTPARAM_HARDLOCKUP_PANIC",
 and a kernel parameter, "nmi_watchdog"
-(see "Documentation/kernel-parameters.txt" for details).
+(see "Documentation/admin-guide/kernel-parameters.rst" for details).
=20
 The panic option can be used in combination with panic_timeout (this
 timeout is set through the confusingly named "kernel.panic" sysctl),
diff --git a/Documentation/m68k/kernel-options.txt b/Documentation/m68k/ker=
nel-options.txt
index eaf32a1fd0b1..79d21246c75a 100644
--- a/Documentation/m68k/kernel-options.txt
+++ b/Documentation/m68k/kernel-options.txt
@@ -139,7 +139,7 @@ follows:
   PARTUUID=3D00112233-4455-6677-8899-AABBCCDDEEFF/PARTNROFF=3D-2
=20
 Authoritative information can be found in
-"Documentation/kernel-parameters.txt".
+"Documentation/admin-guide/kernel-parameters.rst".
=20
=20
 2.2) ro, rw
diff --git a/Documentation/media/uapi/v4l/diff-v4l.rst b/Documentation/medi=
a/uapi/v4l/diff-v4l.rst
index 76b2ecab8657..8209eeb63dd2 100644
--- a/Documentation/media/uapi/v4l/diff-v4l.rst
+++ b/Documentation/media/uapi/v4l/diff-v4l.rst
@@ -648,12 +648,12 @@ microcode programming. A new interface for MPEG compr=
ession and playback
 devices is documented in :ref:`extended-controls`.
=20
 .. [#f1]
-   According to Documentation/devices.txt these should be symbolic links
+   According to Documentation/admin-guide/devices.rst these should be symb=
olic links
    to ``/dev/video0``. Note the original bttv interface is not
    compatible with V4L or V4L2.
=20
 .. [#f2]
-   According to ``Documentation/devices.txt`` a symbolic link to
+   According to ``Documentation/admin-guide/devices.rst`` a symbolic link =
to
    ``/dev/radio0``.
=20
 .. [#f3]
diff --git a/Documentation/media/v4l-drivers/bttv.rst b/Documentation/media=
/v4l-drivers/bttv.rst
index 7abc1c9a261b..bc63b12efafd 100644
--- a/Documentation/media/v4l-drivers/bttv.rst
+++ b/Documentation/media/v4l-drivers/bttv.rst
@@ -304,10 +304,10 @@ bug.  It is very helpful if you can tell where exactl=
y it broke
 With a hard freeze you probably doesn't find anything in the logfiles.
 The only way to capture any kernel messages is to hook up a serial
 console and let some terminal application log the messages.  /me uses
-screen.  See Documentation/serial-console.txt for details on setting
+screen.  See Documentation/admin-guide/serial-console.rst for details on s=
etting
 up a serial console.
=20
-Read Documentation/oops-tracing.txt to learn how to get any useful
+Read Documentation/admin-guide/oops-tracing.rst to learn how to get any us=
eful
 information out of a register+stack dump printed by the kernel on
 protection faults (so-called "kernel oops").
=20
diff --git a/Documentation/memory-hotplug.txt b/Documentation/memory-hotplu=
g.txt
index 0d7cb955aa01..5de846d3ecc0 100644
--- a/Documentation/memory-hotplug.txt
+++ b/Documentation/memory-hotplug.txt
@@ -324,7 +324,7 @@ guarantee that the memory block contains only migratabl=
e pages.
 Now, a boot option for making a memory block which consists of migratable =
pages
 is supported. By specifying "kernelcore=3D" or "movablecore=3D" boot optio=
n, you can
 create ZONE_MOVABLE...a zone which is just used for movable pages.
-(See also Documentation/kernel-parameters.txt)
+(See also Documentation/admin-guide/kernel-parameters.rst)
=20
 Assume the system has "TOTAL" amount of memory at boot time, this boot opt=
ion
 creates ZONE_MOVABLE as following.
diff --git a/Documentation/networking/netconsole.txt b/Documentation/networ=
king/netconsole.txt
index 30409a36e95d..296ea00fd3eb 100644
--- a/Documentation/networking/netconsole.txt
+++ b/Documentation/networking/netconsole.txt
@@ -200,7 +200,7 @@ priority messages to the console. You can change this a=
t runtime using:
 or by specifying "debug" on the kernel command line at boot, to send
 all kernel messages to the console. A specific value for this parameter
 can also be set using the "loglevel" kernel boot option. See the
-dmesg(8) man page and Documentation/kernel-parameters.txt for details.
+dmesg(8) man page and Documentation/admin-guide/kernel-parameters.rst for =
details.
=20
 Netconsole was designed to be as instantaneous as possible, to
 enable the logging of even the most critical kernel bugs. It works
diff --git a/Documentation/networking/netdev-FAQ.txt b/Documentation/networ=
king/netdev-FAQ.txt
index 0fe1c6e0dbcd..cdebc5c8705f 100644
--- a/Documentation/networking/netdev-FAQ.txt
+++ b/Documentation/networking/netdev-FAQ.txt
@@ -136,14 +136,14 @@ A: Normally Greg Kroah-Hartman collects stable commit=
s himself, but
=20
 Q: I see a network patch and I think it should be backported to stable.
    Should I request it via "stable@vger.kernel.org" like the references in
-   the kernel's Documentation/stable_kernel_rules.txt file say?
+   the kernel's Documentation/process/stable-kernel-rules.rst file say?
=20
 A: No, not for networking.  Check the stable queues as per above 1st to se=
e
    if it is already queued.  If not, then send a mail to netdev, listing
    the upstream commit ID and why you think it should be a stable candidat=
e.
=20
    Before you jump to go do the above, do note that the normal stable rule=
s
-   in Documentation/stable_kernel_rules.txt still apply.  So you need to
+   in Documentation/process/stable-kernel-rules.rst still apply.  So you n=
eed to
    explicitly indicate why it is a critical fix and exactly what users are
    impacted.  In addition, you need to convince yourself that you _really_
    think it has been overlooked, vs. having been considered and rejected.
@@ -165,7 +165,7 @@ A: No.  See above answer.  In short, if you think it re=
ally belongs in
=20
    If you think there is some valid information relating to it being in
    stable that does _not_ belong in the commit log, then use the three
-   dash marker line as described in Documentation/SubmittingPatches to
+   dash marker line as described in Documentation/process/submitting-patch=
es.rst to
    temporarily embed that information into the patch that you send.
=20
 Q: Someone said that the comment style and coding convention is different
@@ -220,5 +220,5 @@ A: Attention to detail.  Re-read your own work as if yo=
u were the
    If it is your first patch, mail it to yourself so you can test apply
    it to an unpatched tree to confirm infrastructure didn't mangle it.
=20
-   Finally, go back and read Documentation/SubmittingPatches to be
+   Finally, go back and read Documentation/process/submitting-patches.rst =
to be
    sure you are not repeating some common mistake documented there.
diff --git a/Documentation/networking/vortex.txt b/Documentation/networking=
/vortex.txt
index 97282da82b75..ad3dead052a4 100644
--- a/Documentation/networking/vortex.txt
+++ b/Documentation/networking/vortex.txt
@@ -364,7 +364,7 @@ steps you should take:
=20
 - The contents of your report will vary a lot depending upon the
   problem.  If it's a kernel crash then you should refer to the
-  REPORTING-BUGS file.
+  admin-guide/reporting-bugs.rst file.
=20
   But for most problems it is useful to provide the following:
=20
diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
index ad04cc8097ed..7cb6085839f3 100644
--- a/Documentation/power/00-INDEX
+++ b/Documentation/power/00-INDEX
@@ -6,7 +6,7 @@ basic-pm-debugging.txt
 	- Debugging suspend and resume
 charger-manager.txt
 	- Battery charger management.
-devices.txt
+admin-guide/devices.rst
 	- How drivers interact with system-wide power management
 drivers-testing.txt
 	- Testing suspend and resume support in device drivers
diff --git a/Documentation/power/pci.txt b/Documentation/power/pci.txt
index 44558882aa60..85c746cbab2c 100644
--- a/Documentation/power/pci.txt
+++ b/Documentation/power/pci.txt
@@ -8,7 +8,7 @@ management.  Based on previous work by Patrick Mochel <moch=
el@transmeta.com>
=20
 This document only covers the aspects of power management specific to PCI
 devices.  For general description of the kernel's interfaces related to de=
vice
-power management refer to Documentation/power/devices.txt and
+power management refer to Documentation/power/admin-guide/devices.rst and
 Documentation/power/runtime_pm.txt.
=20
 --------------------------------------------------------------------------=
-
@@ -417,7 +417,7 @@ pm->runtime_idle() callback.
 2.4. System-Wide Power Transitions
 ----------------------------------
 There are a few different types of system-wide power transitions, describe=
d in
-Documentation/power/devices.txt.  Each of them requires devices to be hand=
led
+Documentation/power/admin-guide/devices.rst.  Each of them requires device=
s to be handled
 in a specific way and the PM core executes subsystem-level power managemen=
t
 callbacks for this purpose.  They are executed in phases such that each ph=
ase
 involves executing the same subsystem-level callback for every device belo=
nging
@@ -623,7 +623,7 @@ System restore requires a hibernation image to be loade=
d into memory and the
 pre-hibernation memory contents to be restored before the pre-hibernation =
system
 activity can be resumed.
=20
-As described in Documentation/power/devices.txt, the hibernation image is =
loaded
+As described in Documentation/power/admin-guide/devices.rst, the hibernati=
on image is loaded
 into memory by a fresh instance of the kernel, called the boot kernel, whi=
ch in
 turn is loaded and run by a boot loader in the usual way.  After the boot =
kernel
 has loaded the image, it needs to replace its own code and data with the c=
ode
@@ -677,7 +677,7 @@ controlling the runtime power management of their devic=
es.
=20
 At the time of this writing there are two ways to define power management
 callbacks for a PCI device driver, the recommended one, based on using a
-dev_pm_ops structure described in Documentation/power/devices.txt, and the
+dev_pm_ops structure described in Documentation/power/admin-guide/devices.=
rst, and the
 "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), a=
nd
 .resume() callbacks from struct pci_driver are used.  The legacy approach,
 however, doesn't allow one to define runtime power management callbacks an=
d is
@@ -1046,5 +1046,5 @@ PCI Local Bus Specification, Rev. 3.0
 PCI Bus Power Management Interface Specification, Rev. 1.2
 Advanced Configuration and Power Interface (ACPI) Specification, Rev. 3.0b
 PCI Express Base Specification, Rev. 2.0
-Documentation/power/devices.txt
+Documentation/power/admin-guide/devices.rst
 Documentation/power/runtime_pm.txt
diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runti=
me_pm.txt
index 1fd1fbe9ce95..4870980e967e 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -674,7 +674,7 @@ left in runtime suspend.  If that happens, the PM core =
will not execute any
 system suspend and resume callbacks for all of those devices, except for t=
he
 complete callback, which is then entirely responsible for handling the dev=
ice
 as appropriate.  This only applies to system suspend transitions that are =
not
-related to hibernation (see Documentation/power/devices.txt for more
+related to hibernation (see Documentation/power/admin-guide/devices.rst fo=
r more
 information).
=20
 The PM core does its best to reduce the probability of race conditions bet=
ween
diff --git a/Documentation/power/swsusp-dmcrypt.txt b/Documentation/power/s=
wsusp-dmcrypt.txt
index 59931b46ff7e..b802fbfd95ef 100644
--- a/Documentation/power/swsusp-dmcrypt.txt
+++ b/Documentation/power/swsusp-dmcrypt.txt
@@ -8,7 +8,7 @@ Some prerequisites:
 You know how dm-crypt works. If not, visit the following web page:
 http://www.saout.de/misc/dm-crypt/
 You have read Documentation/power/swsusp.txt and understand it.
-You did read Documentation/initrd.txt and know how an initrd works.
+You did read Documentation/admin-guide/initrd.rst and know how an initrd w=
orks.
 You know how to create or how to modify an initrd.
=20
 Now your system is properly set up, your disk is encrypted except for
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.C=
oding.rst
index 9d5cef996f7f..983d628c1112 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -22,7 +22,7 @@ Coding style
 ************
=20
 The kernel has long had a standard coding style, described in
-Documentation/CodingStyle.  For much of that time, the policies described
+Documentation/process/coding-style.rst.  For much of that time, the polici=
es described
 in that file were taken as being, at most, advisory.  As a result, there i=
s
 a substantial amount of code in the kernel which does not meet the coding
 style guidelines.  The presence of that code leads to two independent
@@ -343,7 +343,7 @@ user-space developers to know what they are working wit=
h.  See
 Documentation/ABI/README for a description of how this documentation shoul=
d
 be formatted and what information needs to be provided.
=20
-The file Documentation/kernel-parameters.txt describes all of the kernel's
+The file Documentation/admin-guide/kernel-parameters.rst describes all of =
the kernel's
 boot-time parameters.  Any patch which adds new parameters should add the
 appropriate entries to this file.
=20
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.=
Posting.rst
index b511ddf7e82a..1b7728b19ea7 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -9,8 +9,8 @@ kernel.  Unsurprisingly, the kernel development community h=
as evolved a set
 of conventions and procedures which are used in the posting of patches;
 following them will make life much easier for everybody involved.  This
 document will attempt to cover these expectations in reasonable detail;
-more information can also be found in the files SubmittingPatches,
-SubmittingDrivers, and SubmitChecklist in the kernel documentation
+more information can also be found in the files process/submitting-patches=
.rst,
+process/submitting-drivers.rst, and process/submit-checklist.rst in the ke=
rnel documentation
 directory.
=20
=20
@@ -198,7 +198,7 @@ pass it to diff with the "-X" option.
=20
 The tags mentioned above are used to describe how various developers have
 been associated with the development of this patch.  They are described in
-detail in the SubmittingPatches document; what follows here is a brief
+detail in the process/submitting-patches.rst document; what follows here i=
s a brief
 summary.  Each of these lines has the format:
=20
 ::
@@ -210,7 +210,7 @@ The tags in common use are:
  - Signed-off-by: this is a developer's certification that he or she has
    the right to submit the patch for inclusion into the kernel.  It is an
    agreement to the Developer's Certificate of Origin, the full text of
-   which can be found in Documentation/SubmittingPatches.  Code without a
+   which can be found in Documentation/process/submitting-patches.rst.  Co=
de without a
    proper signoff cannot be merged into the mainline.
=20
  - Acked-by: indicates an agreement by another developer (often a
@@ -221,7 +221,7 @@ The tags in common use are:
    it to work.
=20
  - Reviewed-by: the named developer has reviewed the patch for correctness=
;
-   see the reviewer's statement in Documentation/SubmittingPatches for mor=
e
+   see the reviewer's statement in Documentation/process/submitting-patche=
s.rst for more
    detail.
=20
  - Reported-by: names a user who reported a problem which is fixed by this
@@ -248,7 +248,7 @@ take care of:
    be examined in any detail.  If there is any doubt at all, mail the patc=
h
    to yourself and convince yourself that it shows up intact.
=20
-   Documentation/email-clients.txt has some helpful hints on making
+   Documentation/process/email-clients.rst has some helpful hints on makin=
g
    specific mail clients work for sending patches.
=20
  - Are you sure your patch is free of silly mistakes?  You should always
diff --git a/Documentation/process/8.Conclusion.rst b/Documentation/process=
/8.Conclusion.rst
index 23ec7cbc2d2b..1c7f54cd0261 100644
--- a/Documentation/process/8.Conclusion.rst
+++ b/Documentation/process/8.Conclusion.rst
@@ -5,9 +5,9 @@ For more information
=20
 There are numerous sources of information on Linux kernel development and
 related topics.  First among those will always be the Documentation
-directory found in the kernel source distribution.  The top-level HOWTO
-file is an important starting point; SubmittingPatches and
-SubmittingDrivers are also something which all kernel developers should
+directory found in the kernel source distribution.  The top-level process/=
howto.rst
+file is an important starting point; process/submitting-patches.rst and
+process/submitting-drivers.rst are also something which all kernel develop=
ers should
 read.  Many internal kernel APIs are documented using the kerneldoc
 mechanism; "make htmldocs" or "make pdfdocs" can be used to generate those
 documents in HTML or PDF format (though the version of TeX shipped by some
diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/proc=
ess/adding-syscalls.rst
index f5b5b1aa51b3..8cc25a06f353 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -3,7 +3,7 @@ Adding a New System Call
=20
 This document describes what's involved in adding a new system call to the
 Linux kernel, over and above the normal submission advice in
-:ref:`Documentation/SubmittingPatches <submittingpatches>`.
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
=20
=20
 System Call Alternatives
diff --git a/Documentation/process/coding-style.rst b/Documentation/process=
/coding-style.rst
index 9c61c039ccd9..968808bec407 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1058,5 +1058,5 @@ gcc internals and indent, all available from http://w=
ww.gnu.org/manual/
 WG14 is the international standardization working group for the programmin=
g
 language C, URL: http://www.open-std.org/JTC1/SC22/WG14/
=20
-Kernel CodingStyle, by greg@kroah.com at OLS 2002:
+Kernel process/coding-style.rst, by greg@kroah.com at OLS 2002:
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.=
rst
index 5f042349f987..3f66a1980726 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -90,19 +90,19 @@ required reading:
     what is necessary to do to configure and build the kernel.  People
     who are new to the kernel should start here.
=20
-  :ref:`Documentation/Changes <changes>`
+  :ref:`Documentation/process/changes.rst <changes>`
     This file gives a list of the minimum levels of various software
     packages that are necessary to build and run the kernel
     successfully.
=20
-  :ref:`Documentation/CodingStyle <codingstyle>`
+  :ref:`Documentation/process/coding-style.rst <codingstyle>`
     This describes the Linux kernel coding style, and some of the
     rationale behind it. All new code is expected to follow the
     guidelines in this document. Most maintainers will only accept
     patches if these rules are followed, and many people will only
     review code if it is in the proper style.
=20
-  :ref:`Documentation/SubmittingPatches <submittingpatches>` and :ref:`Doc=
umentation/SubmittingDrivers <submittingdrivers>`
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` =
and :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
     These files describe in explicit detail how to successfully create
     and send a patch, including (but not limited to):
=20
@@ -122,7 +122,7 @@ required reading:
 	"Linux kernel patch submission format"
 		http://linux.yyz.us/patch-format.html
=20
-  :ref:`Documentation/stable_api_nonsense.txt <stable_api_nonsense>`
+  :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense=
>`
     This file describes the rationale behind the conscious decision to
     not have a stable API within the kernel, including things like:
=20
@@ -135,29 +135,29 @@ required reading:
     philosophy and is very important for people moving to Linux from
     development on other Operating Systems.
=20
-  :ref:`Documentation/SecurityBugs <securitybugs>`
+  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
     If you feel you have found a security problem in the Linux kernel,
     please follow the steps in this document to help notify the kernel
     developers, and help solve the issue.
=20
-  :ref:`Documentation/ManagementStyle <managementstyle>`
+  :ref:`Documentation/process/management-style.rst <managementstyle>`
     This document describes how Linux kernel maintainers operate and the
     shared ethos behind their methodologies.  This is important reading
     for anyone new to kernel development (or anyone simply curious about
     it), as it resolves a lot of common misconceptions and confusion
     about the unique behavior of kernel maintainers.
=20
-  :ref:`Documentation/stable_kernel_rules.txt <stable_kernel_rules>`
+  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules=
>`
     This file describes the rules on how the stable kernel releases
     happen, and what to do if you want to get a change into one of these
     releases.
=20
-  :ref:`Documentation/kernel-docs.txt <kernel_docs>`
+  :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
     A list of external documentation that pertains to kernel
     development.  Please consult this list if you do not find what you
     are looking for within the in-kernel documentation.
=20
-  :ref:`Documentation/applying-patches.txt <applying_patches>`
+  :ref:`Documentation/process/applying-patches.rst <applying_patches>`
     A good introduction describing exactly what a patch is and how to
     apply it to the different development branches of the kernel.
=20
@@ -307,7 +307,7 @@ two weeks, but it can be longer if there are no pressin=
g problems.  A
 security-related problem, instead, can cause a release to happen almost
 instantly.
=20
-The file Documentation/stable_kernel_rules.txt in the kernel tree
+The file Documentation/process/stable-kernel-rules.rst in the kernel tree
 documents what kinds of changes are acceptable for the -stable tree, and
 how the release process works.
=20
@@ -366,7 +366,7 @@ tool.  For details on how to use the kernel bugzilla, p=
lease see:
=20
 	https://bugzilla.kernel.org/page.cgi?id=3Dfaq.html
=20
-The file REPORTING-BUGS in the main kernel source directory has a good
+The file admin-guide/reporting-bugs.rst in the main kernel source director=
y has a good
 template for how to report a possible kernel bug, and details what kind
 of information is needed by the kernel developers to help track down the
 problem.
@@ -440,7 +440,7 @@ add your statements between the individual quoted secti=
ons instead of
 writing at the top of the mail.
=20
 If you add patches to your mail, make sure they are plain readable text
-as stated in Documentation/SubmittingPatches.
+as stated in Documentation/process/submitting-patches.rst.
 Kernel developers don't want to deal with
 attachments or compressed patches; they may want to comment on
 individual lines of your patch, which works only that way. Make sure you
diff --git a/Documentation/process/management-style.rst b/Documentation/pro=
cess/management-style.rst
index dea2e66c9a10..45595fd8a66b 100644
--- a/Documentation/process/management-style.rst
+++ b/Documentation/process/management-style.rst
@@ -5,7 +5,7 @@ Linux kernel management style
=20
 This is a short document describing the preferred (or made up, depending
 on who you ask) management style for the linux kernel.  It's meant to
-mirror the CodingStyle document to some degree, and mainly written to
+mirror the process/coding-style.rst document to some degree, and mainly wr=
itten to
 avoid answering [#f1]_  the same (or similar) questions over and over agai=
n.
=20
 Management style is very personal and much harder to quantify than
diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/=
process/stable-kernel-rules.rst
index 4d82e31b7958..11ec2d93a5e0 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -27,7 +27,7 @@ Rules on what kind of patches are accepted, and which one=
s are not, into the
  - It cannot contain any "trivial" fixes in it (spelling changes,
    whitespace cleanups, etc).
  - It must follow the
-   :ref:`Documentation/SubmittingPatches <submittingpatches>`
+   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
    rules.
  - It or an equivalent fix must already exist in Linus' tree (upstream).
=20
@@ -40,7 +40,7 @@ Procedure for submitting patches to the -stable tree
    Documentation/networking/netdev-FAQ.txt
  - Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
-   :ref:`Documentation/SecurityBugs <securitybugs>`.
+   :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
=20
 For all other submissions, choose one of the following procedures
 -----------------------------------------------------------------
diff --git a/Documentation/process/submit-checklist.rst b/Documentation/pro=
cess/submit-checklist.rst
index 894289b22b15..a0d9d34bfb6d 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -7,7 +7,7 @@ Here are some basic things that developers should do if the=
y want to see their
 kernel patch submissions accepted more quickly.
=20
 These are all above and beyond the documentation that is provided in
-:ref:`Documentation/SubmittingPatches <submittingpatches>`
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 and elsewhere regarding submitting Linux kernel patches.
=20
=20
@@ -31,7 +31,7 @@ and elsewhere regarding submitting Linux kernel patches.
    tends to use ``unsigned long`` for 64-bit quantities.
=20
 5) Check your patch for general style as detailed in
-   :ref:`Documentation/CodingStyle <codingstyle>`.
+   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
    Check for trivial violations with the patch style checker prior to
    submission (``scripts/checkpatch.pl``).
    You should be able to justify all violations that remain in
@@ -78,7 +78,7 @@ and elsewhere regarding submitting Linux kernel patches.
 16) All new ``/proc`` entries are documented under ``Documentation/``
=20
 17) All new kernel boot parameters are documented in
-    ``Documentation/kernel-parameters.txt``.
+    ``Documentation/admin-guide/kernel-parameters.rst``.
=20
 18) All new module parameters are documented with ``MODULE_PARM_DESC()``
=20
diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/p=
rocess/submitting-drivers.rst
index 252b77a23fad..0939d018c289 100644
--- a/Documentation/process/submitting-drivers.rst
+++ b/Documentation/process/submitting-drivers.rst
@@ -8,7 +8,7 @@ various kernel trees. Note that if you are interested in vi=
deo card drivers
 you should probably talk to XFree86 (http://www.xfree86.org/) and/or X.Org
 (http://x.org/) instead.
=20
-Also read the Documentation/SubmittingPatches document.
+Also read the Documentation/process/submitting-patches.rst document.
=20
=20
 Allocating Device Numbers
@@ -19,7 +19,7 @@ by the Linux assigned name and number authority (currentl=
y this is
 Torben Mathiasen). The site is http://www.lanana.org/. This
 also deals with allocating numbers for devices that are not going to
 be submitted to the mainstream kernel.
-See Documentation/devices.txt for more information on this.
+See Documentation/admin-guide/devices.rst for more information on this.
=20
 If you don't use assigned numbers then when your device is submitted it wi=
ll
 be given an assigned number even if that is different from values you may
@@ -73,7 +73,7 @@ Interfaces:
=20
 Code:
 		Please use the Linux style of code formatting as documented
-		in :ref:`Documentation/CodingStyle <codingStyle>`.
+		in :ref:`Documentation/process/coding-style.rst <codingStyle>`.
 		If you have sections of code
 		that need to be in other formats, for example because they
 		are shared with a windows driver kit and you want to
@@ -109,7 +109,7 @@ PM support:
 		anything.  For the driver testing instructions see
 		Documentation/power/drivers-testing.txt and for a relatively
 		complete overview of the power management issues related to
-		drivers see Documentation/power/devices.txt .
+		drivers see Documentation/power/admin-guide/devices.rst .
=20
 Control:
 		In general if there is active maintenance of a driver by
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/p=
rocess/submitting-patches.rst
index e62ddcdcaf5d..e12ecf99b485 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -11,10 +11,10 @@ can greatly increase the chances of your change being a=
ccepted.
 This document contains a large number of suggestions in a relatively terse
 format.  For detailed information on how the kernel development process
 works, see :ref:`Documentation/process <development_process_main>`.
-Also, read :ref:`Documentation/SubmitChecklist <submitchecklist>`
+Also, read :ref:`Documentation/process/submit-checklist.rst <submitcheckli=
st>`
 for a list of items to check before
 submitting code.  If you are submitting a driver, also read
-:ref:`Documentation/SubmittingDrivers <submittingdrivers>`;
+:ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`;
 for device tree binding patches, read
 Documentation/devicetree/bindings/submitting-patches.txt.
=20
@@ -238,7 +238,7 @@ then only post say 15 or so at a time and wait for revi=
ew and integration.
=20
 Check your patch for basic style violations, details of which can be
 found in
-:ref:`Documentation/CodingStyle <codingstyle>`.
+:ref:`Documentation/process/coding-style.rst <codingstyle>`.
 Failure to do so simply wastes
 the reviewers time and will get your patch rejected, probably
 without even being read.
@@ -305,7 +305,7 @@ toward the stable maintainers by putting a line like th=
is::
=20
 into the sign-off area of your patch (note, NOT an email recipient).  You
 should also read
-:ref:`Documentation/stable_kernel_rules.txt <stable_kernel_rules>`
+:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
 in addition to this file.
=20
 Note, however, that some subsystem maintainers want to come to their own
@@ -363,7 +363,7 @@ decreasing the likelihood of your MIME-attached change =
being accepted.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME.
=20
-See :ref:`Documentation/email-clients.txt <email_clients>`
+See :ref:`Documentation/process/email-clients.rst <email_clients>`
 for hints about configuring your e-mail client so that it sends your patch=
es
 untouched.
=20
@@ -828,8 +828,8 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem=
 maintainer".
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lkml.org/lkml/2005/7/11/336>
=20
-Kernel Documentation/CodingStyle:
-  :ref:`Documentation/CodingStyle <codingstyle>`
+Kernel Documentation/process/coding-style.rst:
+  :ref:`Documentation/process/coding-style.rst <codingstyle>`
=20
 Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
diff --git a/Documentation/rfkill.txt b/Documentation/rfkill.txt
index 1f0c27049340..8c174063b3f0 100644
--- a/Documentation/rfkill.txt
+++ b/Documentation/rfkill.txt
@@ -26,7 +26,7 @@ whether they can be changed or not:
                the system software.
=20
 The rfkill subsystem has two parameters, rfkill.default_state and
-rfkill.master_switch_mode, which are documented in kernel-parameters.txt.
+rfkill.master_switch_mode, which are documented in admin-guide/kernel-para=
meters.rst.
=20
=20
 2. Implementation details
diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/sc=
si-parameters.txt
index 8e66dafa41e1..8477655c0e46 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.txt
@@ -1,7 +1,7 @@
                           SCSI Kernel Parameters
                           ~~~~~~~~~~~~~~~~~~~~~~
=20
-See Documentation/kernel-parameters.txt for general information on
+See Documentation/admin-guide/kernel-parameters.rst for general informatio=
n on
 specifying module parameters.
=20
 This document may not be entirely up to date and comprehensive. The comman=
d
diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/s=
csi_mid_low_api.txt
index 255075157511..0ce6045dfc1f 100644
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ b/Documentation/scsi/scsi_mid_low_api.txt
@@ -336,7 +336,7 @@ in parallel by these functions.
 Conventions
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 First, Linus Torvalds's thoughts on C coding style can be found in the
-Documentation/CodingStyle file.=20
+Documentation/process/coding-style.rst file.=20
=20
 Next, there is a movement to "outlaw" typedefs introducing synonyms for=20
 struct tags. Both can be still found in the SCSI subsystem, but
diff --git a/Documentation/scsi/sym53c8xx_2.txt b/Documentation/scsi/sym53c=
8xx_2.txt
index 6af8f7a7770f..d28186553fb0 100644
--- a/Documentation/scsi/sym53c8xx_2.txt
+++ b/Documentation/scsi/sym53c8xx_2.txt
@@ -427,7 +427,7 @@ Synchronous transfers frequency       (default answer: =
80)
 10.1 Syntax
=20
 Setup commands can be passed to the driver either at boot time or as
-parameters to modprobe, as described in Documentation/kernel-parameters.tx=
t
+parameters to modprobe, as described in Documentation/admin-guide/kernel-p=
arameters.rst
=20
 Example of boot setup command under lilo prompt:
=20
diff --git a/Documentation/sound/alsa/alsa-parameters.txt b/Documentation/s=
ound/alsa/alsa-parameters.txt
index 0fa40679b080..72eced86f035 100644
--- a/Documentation/sound/alsa/alsa-parameters.txt
+++ b/Documentation/sound/alsa/alsa-parameters.txt
@@ -1,7 +1,7 @@
                           ALSA Kernel Parameters
                           ~~~~~~~~~~~~~~~~~~~~~~
=20
-See Documentation/kernel-parameters.txt for general information on
+See Documentation/admin-guide/kernel-parameters.rst for general informatio=
n on
 specifying module parameters.
=20
 This document may not be entirely up to date and comprehensive. The comman=
d
diff --git a/Documentation/sound/oss/oss-parameters.txt b/Documentation/sou=
nd/oss/oss-parameters.txt
index 3ab391e7c295..cc675f25eee4 100644
--- a/Documentation/sound/oss/oss-parameters.txt
+++ b/Documentation/sound/oss/oss-parameters.txt
@@ -1,7 +1,7 @@
                           OSS Kernel Parameters
                           ~~~~~~~~~~~~~~~~~~~~~
=20
-See Documentation/kernel-parameters.txt for general information on
+See Documentation/admin-guide/kernel-parameters.rst for general informatio=
n on
 specifying module parameters.
=20
 This document may not be entirely up to date and comprehensive. The comman=
d
diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.=
txt
index ffab8b5caa60..6bb78f872929 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -71,7 +71,7 @@ show up in /proc/sys/kernel:
 - printk_ratelimit_burst
 - pty                         =3D=3D> Documentation/filesystems/devpts.txt
 - randomize_va_space
-- real-root-dev               =3D=3D> Documentation/initrd.txt
+- real-root-dev               =3D=3D> Documentation/admin-guide/initrd.rst
 - reboot-cmd                  [ SPARC only ]
 - rtsig-max
 - rtsig-nr
@@ -453,7 +453,7 @@ in a KVM virtual machine. This default can be overridde=
n by adding
=20
    nmi_watchdog=3D1
=20
-to the guest kernel command line (see Documentation/kernel-parameters.txt)=
.
+to the guest kernel command line (see Documentation/admin-guide/kernel-par=
ameters.rst).
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/virtual/kvm/review-checklist.txt b/Documentation=
/virtual/kvm/review-checklist.txt
index a850986ed684..a83b27635fdd 100644
--- a/Documentation/virtual/kvm/review-checklist.txt
+++ b/Documentation/virtual/kvm/review-checklist.txt
@@ -1,8 +1,8 @@
 Review checklist for kvm patches
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
-1.  The patch must follow Documentation/CodingStyle and
-    Documentation/SubmittingPatches.
+1.  The patch must follow Documentation/process/coding-style.rst and
+    Documentation/process/submitting-patches.rst.
=20
 2.  Patches should be against kvm.git master branch.
=20
diff --git a/Documentation/vm/numa b/Documentation/vm/numa
index e0b58c0e6b49..a08f71647714 100644
--- a/Documentation/vm/numa
+++ b/Documentation/vm/numa
@@ -82,7 +82,7 @@ such as DMA or DMA32, represent relatively scarce resourc=
es.  Linux chooses
 a default zonelist order based on the sizes of the various zone types rela=
tive
 to the total memory of the node and the total memory of the system.  The
 default zonelist order may be overridden using the numa_zonelist_order ker=
nel
-boot parameter or sysctl.  [see Documentation/kernel-parameters.txt and
+boot parameter or sysctl.  [see Documentation/admin-guide/kernel-parameter=
s.rst and
 Documentation/sysctl/vm.txt]
=20
 By default, Linux will attempt to satisfy memory allocation requests from =
the
diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.txt b/Doc=
umentation/watchdog/convert_drivers_to_kernel_api.txt
index 271b8850dde7..9fffb2958d13 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.txt
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.txt
@@ -213,6 +213,6 @@ The entry for the driver now needs to select WATCHDOG_C=
ORE:
 Create a patch and send it to upstream
 --------------------------------------
=20
-Make sure you understood Documentation/SubmittingPatches and send your pat=
ch to
+Make sure you understood Documentation/process/submitting-patches.rst and =
send your patch to
 linux-watchdog@vger.kernel.org. We are looking forward to it :)
=20
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation=
/watchdog/watchdog-parameters.txt
index a8d364227a77..e21850e270a0 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -4,7 +4,7 @@ be listed here unless the driver has its own driver-specifi=
c information
 file.
=20
=20
-See Documentation/kernel-parameters.txt for information on
+See Documentation/admin-guide/kernel-parameters.rst for information on
 providing kernel parameters for builtin drivers versus loadable
 modules.
=20
diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index 9da6f3512249..5e9b826b5f62 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -921,7 +921,7 @@ They should normally not be deleted from the kernel com=
mand line even
 though not all of them are actually meaningful to the kernel.  Boot
 loader authors who need additional command line options for the boot
 loader itself should get them registered in
-Documentation/kernel-parameters.txt to make sure they will not
+Documentation/admin-guide/kernel-parameters.rst to make sure they will not
 conflict with actual kernel options now or in the future.
=20
   vga=3D<mode>
diff --git a/Documentation/zh_CN/CodingStyle b/Documentation/zh_CN/CodingSt=
yle
index 12717791baac..b02738042799 100644
--- a/Documentation/zh_CN/CodingStyle
+++ b/Documentation/zh_CN/CodingStyle
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/CodingStyle
+Chinese translated version of Documentation/process/coding-style.rst
=20
 If you have any comment or update to the content, please post to LKML dire=
ctly.
 However, if you have problem communicating in English you can also ask the
@@ -7,7 +7,7 @@ translation is outdated or there is problem with translatio=
n.
=20
 Chinese maintainer: Zhang Le <r0bertz@gentoo.org>
 ---------------------------------------------------------------------
-Documentation/CodingStyle=E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=91
+Documentation/process/coding-style.rst=E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=
=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E5=8F=91=E4=BF=A1=E5=88=B0LKML=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=
=E4=BD=BF=E7=94=A8=E8=8B=B1=E6=96=87=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=
=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=E4=B9=9F=E5=8F=AF
 =E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=
=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=BB=E8=AF=91=E6=
=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=E7=BF=BB=E8=AF=
=91=E5=AD=98=E5=9C=A8=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=B7=E8=81=94=E7=B3=BB=
=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=E3=80=82
@@ -809,5 +809,5 @@ GNU =E6=89=8B=E5=86=8C - =E9=81=B5=E5=BE=AA K&R =E6=A0=
=87=E5=87=86=E5=92=8C=E6=AD=A4=E6=96=87=E6=9C=AC - cpp, gcc, gcc internals =
and indent,
=20
 WG14=E6=98=AFC=E8=AF=AD=E8=A8=80=E7=9A=84=E5=9B=BD=E9=99=85=E6=A0=87=E5=87=
=86=E5=8C=96=E5=B7=A5=E4=BD=9C=E7=BB=84=EF=BC=8CURL: http://www.open-std.or=
g/JTC1/SC22/WG14/
=20
-Kernel CodingStyle=EF=BC=8C=E4=BD=9C=E8=80=85 greg@kroah.com =E5=8F=91=E8=
=A1=A8=E4=BA=8EOLS 2002=EF=BC=9A
+Kernel process/coding-style.rst=EF=BC=8C=E4=BD=9C=E8=80=85 greg@kroah.com =
=E5=8F=91=E8=A1=A8=E4=BA=8EOLS 2002=EF=BC=9A
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
diff --git a/Documentation/zh_CN/HOWTO b/Documentation/zh_CN/HOWTO
index f0613b92e0be..11be075ba5fa 100644
--- a/Documentation/zh_CN/HOWTO
+++ b/Documentation/zh_CN/HOWTO
@@ -1,4 +1,4 @@
-=EF=BB=BFChinese translated version of Documentation/HOWTO
+=EF=BB=BFChinese translated version of Documentation/process/howto.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -9,7 +9,7 @@ or if there is a problem with the translation.
 Maintainer: Greg Kroah-Hartman <greg@kroah.com>
 Chinese maintainer: Li Yang <leoli@freescale.com>
 ---------------------------------------------------------------------
-Documentation/HOWTO =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=91
+Documentation/process/howto.rst =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=
=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -93,16 +93,16 @@ Linux=E5=86=85=E6=A0=B8=E4=BB=A3=E7=A0=81=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=
=82=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E5=AD=A6=E4=B9=A0=
=E5=A6=82=E4=BD=95=E4=B8=8E
     =E6=96=87=E4=BB=B6=E7=AE=80=E8=A6=81=E4=BB=8B=E7=BB=8D=E4=BA=86Linux=
=E5=86=85=E6=A0=B8=E7=9A=84=E8=83=8C=E6=99=AF=EF=BC=8C=E5=B9=B6=E4=B8=94=E6=
=8F=8F=E8=BF=B0=E4=BA=86=E5=A6=82=E4=BD=95=E9=85=8D=E7=BD=AE=E5=92=8C=E7=BC=
=96=E8=AF=91=E5=86=85=E6=A0=B8=E3=80=82=E5=86=85=E6=A0=B8=E7=9A=84
     =E6=96=B0=E7=94=A8=E6=88=B7=E5=BA=94=E8=AF=A5=E4=BB=8E=E8=BF=99=E9=87=
=8C=E5=BC=80=E5=A7=8B=E3=80=82
=20
-  Documentation/Changes
+  Documentation/process/changes.rst
     =E6=96=87=E4=BB=B6=E7=BB=99=E5=87=BA=E4=BA=86=E7=94=A8=E6=9D=A5=E7=BC=
=96=E8=AF=91=E5=92=8C=E4=BD=BF=E7=94=A8=E5=86=85=E6=A0=B8=E6=89=80=E9=9C=80=
=E8=A6=81=E7=9A=84=E6=9C=80=E5=B0=8F=E8=BD=AF=E4=BB=B6=E5=8C=85=E5=88=97=E8=
=A1=A8=E3=80=82
=20
-  Documentation/CodingStyle
+  Documentation/process/coding-style.rst
     =E6=8F=8F=E8=BF=B0Linux=E5=86=85=E6=A0=B8=E7=9A=84=E4=BB=A3=E7=A0=81=
=E9=A3=8E=E6=A0=BC=E5=92=8C=E7=90=86=E7=94=B1=E3=80=82=E6=89=80=E6=9C=89=E6=
=96=B0=E4=BB=A3=E7=A0=81=E9=9C=80=E8=A6=81=E9=81=B5=E5=AE=88=E8=BF=99=E7=AF=
=87=E6=96=87=E6=A1=A3=E4=B8=AD=E5=AE=9A=E4=B9=89=E7=9A=84=E8=A7=84
     =E8=8C=83=E3=80=82=E5=A4=A7=E5=A4=9A=E6=95=B0=E7=BB=B4=E6=8A=A4=E8=80=
=85=E5=8F=AA=E4=BC=9A=E6=8E=A5=E6=94=B6=E7=AC=A6=E5=90=88=E8=A7=84=E5=AE=9A=
=E7=9A=84=E8=A1=A5=E4=B8=81=EF=BC=8C=E5=BE=88=E5=A4=9A=E4=BA=BA=E4=B9=9F=E5=
=8F=AA=E4=BC=9A=E5=B8=AE=E5=BF=99=E6=A3=80=E6=9F=A5=E7=AC=A6=E5=90=88=E9=A3=
=8E=E6=A0=BC
     =E7=9A=84=E4=BB=A3=E7=A0=81=E3=80=82
=20
-  Documentation/SubmittingPatches
-  Documentation/SubmittingDrivers
+  Documentation/process/submitting-patches.rst
+  Documentation/process/submitting-drivers.rst
     =E8=BF=99=E4=B8=A4=E4=BB=BD=E6=96=87=E6=A1=A3=E6=98=8E=E7=A1=AE=E6=8F=
=8F=E8=BF=B0=E5=A6=82=E4=BD=95=E5=88=9B=E5=BB=BA=E5=92=8C=E5=8F=91=E9=80=81=
=E8=A1=A5=E4=B8=81=EF=BC=8C=E5=85=B6=E4=B8=AD=E5=8C=85=E6=8B=AC=EF=BC=88=E4=
=BD=86=E4=B8=8D=E4=BB=85=E9=99=90=E4=BA=8E)=EF=BC=9A
        - =E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9
        - =E9=82=AE=E4=BB=B6=E6=A0=BC=E5=BC=8F
@@ -116,7 +116,7 @@ Linux=E5=86=85=E6=A0=B8=E4=BB=A3=E7=A0=81=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=
=82=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E5=AD=A6=E4=B9=A0=
=E5=A6=82=E4=BD=95=E4=B8=8E
     "Linux kernel patch submission format"
         http://linux.yyz.us/patch-format.html
=20
-  Documentation/stable_api_nonsense.txt
+  Documentation/process/stable-api-nonsense.rst
     =E8=AE=BA=E8=AF=81=E5=86=85=E6=A0=B8=E4=B8=BA=E4=BB=80=E4=B9=88=E7=89=
=B9=E6=84=8F=E4=B8=8D=E5=8C=85=E6=8B=AC=E7=A8=B3=E5=AE=9A=E7=9A=84=E5=86=85=
=E6=A0=B8=E5=86=85=E9=83=A8API=EF=BC=8C=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4=
=E4=B8=8D=E5=8C=85=E6=8B=AC=E5=83=8F=E8=BF=99=E6=A0=B7=E7=9A=84=E7=89=B9
     =E6=80=A7=EF=BC=9A
        - =E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B8=AD=E9=97=B4=E5=B1=82=EF=BC=88=
=E4=B8=BA=E4=BA=86=E5=85=BC=E5=AE=B9=E6=80=A7=EF=BC=9F=EF=BC=89
@@ -125,23 +125,23 @@ Linux=E5=86=85=E6=A0=B8=E4=BB=A3=E7=A0=81=E4=B8=AD=E5=
=8C=85=E5=90=AB=E6=9C=89=E5=A4=A7=E9=87=8F=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=
=82=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E5=AD=A6=E4=B9=A0=
=E5=A6=82=E4=BD=95=E4=B8=8E
     =E8=BF=99=E7=AF=87=E6=96=87=E6=A1=A3=E5=AF=B9=E4=BA=8E=E7=90=86=E8=A7=
=A3Linux=E7=9A=84=E5=BC=80=E5=8F=91=E5=93=B2=E5=AD=A6=E8=87=B3=E5=85=B3=E9=
=87=8D=E8=A6=81=E3=80=82=E5=AF=B9=E4=BA=8E=E5=B0=86=E5=BC=80=E5=8F=91=E5=B9=
=B3=E5=8F=B0=E4=BB=8E=E5=85=B6=E4=BB=96=E6=93=8D=E4=BD=9C=E7=B3=BB
     =E7=BB=9F=E8=BD=AC=E7=A7=BB=E5=88=B0Linux=E7=9A=84=E4=BA=BA=E6=9D=A5=
=E8=AF=B4=E4=B9=9F=E5=BE=88=E9=87=8D=E8=A6=81=E3=80=82
=20
-  Documentation/SecurityBugs
+  Documentation/admin-guide/security-bugs.rst
     =E5=A6=82=E6=9E=9C=E4=BD=A0=E8=AE=A4=E4=B8=BA=E8=87=AA=E5=B7=B1=E5=8F=
=91=E7=8E=B0=E4=BA=86Linux=E5=86=85=E6=A0=B8=E7=9A=84=E5=AE=89=E5=85=A8=E6=
=80=A7=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=B7=E6=A0=B9=E6=8D=AE=E8=BF=99=E7=AF=
=87=E6=96=87=E6=A1=A3=E4=B8=AD=E7=9A=84=E6=AD=A5=E9=AA=A4=E6=9D=A5
     =E6=8F=90=E9=86=92=E5=85=B6=E4=BB=96=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=
=91=E8=80=85=E5=B9=B6=E5=B8=AE=E5=8A=A9=E8=A7=A3=E5=86=B3=E8=BF=99=E4=B8=AA=
=E9=97=AE=E9=A2=98=E3=80=82
=20
-  Documentation/ManagementStyle
+  Documentation/process/management-style.rst
     =E6=8F=8F=E8=BF=B0=E5=86=85=E6=A0=B8=E7=BB=B4=E6=8A=A4=E8=80=85=E7=9A=
=84=E5=B7=A5=E4=BD=9C=E6=96=B9=E6=B3=95=E5=8F=8A=E5=85=B6=E5=85=B1=E6=9C=89=
=E7=89=B9=E7=82=B9=E3=80=82=E8=BF=99=E5=AF=B9=E4=BA=8E=E5=88=9A=E5=88=9A=E6=
=8E=A5=E8=A7=A6=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=EF=BC=88=E6=88=96=E8=80=
=85=E5=AF=B9
     =E5=AE=83=E6=84=9F=E5=88=B0=E5=A5=BD=E5=A5=87=EF=BC=89=E7=9A=84=E4=BA=
=BA=E6=9D=A5=E8=AF=B4=E5=BE=88=E9=87=8D=E8=A6=81=EF=BC=8C=E5=9B=A0=E4=B8=BA=
=E5=AE=83=E8=A7=A3=E9=87=8A=E4=BA=86=E5=BE=88=E5=A4=9A=E5=AF=B9=E4=BA=8E=E5=
=86=85=E6=A0=B8=E7=BB=B4=E6=8A=A4=E8=80=85=E7=8B=AC=E7=89=B9=E8=A1=8C=E4=B8=
=BA=E7=9A=84
     =E6=99=AE=E9=81=8D=E8=AF=AF=E8=A7=A3=E4=B8=8E=E8=BF=B7=E6=83=91=E3=80=
=82
=20
-  Documentation/stable_kernel_rules.txt
+  Documentation/process/stable-kernel-rules.rst
     =E8=A7=A3=E9=87=8A=E4=BA=86=E7=A8=B3=E5=AE=9A=E7=89=88=E5=86=85=E6=A0=
=B8=E5=8F=91=E5=B8=83=E7=9A=84=E8=A7=84=E5=88=99=EF=BC=8C=E4=BB=A5=E5=8F=8A=
=E5=A6=82=E4=BD=95=E5=B0=86=E6=94=B9=E5=8A=A8=E6=94=BE=E5=85=A5=E8=BF=99=E4=
=BA=9B=E7=89=88=E6=9C=AC=E7=9A=84=E6=AD=A5=E9=AA=A4=E3=80=82
=20
-  Documentation/kernel-docs.txt
+  Documentation/process/kernel-docs.rst
     =E6=9C=89=E5=8A=A9=E4=BA=8E=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E7=9A=
=84=E5=A4=96=E9=83=A8=E6=96=87=E6=A1=A3=E5=88=97=E8=A1=A8=E3=80=82=E5=A6=82=
=E6=9E=9C=E4=BD=A0=E5=9C=A8=E5=86=85=E6=A0=B8=E8=87=AA=E5=B8=A6=E7=9A=84=E6=
=96=87=E6=A1=A3=E4=B8=AD=E6=B2=A1=E6=9C=89=E6=89=BE=E5=88=B0=E4=BD=A0=E6=83=
=B3=E6=89=BE
     =E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E5=8F=AF=E4=BB=A5=E6=9F=A5=E7=9C=
=8B=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E3=80=82
=20
-  Documentation/applying-patches.txt
+  Documentation/process/applying-patches.rst
     =E5=85=B3=E4=BA=8E=E8=A1=A5=E4=B8=81=E6=98=AF=E4=BB=80=E4=B9=88=E4=BB=
=A5=E5=8F=8A=E5=A6=82=E4=BD=95=E5=B0=86=E5=AE=83=E6=89=93=E5=9C=A8=E4=B8=8D=
=E5=90=8C=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E5=88=86=E6=94=AF=E4=B8=8A=E7=
=9A=84=E5=A5=BD=E4=BB=8B=E7=BB=8D
=20
 =E5=86=85=E6=A0=B8=E8=BF=98=E6=8B=A5=E6=9C=89=E5=A4=A7=E9=87=8F=E4=BB=8E=
=E4=BB=A3=E7=A0=81=E8=87=AA=E5=8A=A8=E7=94=9F=E6=88=90=E7=9A=84=E6=96=87=E6=
=A1=A3=E3=80=82=E5=AE=83=E5=8C=85=E5=90=AB=E5=86=85=E6=A0=B8=E5=86=85=E9=83=
=A8API=E7=9A=84=E5=85=A8=E9=9D=A2=E4=BB=8B=E7=BB=8D=E4=BB=A5=E5=8F=8A=E5=A6=
=82=E4=BD=95
@@ -238,7 +238,7 @@ kernel.org=E7=BD=91=E7=AB=99=E7=9A=84pub/linux/kernel/v=
2.6/=E7=9B=AE=E5=BD=95=E4=B8=8B=E6=89=BE=E5=88=B0=E5=AE=83=E3=80=82=E5=AE=
=83=E7=9A=84=E5=BC=80=E5=8F=91=E9=81=B5=E5=BE=AA
 2.6.x.y=E7=89=88=E6=9C=AC=E7=94=B1=E2=80=9C=E7=A8=B3=E5=AE=9A=E7=89=88=E2=
=80=9D=E5=B0=8F=E7=BB=84=EF=BC=88=E9=82=AE=E4=BB=B6=E5=9C=B0=E5=9D=80<stabl=
e@vger.kernel.org>=EF=BC=89=E7=BB=B4=E6=8A=A4=EF=BC=8C=E4=B8=80=E8=88=AC=E9=
=9A=94=E5=91=A8=E5=8F=91
 =E5=B8=83=E6=96=B0=E7=89=88=E6=9C=AC=E3=80=82
=20
-=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E4=B8=AD=E7=9A=84Documentation/stable=
_kernel_rules.txt=E6=96=87=E4=BB=B6=E5=85=B7=E4=BD=93=E6=8F=8F=E8=BF=B0=E4=
=BA=86=E5=8F=AF=E8=A2=AB=E7=A8=B3=E5=AE=9A
+=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E4=B8=AD=E7=9A=84Documentation/proces=
s/stable-kernel-rules.rst=E6=96=87=E4=BB=B6=E5=85=B7=E4=BD=93=E6=8F=8F=E8=
=BF=B0=E4=BA=86=E5=8F=AF=E8=A2=AB=E7=A8=B3=E5=AE=9A
 =E7=89=88=E5=86=85=E6=A0=B8=E6=8E=A5=E5=8F=97=E7=9A=84=E4=BF=AE=E6=94=B9=
=E7=B1=BB=E5=9E=8B=E4=BB=A5=E5=8F=8A=E5=8F=91=E5=B8=83=E7=9A=84=E6=B5=81=E7=
=A8=8B=E3=80=82
=20
=20
@@ -329,7 +329,7 @@ bugzilla.kernel.org=E6=98=AFLinux=E5=86=85=E6=A0=B8=E5=
=BC=80=E5=8F=91=E8=80=85=E4=BB=AC=E7=94=A8=E6=9D=A5=E8=B7=9F=E8=B8=AA=E5=86=
=85=E6=A0=B8Bug=E7=9A=84=E7=BD=91=E7=AB=99=E3=80=82
 =E6=88=B7=E5=9C=A8=E8=BF=99=E4=B8=AA=E5=B7=A5=E5=85=B7=E4=B8=AD=E6=8A=A5=
=E5=91=8A=E6=89=BE=E5=88=B0=E7=9A=84=E6=89=80=E6=9C=89bug=E3=80=82=E5=A6=82=
=E4=BD=95=E4=BD=BF=E7=94=A8=E5=86=85=E6=A0=B8bugzilla=E7=9A=84=E7=BB=86=E8=
=8A=82=E8=AF=B7=E8=AE=BF=E9=97=AE=EF=BC=9A
 	http://test.kernel.org/bugzilla/faq.html
=20
-=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E4=B8=BB=E7=9B=AE=E5=BD=95=E4=B8=AD=
=E7=9A=84REPORTING-BUGS=E6=96=87=E4=BB=B6=E9=87=8C=E6=9C=89=E4=B8=80=E4=B8=
=AA=E5=BE=88=E5=A5=BD=E7=9A=84=E6=A8=A1=E6=9D=BF=E3=80=82=E5=AE=83=E6=8C=87=
=E5=AF=BC=E7=94=A8=E6=88=B7=E5=A6=82=E4=BD=95=E6=8A=A5
+=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=E4=B8=BB=E7=9B=AE=E5=BD=95=E4=B8=AD=
=E7=9A=84admin-guide/reporting-bugs.rst=E6=96=87=E4=BB=B6=E9=87=8C=E6=9C=89=
=E4=B8=80=E4=B8=AA=E5=BE=88=E5=A5=BD=E7=9A=84=E6=A8=A1=E6=9D=BF=E3=80=82=E5=
=AE=83=E6=8C=87=E5=AF=BC=E7=94=A8=E6=88=B7=E5=A6=82=E4=BD=95=E6=8A=A5
 =E5=91=8A=E5=8F=AF=E8=83=BD=E7=9A=84=E5=86=85=E6=A0=B8bug=E4=BB=A5=E5=8F=
=8A=E9=9C=80=E8=A6=81=E6=8F=90=E4=BE=9B=E5=93=AA=E4=BA=9B=E4=BF=A1=E6=81=AF=
=E6=9D=A5=E5=B8=AE=E5=8A=A9=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E8=80=85=E4=
=BB=AC=E6=89=BE=E5=88=B0=E9=97=AE=E9=A2=98=E7=9A=84=E6=A0=B9=E6=BA=90=E3=80=
=82
=20
=20
@@ -380,7 +380,7 @@ MAINTAINERS=E6=96=87=E4=BB=B6=E4=B8=AD=E5=8F=AF=E4=BB=
=A5=E6=89=BE=E5=88=B0=E4=B8=8D=E5=90=8C=E8=AF=9D=E9=A2=98=E5=AF=B9=E5=BA=94=
=E7=9A=84=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=E3=80=82
 =E8=BF=99=E5=87=A0=E8=A1=8C=E3=80=82=E5=B0=86=E4=BD=A0=E7=9A=84=E8=AF=84=
=E8=AE=BA=E5=8A=A0=E5=9C=A8=E8=A2=AB=E5=BC=95=E7=94=A8=E7=9A=84=E6=AE=B5=E8=
=90=BD=E4=B9=8B=E9=97=B4=E8=80=8C=E4=B8=8D=E8=A6=81=E6=94=BE=E5=9C=A8=E9=82=
=AE=E4=BB=B6=E7=9A=84=E9=A1=B6=E9=83=A8=E3=80=82
=20
 =E5=A6=82=E6=9E=9C=E4=BD=A0=E5=9C=A8=E9=82=AE=E4=BB=B6=E4=B8=AD=E9=99=84=
=E5=B8=A6=E8=A1=A5=E4=B8=81=EF=BC=8C=E8=AF=B7=E7=A1=AE=E8=AE=A4=E5=AE=83=E4=
=BB=AC=E6=98=AF=E5=8F=AF=E4=BB=A5=E7=9B=B4=E6=8E=A5=E9=98=85=E8=AF=BB=E7=9A=
=84=E7=BA=AF=E6=96=87=E6=9C=AC=EF=BC=88=E5=A6=82
-Documentation/SubmittingPatches=E6=96=87=E6=A1=A3=E4=B8=AD=E6=89=80=E8=BF=
=B0=EF=BC=89=E3=80=82=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E8=80=85=E4=BB=AC=
=E4=B8=8D=E5=B8=8C=E6=9C=9B=E9=81=87=E5=88=B0=E9=99=84=E4=BB=B6
+Documentation/process/submitting-patches.rst=E6=96=87=E6=A1=A3=E4=B8=AD=E6=
=89=80=E8=BF=B0=EF=BC=89=E3=80=82=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E8=80=
=85=E4=BB=AC=E4=B8=8D=E5=B8=8C=E6=9C=9B=E9=81=87=E5=88=B0=E9=99=84=E4=BB=B6
 =E6=88=96=E8=80=85=E8=A2=AB=E5=8E=8B=E7=BC=A9=E4=BA=86=E7=9A=84=E8=A1=A5=
=E4=B8=81=E3=80=82=E5=8F=AA=E6=9C=89=E8=BF=99=E6=A0=B7=E6=89=8D=E8=83=BD=E4=
=BF=9D=E8=AF=81=E4=BB=96=E4=BB=AC=E5=8F=AF=E4=BB=A5=E7=9B=B4=E6=8E=A5=E8=AF=
=84=E8=AE=BA=E4=BD=A0=E7=9A=84=E6=AF=8F=E8=A1=8C=E4=BB=A3=E7=A0=81=E3=80=82=
=E8=AF=B7=E7=A1=AE=E4=BF=9D
 =E4=BD=A0=E4=BD=BF=E7=94=A8=E7=9A=84=E9=82=AE=E4=BB=B6=E5=8F=91=E9=80=81=
=E7=A8=8B=E5=BA=8F=E4=B8=8D=E4=BC=9A=E4=BF=AE=E6=94=B9=E7=A9=BA=E6=A0=BC=E5=
=92=8C=E5=88=B6=E8=A1=A8=E7=AC=A6=E3=80=82=E4=B8=80=E4=B8=AA=E9=98=B2=E8=8C=
=83=E6=80=A7=E7=9A=84=E6=B5=8B=E8=AF=95=E6=96=B9=E6=B3=95=E6=98=AF=E5=85=88=
=E5=B0=86=E9=82=AE=E4=BB=B6
 =E5=8F=91=E9=80=81=E7=BB=99=E8=87=AA=E5=B7=B1=EF=BC=8C=E7=84=B6=E5=90=8E=
=E8=87=AA=E5=B7=B1=E5=B0=9D=E8=AF=95=E6=98=AF=E5=90=A6=E5=8F=AF=E4=BB=A5=E9=
=A1=BA=E5=88=A9=E5=9C=B0=E6=89=93=E4=B8=8A=E6=94=B6=E5=88=B0=E7=9A=84=E8=A1=
=A5=E4=B8=81=E3=80=82=E5=A6=82=E6=9E=9C=E6=B5=8B=E8=AF=95=E4=B8=8D=E6=88=90=
=E5=8A=9F=EF=BC=8C=E8=AF=B7
diff --git a/Documentation/zh_CN/SecurityBugs b/Documentation/zh_CN/Securit=
yBugs
index d21eb07fe943..2d0fffd122ce 100644
--- a/Documentation/zh_CN/SecurityBugs
+++ b/Documentation/zh_CN/SecurityBugs
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/SecurityBugs
+Chinese translated version of Documentation/admin-guide/security-bugs.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: Harry Wei <harryxiyou@gmail.com>
 ---------------------------------------------------------------------
-Documentation/SecurityBugs =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=91
+Documentation/admin-guide/security-bugs.rst =E7=9A=84=E4=B8=AD=E6=96=87=E7=
=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -31,7 +31,7 @@ linux=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=E5=9B=A2=E9=98=
=9F=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87email<security@kernel.org>=E6=9D=A5=
=E8=81=94=E7=B3=BB=E3=80=82=E8=BF=99=E6=98=AF
 =E4=B8=80=E7=BB=84=E7=8B=AC=E7=AB=8B=E7=9A=84=E5=AE=89=E5=85=A8=E5=B7=A5=
=E4=BD=9C=E4=BA=BA=E5=91=98=EF=BC=8C=E5=8F=AF=E4=BB=A5=E5=B8=AE=E5=8A=A9=E6=
=94=B9=E5=96=84=E6=BC=8F=E6=B4=9E=E6=8A=A5=E5=91=8A=E5=B9=B6=E4=B8=94=E5=85=
=AC=E5=B8=83=E5=92=8C=E5=8F=96=E6=B6=88=E4=B8=80=E4=B8=AA=E4=BF=AE=E5=A4=8D=
=E3=80=82=E5=AE=89
 =E5=85=A8=E5=9B=A2=E9=98=9F=E6=9C=89=E5=8F=AF=E8=83=BD=E4=BC=9A=E4=BB=8E=
=E9=83=A8=E5=88=86=E7=9A=84=E7=BB=B4=E6=8A=A4=E8=80=85=E9=82=A3=E9=87=8C=E5=
=BC=95=E8=BF=9B=E9=A2=9D=E5=A4=96=E7=9A=84=E5=B8=AE=E5=8A=A9=E6=9D=A5=E4=BA=
=86=E8=A7=A3=E5=B9=B6=E4=B8=94=E4=BF=AE=E5=A4=8D=E5=AE=89=E5=85=A8=E6=BC=8F=
=E6=B4=9E=E3=80=82
 =E5=BD=93=E9=81=87=E5=88=B0=E4=BB=BB=E4=BD=95=E6=BC=8F=E6=B4=9E=EF=BC=8C=
=E6=89=80=E8=83=BD=E6=8F=90=E4=BE=9B=E7=9A=84=E4=BF=A1=E6=81=AF=E8=B6=8A=E5=
=A4=9A=E5=B0=B1=E8=B6=8A=E8=83=BD=E8=AF=8A=E6=96=AD=E5=92=8C=E4=BF=AE=E5=A4=
=8D=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=B8=8D=E6=B8=85=E6=A5=9A=E4=BB=80=
=E4=B9=88
-=E6=98=AF=E6=9C=89=E5=B8=AE=E5=8A=A9=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=
=E9=82=A3=E5=B0=B1=E8=AF=B7=E9=87=8D=E6=B8=A9=E4=B8=80=E4=B8=8BREPORTING-BU=
GS=E6=96=87=E4=BB=B6=E4=B8=AD=E7=9A=84=E6=A6=82=E8=BF=B0=E8=BF=87=E7=A8=8B=
=E3=80=82=E4=BB=BB
+=E6=98=AF=E6=9C=89=E5=B8=AE=E5=8A=A9=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=8C=
=E9=82=A3=E5=B0=B1=E8=AF=B7=E9=87=8D=E6=B8=A9=E4=B8=80=E4=B8=8Badmin-guide/=
reporting-bugs.rst=E6=96=87=E4=BB=B6=E4=B8=AD=E7=9A=84=E6=A6=82=E8=BF=B0=E8=
=BF=87=E7=A8=8B=E3=80=82=E4=BB=BB
 =E4=BD=95=E6=94=BB=E5=87=BB=E6=80=A7=E7=9A=84=E4=BB=A3=E7=A0=81=E9=83=BD=
=E6=98=AF=E9=9D=9E=E5=B8=B8=E6=9C=89=E7=94=A8=E7=9A=84=EF=BC=8C=E6=9C=AA=E7=
=BB=8F=E6=8A=A5=E5=91=8A=E8=80=85=E7=9A=84=E5=90=8C=E6=84=8F=E4=B8=8D=E4=BC=
=9A=E8=A2=AB=E5=8F=96=E6=B6=88=EF=BC=8C=E9=99=A4=E9=9D=9E=E5=AE=83=E5=B7=B2=
=E7=BB=8F
 =E8=A2=AB=E5=85=AC=E5=B8=83=E4=BA=8E=E4=BC=97=E3=80=82
=20
diff --git a/Documentation/zh_CN/SubmittingDrivers b/Documentation/zh_CN/Su=
bmittingDrivers
index d313f5d8448d..929385e4b194 100644
--- a/Documentation/zh_CN/SubmittingDrivers
+++ b/Documentation/zh_CN/SubmittingDrivers
@@ -1,4 +1,4 @@
-=EF=BB=BFChinese translated version of Documentation/SubmittingDrivers
+=EF=BB=BFChinese translated version of Documentation/process/submitting-dr=
ivers.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: Li Yang <leo@zh-kernel.org>
 ---------------------------------------------------------------------
-Documentation/SubmittingDrivers =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=
=91
+Documentation/process/submitting-drivers.rst =E7=9A=84=E4=B8=AD=E6=96=87=
=E7=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -30,7 +30,7 @@ Documentation/SubmittingDrivers =E7=9A=84=E4=B8=AD=E6=96=
=87=E7=BF=BB=E8=AF=91
 =E5=85=B4=E8=B6=A3=E7=9A=84=E6=98=AF=E6=98=BE=E5=8D=A1=E9=A9=B1=E5=8A=A8=
=E7=A8=8B=E5=BA=8F=EF=BC=8C=E4=BD=A0=E4=B9=9F=E8=AE=B8=E5=BA=94=E8=AF=A5=E8=
=AE=BF=E9=97=AE XFree86 =E9=A1=B9=E7=9B=AE(http://www.xfree86.org/)
 =E5=92=8C=EF=BC=8F=E6=88=96 X.org =E9=A1=B9=E7=9B=AE (http://x.org)=E3=80=
=82
=20
-=E5=8F=A6=E8=AF=B7=E5=8F=82=E9=98=85 Documentation/SubmittingPatches =E6=
=96=87=E6=A1=A3=E3=80=82
+=E5=8F=A6=E8=AF=B7=E5=8F=82=E9=98=85 Documentation/process/submitting-patc=
hes.rst =E6=96=87=E6=A1=A3=E3=80=82
=20
=20
 =E5=88=86=E9=85=8D=E8=AE=BE=E5=A4=87=E5=8F=B7
@@ -39,7 +39,7 @@ Documentation/SubmittingDrivers =E7=9A=84=E4=B8=AD=E6=96=
=87=E7=BF=BB=E8=AF=91
 =E5=9D=97=E8=AE=BE=E5=A4=87=E5=92=8C=E5=AD=97=E7=AC=A6=E8=AE=BE=E5=A4=87=
=E7=9A=84=E4=B8=BB=E8=AE=BE=E5=A4=87=E5=8F=B7=E4=B8=8E=E4=BB=8E=E8=AE=BE=E5=
=A4=87=E5=8F=B7=E6=98=AF=E7=94=B1 Linux =E5=91=BD=E5=90=8D=E7=BC=96=E5=8F=
=B7=E5=88=86=E9=85=8D=E6=9D=83=E5=A8=81 LANANA=EF=BC=88
 =E7=8E=B0=E5=9C=A8=E6=98=AF Torben Mathiasen=EF=BC=89=E8=B4=9F=E8=B4=A3=E5=
=88=86=E9=85=8D=E3=80=82=E7=94=B3=E8=AF=B7=E7=9A=84=E7=BD=91=E5=9D=80=E6=98=
=AF http://www.lanana.org/=E3=80=82
 =E5=8D=B3=E4=BD=BF=E4=B8=8D=E5=87=86=E5=A4=87=E6=8F=90=E4=BA=A4=E5=88=B0=
=E4=B8=BB=E6=B5=81=E5=86=85=E6=A0=B8=E7=9A=84=E8=AE=BE=E5=A4=87=E9=A9=B1=E5=
=8A=A8=E4=B9=9F=E9=9C=80=E8=A6=81=E5=9C=A8=E8=BF=99=E9=87=8C=E5=88=86=E9=85=
=8D=E8=AE=BE=E5=A4=87=E5=8F=B7=E3=80=82=E6=9C=89=E5=85=B3=E8=AF=A6=E7=BB=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C
-=E8=AF=B7=E5=8F=82=E9=98=85 Documentation/devices.txt=E3=80=82
+=E8=AF=B7=E5=8F=82=E9=98=85 Documentation/admin-guide/devices.rst=E3=80=82
=20
 =E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E7=9A=84=E4=B8=8D=E6=98=AF=
=E5=B7=B2=E7=BB=8F=E5=88=86=E9=85=8D=E7=9A=84=E8=AE=BE=E5=A4=87=E5=8F=B7=EF=
=BC=8C=E9=82=A3=E4=B9=88=E5=BD=93=E4=BD=A0=E6=8F=90=E4=BA=A4=E8=AE=BE=E5=A4=
=87=E9=A9=B1=E5=8A=A8=E7=9A=84=E6=97=B6=E5=80=99=EF=BC=8C=E5=AE=83=E5=B0=86=
=E4=BC=9A=E8=A2=AB=E5=BC=BA
 =E5=88=B6=E5=88=86=E9=85=8D=E4=B8=80=E4=B8=AA=E6=96=B0=E7=9A=84=E8=AE=BE=
=E5=A4=87=E5=8F=B7=EF=BC=8C=E5=8D=B3=E4=BE=BF=E8=BF=99=E4=B8=AA=E8=AE=BE=E5=
=A4=87=E5=8F=B7=E5=92=8C=E4=BD=A0=E4=B9=8B=E5=89=8D=E5=8F=91=E7=BB=99=E5=AE=
=A2=E6=88=B7=E7=9A=84=E6=88=AA=E7=84=B6=E4=B8=8D=E5=90=8C=E3=80=82
@@ -81,7 +81,7 @@ Linux 2.6:
 		=E5=A6=82=E6=9E=9C=E4=BD=A0=E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA Linux =
=E5=92=8C NT =E7=9A=84=E9=80=9A=E7=94=A8=E9=A9=B1=E5=8A=A8=E6=8E=A5=E5=8F=
=A3=EF=BC=8C=E9=82=A3=E4=B9=88=E8=AF=B7=E5=9C=A8=E7=94=A8
 		=E6=88=B7=E7=A9=BA=E9=97=B4=E5=AE=9E=E7=8E=B0=E5=AE=83=E3=80=82
=20
-=E4=BB=A3=E7=A0=81=EF=BC=9A		=E8=AF=B7=E4=BD=BF=E7=94=A8 Documentation/Cod=
ingStyle =E4=B8=AD=E6=89=80=E6=8F=8F=E8=BF=B0=E7=9A=84 Linux =E4=BB=A3=E7=
=A0=81=E9=A3=8E
+=E4=BB=A3=E7=A0=81=EF=BC=9A		=E8=AF=B7=E4=BD=BF=E7=94=A8 Documentation/pro=
cess/coding-style.rst =E4=B8=AD=E6=89=80=E6=8F=8F=E8=BF=B0=E7=9A=84 Linux =
=E4=BB=A3=E7=A0=81=E9=A3=8E
 		=E6=A0=BC=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E7=9A=84=E6=9F=90=E4=BA=9B=
=E4=BB=A3=E7=A0=81=E6=AE=B5=EF=BC=88=E4=BE=8B=E5=A6=82=E9=82=A3=E4=BA=9B=E4=
=B8=8E Windows =E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E5=8C=85=E5=85=B1
 		=E4=BA=AB=E7=9A=84=E4=BB=A3=E7=A0=81=E6=AE=B5=EF=BC=89=E9=9C=80=E8=A6=81=
=E4=BD=BF=E7=94=A8=E5=85=B6=E4=BB=96=E6=A0=BC=E5=BC=8F=EF=BC=8C=E8=80=8C=E4=
=BD=A0=E5=8D=B4=E5=8F=AA=E5=B8=8C=E6=9C=9B=E7=BB=B4=E6=8A=A4=E4=B8=80=E4=BB=
=BD=E4=BB=A3=E7=A0=81=EF=BC=8C
 		=E9=82=A3=E4=B9=88=E8=AF=B7=E5=B0=86=E5=AE=83=E4=BB=AC=E5=BE=88=E5=A5=BD=
=E5=9C=B0=E5=8C=BA=E5=88=86=E5=87=BA=E6=9D=A5=EF=BC=8C=E5=B9=B6=E4=B8=94=E6=
=B3=A8=E6=98=8E=E5=8E=9F=E5=9B=A0=E3=80=82
@@ -107,7 +107,7 @@ Linux 2.6:
 		=E7=A8=8B=E5=BA=8F=E6=B5=8B=E8=AF=95=E7=9A=84=E6=8C=87=E5=AF=BC=EF=BC=8C=
=E8=AF=B7=E5=8F=82=E9=98=85
 		Documentation/power/drivers-testing.txt=E3=80=82=E6=9C=89=E5=85=B3=E9=A9=
=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E7=94=B5
 		=E6=BA=90=E7=AE=A1=E7=90=86=E9=97=AE=E9=A2=98=E7=9B=B8=E5=AF=B9=E5=85=A8=
=E9=9D=A2=E7=9A=84=E6=A6=82=E8=BF=B0=EF=BC=8C=E8=AF=B7=E5=8F=82=E9=98=85
-		Documentation/power/devices.txt=E3=80=82
+		Documentation/power/admin-guide/devices.rst=E3=80=82
=20
 =E7=AE=A1=E7=90=86=EF=BC=9A		=E5=A6=82=E6=9E=9C=E4=B8=80=E4=B8=AA=E9=A9=B1=
=E5=8A=A8=E7=A8=8B=E5=BA=8F=E7=9A=84=E4=BD=9C=E8=80=85=E8=BF=98=E5=9C=A8=E8=
=BF=9B=E8=A1=8C=E6=9C=89=E6=95=88=E7=9A=84=E7=BB=B4=E6=8A=A4=EF=BC=8C=E9=82=
=A3=E4=B9=88=E9=80=9A=E5=B8=B8=E9=99=A4=E4=BA=86=E9=82=A3
 		=E4=BA=9B=E6=98=8E=E6=98=BE=E6=AD=A3=E7=A1=AE=E4=B8=94=E4=B8=8D=E9=9C=80=
=E8=A6=81=E4=BB=BB=E4=BD=95=E6=A3=80=E6=9F=A5=E7=9A=84=E8=A1=A5=E4=B8=81=E4=
=BB=A5=E5=A4=96=EF=BC=8C=E5=85=B6=E4=BB=96=E6=89=80=E6=9C=89=E7=9A=84=E8=A1=
=A5=E4=B8=81=E9=83=BD=E4=BC=9A
diff --git a/Documentation/zh_CN/SubmittingPatches b/Documentation/zh_CN/Su=
bmittingPatches
index 1d3a10f8746b..e9098da8f1a4 100644
--- a/Documentation/zh_CN/SubmittingPatches
+++ b/Documentation/zh_CN/SubmittingPatches
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/SubmittingPatches
+Chinese translated version of Documentation/process/submitting-patches.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: TripleX Chung <triplex@zh-kernel.org>
 ---------------------------------------------------------------------
-Documentation/SubmittingPatches =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=
=91
+Documentation/process/submitting-patches.rst =E7=9A=84=E4=B8=AD=E6=96=87=
=E7=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -30,9 +30,9 @@ Documentation/SubmittingPatches =E7=9A=84=E4=B8=AD=E6=96=
=87=E7=BF=BB=E8=AF=91
 =E5=AF=B9=E4=BA=8E=E6=83=B3=E8=A6=81=E5=B0=86=E6=94=B9=E5=8A=A8=E6=8F=90=
=E4=BA=A4=E5=88=B0 Linux =E5=86=85=E6=A0=B8=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=
=88=96=E8=80=85=E5=85=AC=E5=8F=B8=E6=9D=A5=E8=AF=B4=EF=BC=8C=E5=A6=82=E6=9E=
=9C=E4=B8=8D=E7=86=9F=E6=82=89=E2=80=9C=E8=A7=84=E7=9F=A9=E2=80=9D=EF=BC=8C
 =E6=8F=90=E4=BA=A4=E7=9A=84=E6=B5=81=E7=A8=8B=E4=BC=9A=E8=AE=A9=E4=BA=BA=
=E7=95=8F=E6=83=A7=E3=80=82=E6=9C=AC=E6=96=87=E6=A1=A3=E6=94=B6=E9=9B=86=E4=
=BA=86=E4=B8=80=E7=B3=BB=E5=88=97=E5=BB=BA=E8=AE=AE=EF=BC=8C=E8=BF=99=E4=BA=
=9B=E5=BB=BA=E8=AE=AE=E5=8F=AF=E4=BB=A5=E5=A4=A7=E5=A4=A7=E7=9A=84=E6=8F=90=
=E9=AB=98=E4=BD=A0
 =E7=9A=84=E6=94=B9=E5=8A=A8=E8=A2=AB=E6=8E=A5=E5=8F=97=E7=9A=84=E6=9C=BA=
=E4=BC=9A=E3=80=82
-=E9=98=85=E8=AF=BB Documentation/SubmitChecklist =E6=9D=A5=E8=8E=B7=E5=BE=
=97=E5=9C=A8=E6=8F=90=E4=BA=A4=E4=BB=A3=E7=A0=81=E5=89=8D=E9=9C=80=E8=A6=81=
=E6=A3=80=E6=9F=A5=E7=9A=84=E9=A1=B9=E7=9B=AE=E7=9A=84=E5=88=97
+=E9=98=85=E8=AF=BB Documentation/process/submit-checklist.rst =E6=9D=A5=E8=
=8E=B7=E5=BE=97=E5=9C=A8=E6=8F=90=E4=BA=A4=E4=BB=A3=E7=A0=81=E5=89=8D=E9=9C=
=80=E8=A6=81=E6=A3=80=E6=9F=A5=E7=9A=84=E9=A1=B9=E7=9B=AE=E7=9A=84=E5=88=97
 =E8=A1=A8=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E5=9C=A8=E6=8F=90=E4=BA=A4=
=E4=B8=80=E4=B8=AA=E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=EF=BC=8C=E9=82=A3=E4=
=B9=88=E5=90=8C=E6=97=B6=E9=98=85=E8=AF=BB=E4=B8=80=E4=B8=8B
-Documentation/SubmittingDrivers =E3=80=82
+Documentation/process/submitting-drivers.rst =E3=80=82
=20
=20
 --------------------------
@@ -338,7 +338,7 @@ e-mail =E6=A0=87=E9=A2=98=E4=B8=AD=E7=9A=84=E2=80=9C=E4=
=B8=80=E5=8F=A5=E8=AF=9D=E6=A6=82=E8=BF=B0=E2=80=9D=E6=89=BC=E8=A6=81=E7=9A=
=84=E6=8F=8F=E8=BF=B0 e-mail =E4=B8=AD=E7=9A=84=E8=A1=A5=E4=B8=81=E3=80=82
 =E6=9C=AC=E8=8A=82=E5=8C=85=E5=90=AB=E5=BE=88=E5=A4=9A=E5=92=8C=E6=8F=90=
=E4=BA=A4=E5=88=B0=E5=86=85=E6=A0=B8=E7=9A=84=E4=BB=A3=E7=A0=81=E6=9C=89=E5=
=85=B3=E7=9A=84=E9=80=9A=E5=B8=B8=E7=9A=84"=E8=A7=84=E5=88=99"=E3=80=82=E4=
=BA=8B=E6=83=85=E6=B0=B8=E8=BF=9C=E6=9C=89=E4=BE=8B=E5=A4=96...=E4=BD=86=E6=
=98=AF
 =E4=BD=A0=E5=BF=85=E9=A1=BB=E7=9C=9F=E7=9A=84=E6=9C=89=E5=A5=BD=E7=9A=84=
=E7=90=86=E7=94=B1=E8=BF=99=E6=A0=B7=E5=81=9A=E3=80=82=E4=BD=A0=E5=8F=AF=E4=
=BB=A5=E6=8A=8A=E6=9C=AC=E8=8A=82=E5=8F=AB=E5=81=9ALinus=E7=9A=84=E8=AE=A1=
=E7=AE=97=E6=9C=BA=E7=A7=91=E5=AD=A6=E5=85=A5=E9=97=A8=E8=AF=BE=E3=80=82
=20
-1) =E8=AF=BB Document/CodingStyle
+1) =E8=AF=BB Document/process/coding-style.rst
=20
 Nuff =E8=AF=B4=E8=BF=87=EF=BC=8C=E5=A6=82=E6=9E=9C=E4=BD=A0=E7=9A=84=E4=BB=
=A3=E7=A0=81=E5=92=8C=E8=BF=99=E4=B8=AA=E5=81=8F=E7=A6=BB=E5=A4=AA=E5=A4=9A=
=EF=BC=8C=E9=82=A3=E4=B9=88=E5=AE=83=E6=9C=89=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=
=A2=AB=E6=8B=92=E7=BB=9D=EF=BC=8C=E6=B2=A1=E6=9C=89=E6=9B=B4=E5=A4=9A=E7=9A=
=84
 =E5=AE=A1=E6=9F=A5=EF=BC=8C=E6=B2=A1=E6=9C=89=E6=9B=B4=E5=A4=9A=E7=9A=84=
=E8=AF=84=E4=BB=B7=E3=80=82
@@ -404,8 +404,8 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem=
 maintainer".
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lkml.org/lkml/2005/7/11/336>
=20
-Kernel Documentation/CodingStyle:
-  <http://sosdg.org/~coywolf/lxr/source/Documentation/CodingStyle>
+Kernel Documentation/process/coding-style.rst:
+  <http://sosdg.org/~coywolf/lxr/source/Documentation/process/coding-style=
.rst>
=20
 Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
diff --git a/Documentation/zh_CN/arm/Booting b/Documentation/zh_CN/arm/Boot=
ing
index 6158a64df80c..1fe866f8218f 100644
--- a/Documentation/zh_CN/arm/Booting
+++ b/Documentation/zh_CN/arm/Booting
@@ -68,7 +68,7 @@ RAM=EF=BC=8C=E6=88=96=E5=8F=AF=E8=83=BD=E4=BD=BF=E7=94=A8=
=E5=AF=B9=E8=BF=99=E4=B8=AA=E8=AE=BE=E5=A4=87=E5=B7=B2=E7=9F=A5=E7=9A=84 RA=
M =E4=BF=A1=E6=81=AF=EF=BC=8C=E8=BF=98=E5=8F=AF=E8=83=BD=E4=BD=BF=E7=94=A8=
=E4=BB=BB=E4=BD=95
 =E4=BD=9C=E4=B8=BA=E6=9B=BF=E4=BB=A3=E6=96=B9=E6=A1=88=EF=BC=8C=E5=BC=95=
=E5=AF=BC=E5=8A=A0=E8=BD=BD=E7=A8=8B=E5=BA=8F=E4=B9=9F=E5=8F=AF=E4=BB=A5=E9=
=80=9A=E8=BF=87=E6=A0=87=E7=AD=BE=E5=88=97=E8=A1=A8=E4=BC=A0=E9=80=92=E7=9B=
=B8=E5=85=B3=E7=9A=84'console=3D'
 =E9=80=89=E9=A1=B9=E7=BB=99=E5=86=85=E6=A0=B8=E4=BB=A5=E6=8C=87=E5=AE=9A=
=E6=9F=90=E4=B8=AA=E4=B8=B2=E5=8F=A3=EF=BC=8C=E8=80=8C=E4=B8=B2=E5=8F=A3=E6=
=95=B0=E6=8D=AE=E6=A0=BC=E5=BC=8F=E7=9A=84=E9=80=89=E9=A1=B9=E5=9C=A8=E4=BB=
=A5=E4=B8=8B=E6=96=87=E6=A1=A3=E4=B8=AD=E6=8F=8F=E8=BF=B0=EF=BC=9A
=20
-       Documentation/kernel-parameters.txt=E3=80=82
+       Documentation/admin-guide/kernel-parameters.rst=E3=80=82
=20
=20
 3=E3=80=81=E6=A3=80=E6=B5=8B=E6=9C=BA=E5=99=A8=E7=B1=BB=E5=9E=8B
diff --git a/Documentation/zh_CN/email-clients.txt b/Documentation/zh_CN/em=
ail-clients.txt
index b9a1a3e6c78d..ec31d97e8d0e 100644
--- a/Documentation/zh_CN/email-clients.txt
+++ b/Documentation/zh_CN/email-clients.txt
@@ -1,4 +1,4 @@
-=EF=BB=BFChinese translated version of Documentation/email-clients.txt
+=EF=BB=BFChinese translated version of Documentation/process/email-clients=
.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: Harry Wei <harryxiyou@gmail.com>
 ---------------------------------------------------------------------
-Documentation/email-clients.txt =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=
=91
+Documentation/process/email-clients.rst =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=
=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
diff --git a/Documentation/zh_CN/oops-tracing.txt b/Documentation/zh_CN/oop=
s-tracing.txt
index 9312608ffb8d..41ab53cc0e83 100644
--- a/Documentation/zh_CN/oops-tracing.txt
+++ b/Documentation/zh_CN/oops-tracing.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/oops-tracing.txt
+Chinese translated version of Documentation/admin-guide/oops-tracing.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: Dave Young <hidave.darkstar@gmail.com>
 ---------------------------------------------------------------------
-Documentation/oops-tracing.txt =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=E8=AF=
=91
+Documentation/admin-guide/oops-tracing.rst =E7=9A=84=E4=B8=AD=E6=96=87=E7=
=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -50,7 +50,7 @@ cat /proc/kmsg > file=EF=BC=8C =E7=84=B6=E8=80=8C=E4=BD=
=A0=E5=BF=85=E9=A1=BB=E4=BB=8B=E5=85=A5=E4=B8=AD=E6=AD=A2=E4=BC=A0=E8=BE=93=
=EF=BC=8C kmsg=E6=98=AF=E4=B8=80=E4=B8=AA=E2=80=9C
 =E6=81=AF=E6=BB=9A=E5=8A=A8=E5=88=B0=E4=BA=86=E7=BB=88=E7=AB=AF=E7=9A=84=
=E4=B8=8A=E9=9D=A2=EF=BC=8C=E4=BD=A0=E4=BC=9A=E5=8F=91=E7=8E=B0=E4=BB=A5=E9=
=AB=98=E5=88=86=E8=BE=A9=E7=8E=87=E5=90=AF=E5=8A=A8=EF=BC=88=E6=AF=94=E5=A6=
=82=EF=BC=8Cvga=3D791=EF=BC=89=E4=BC=9A=E8=AE=A9=E4=BD=A0=E8=AF=BB=E5=88=B0=
=E6=9B=B4=E5=A4=9A=E7=9A=84=E6=96=87
 =E6=9C=AC=E3=80=82=EF=BC=88=E6=B3=A8=E6=84=8F=EF=BC=9A=E8=BF=99=E9=9C=80=
=E8=A6=81vesafb=EF=BC=8C=E6=89=80=E4=BB=A5=E5=AF=B9=E2=80=98=E6=97=A9=E6=9C=
=9F=E2=80=99=E7=9A=84oops=E6=B2=A1=E6=9C=89=E5=B8=AE=E5=8A=A9=EF=BC=89
=20
-=EF=BC=882=EF=BC=89=E7=94=A8=E4=B8=B2=E5=8F=A3=E7=BB=88=E7=AB=AF=E5=90=AF=
=E5=8A=A8=EF=BC=88=E8=AF=B7=E5=8F=82=E7=9C=8BDocumentation/serial-console.t=
xt=EF=BC=89=EF=BC=8C=E8=BF=90=E8=A1=8C=E4=B8=80=E4=B8=AAnull
+=EF=BC=882=EF=BC=89=E7=94=A8=E4=B8=B2=E5=8F=A3=E7=BB=88=E7=AB=AF=E5=90=AF=
=E5=8A=A8=EF=BC=88=E8=AF=B7=E5=8F=82=E7=9C=8BDocumentation/admin-guide/seri=
al-console.rst=EF=BC=89=EF=BC=8C=E8=BF=90=E8=A1=8C=E4=B8=80=E4=B8=AAnull
 modem=E5=88=B0=E5=8F=A6=E4=B8=80=E5=8F=B0=E6=9C=BA=E5=99=A8=E5=B9=B6=E7=94=
=A8=E4=BD=A0=E5=96=9C=E6=AC=A2=E7=9A=84=E9=80=9A=E8=AE=AF=E5=B7=A5=E5=85=B7=
=E8=8E=B7=E5=8F=96=E8=BE=93=E5=87=BA=E3=80=82Minicom=E5=B7=A5=E4=BD=9C=E5=
=9C=B0=E5=BE=88=E5=A5=BD=E3=80=82
=20
 =EF=BC=883=EF=BC=89=E4=BD=BF=E7=94=A8Kdump=EF=BC=88=E8=AF=B7=E5=8F=82=E7=
=9C=8BDocumentation/kdump/kdump.txt=EF=BC=89=EF=BC=8C
diff --git a/Documentation/zh_CN/stable_api_nonsense.txt b/Documentation/zh=
_CN/stable_api_nonsense.txt
index c26a27d1ee7d..a2b27fab382c 100644
--- a/Documentation/zh_CN/stable_api_nonsense.txt
+++ b/Documentation/zh_CN/stable_api_nonsense.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/stable_api_nonsense.txt
+Chinese translated version of Documentation/process/stable-api-nonsense.rs=
t
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have problem
@@ -9,7 +9,7 @@ is problem with translation.
 Maintainer: Greg Kroah-Hartman <greg@kroah.com>
 Chinese maintainer: TripleX Chung <zhongyu@18mail.cn>
 ---------------------------------------------------------------------
-Documentation/stable_api_nonsense.txt =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=
=E8=AF=91
+Documentation/process/stable-api-nonsense.rst =E7=9A=84=E4=B8=AD=E6=96=87=
=E7=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
diff --git a/Documentation/zh_CN/stable_kernel_rules.txt b/Documentation/zh=
_CN/stable_kernel_rules.txt
index 26ea5ed7cd9c..db4ba5a0c39a 100644
--- a/Documentation/zh_CN/stable_kernel_rules.txt
+++ b/Documentation/zh_CN/stable_kernel_rules.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/stable_kernel_rules.txt
+Chinese translated version of Documentation/process/stable-kernel-rules.rs=
t
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
=20
 Chinese maintainer: TripleX Chung <triplex@zh-kernel.org>
 ---------------------------------------------------------------------
-Documentation/stable_kernel_rules.txt =E7=9A=84=E4=B8=AD=E6=96=87=E7=BF=BB=
=E8=AF=91
+Documentation/process/stable-kernel-rules.rst =E7=9A=84=E4=B8=AD=E6=96=87=
=E7=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
@@ -38,7 +38,7 @@ Documentation/stable_kernel_rules.txt =E7=9A=84=E4=B8=AD=
=E6=96=87=E7=BF=BB=E8=AF=91
   - =E6=B2=A1=E6=9C=89=E2=80=9C=E7=90=86=E8=AE=BA=E4=B8=8A=E7=9A=84=E7=AB=
=9E=E4=BA=89=E6=9D=A1=E4=BB=B6=E2=80=9D=EF=BC=8C=E9=99=A4=E9=9D=9E=E8=83=BD=
=E7=BB=99=E5=87=BA=E7=AB=9E=E4=BA=89=E6=9D=A1=E4=BB=B6=E5=A6=82=E4=BD=95=E8=
=A2=AB=E5=88=A9=E7=94=A8=E7=9A=84=E8=A7=A3=E9=87=8A=E3=80=82
   - =E4=B8=8D=E8=83=BD=E5=AD=98=E5=9C=A8=E4=BB=BB=E4=BD=95=E7=9A=84=E2=80=
=9C=E7=90=90=E7=A2=8E=E7=9A=84=E2=80=9D=E4=BF=AE=E6=AD=A3=EF=BC=88=E6=8B=BC=
=E5=86=99=E4=BF=AE=E6=AD=A3=EF=BC=8C=E5=8E=BB=E6=8E=89=E5=A4=9A=E4=BD=99=E7=
=A9=BA=E6=A0=BC=E4=B9=8B=E7=B1=BB=E7=9A=84=EF=BC=89=E3=80=82
   - =E5=BF=85=E9=A1=BB=E8=A2=AB=E7=9B=B8=E5=85=B3=E5=AD=90=E7=B3=BB=E7=BB=
=9F=E7=9A=84=E7=BB=B4=E6=8A=A4=E8=80=85=E6=8E=A5=E5=8F=97=E3=80=82
-  - =E5=BF=85=E9=A1=BB=E9=81=B5=E5=BE=AADocumentation/SubmittingPatches=E9=
=87=8C=E7=9A=84=E8=A7=84=E5=88=99=E3=80=82
+  - =E5=BF=85=E9=A1=BB=E9=81=B5=E5=BE=AADocumentation/process/submitting-p=
atches.rst=E9=87=8C=E7=9A=84=E8=A7=84=E5=88=99=E3=80=82
=20
 =E5=90=91=E7=A8=B3=E5=AE=9A=E7=89=88=E4=BB=A3=E7=A0=81=E6=A0=91=E6=8F=90=
=E4=BA=A4=E8=A1=A5=E4=B8=81=E7=9A=84=E8=BF=87=E7=A8=8B=EF=BC=9A
=20
diff --git a/Documentation/zh_CN/volatile-considered-harmful.txt b/Document=
ation/zh_CN/volatile-considered-harmful.txt
index ba8149d2233a..475125967197 100644
--- a/Documentation/zh_CN/volatile-considered-harmful.txt
+++ b/Documentation/zh_CN/volatile-considered-harmful.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/volatile-considered-harmful.tx=
t
+Chinese translated version of Documentation/process/volatile-considered-ha=
rmful.rst
=20
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -9,7 +9,7 @@ or if there is a problem with the translation.
 Maintainer: Jonathan Corbet <corbet@lwn.net>
 Chinese maintainer: Bryan Wu <bryan.wu@analog.com>
 ---------------------------------------------------------------------
-Documentation/volatile-considered-harmful.txt =E7=9A=84=E4=B8=AD=E6=96=87=
=E7=BF=BB=E8=AF=91
+Documentation/process/volatile-considered-harmful.rst =E7=9A=84=E4=B8=AD=
=E6=96=87=E7=BF=BB=E8=AF=91
=20
 =E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E8=81=94=E7=B3=BB=E5=8E=9F=E6=96=87=E6=A1=A3=E7=9A=84=E7=BB=B4=E6=8A=
=A4=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
 =E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=
=8A=A4=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=
=BB=E8=AF=91=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=
=E7=BF=BB
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..064f91c95622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -35,13 +35,13 @@ trivial patch so apply some common sense.
=20
 	PLEASE check your patch with the automated style checker
 	(scripts/checkpatch.pl) to catch trivial style violations.
-	See Documentation/CodingStyle for guidance here.
+	See Documentation/process/coding-style.rst for guidance here.
=20
 	PLEASE CC: the maintainers and mailing lists that are generated
 	by scripts/get_maintainer.pl.  The results returned by the
 	script will be best if you have git installed and are making
 	your changes in a branch derived from Linus' latest git tree.
-	See Documentation/SubmittingPatches for details.
+	See Documentation/process/submitting-patches.rst for details.
=20
 	PLEASE try to include any credit lines you want added with the
 	patch. It avoids people being missed off by mistake and makes
@@ -54,7 +54,7 @@ trivial patch so apply some common sense.
 	of the Linux Foundation certificate of contribution and should
 	include a Signed-off-by: line.  The current version of this
 	"Developer's Certificate of Origin" (DCO) is listed in the file
-	Documentation/SubmittingPatches.
+	Documentation/process/submitting-patches.rst.
=20
 6.	Make sure you have the right to send any changes you make. If you
 	do changes at work you may find your employer owns the patch
@@ -2924,7 +2924,7 @@ CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
 M:	Kevin Tsai <ktsai@capellamicro.com>
 S:	Maintained
 F:	drivers/iio/light/cm*
-F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
+F:	Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
=20
 CAVIUM I2C DRIVER
 M:	Jan Glauber <jglauber@cavium.com>
@@ -11438,7 +11438,7 @@ STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	stable@vger.kernel.org
 S:	Supported
-F:	Documentation/stable_kernel_rules.txt
+F:	Documentation/process/stable-kernel-rules.rst
=20
 STAGING SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bada636d1065..19d237b0737d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1525,7 +1525,7 @@ config X86_CHECK_BIOS_CORRUPTION
 	  line.  By default it scans the low 64k of memory every 60
 	  seconds; see the memory_corruption_check_size and
 	  memory_corruption_check_period parameters in
-	  Documentation/kernel-parameters.txt to adjust this.
+	  Documentation/admin-guide/kernel-parameters.rst to adjust this.
=20
 	  When enabled with the default parameters, this option has
 	  almost no overhead, as it reserves a relatively small amount
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 535e7828445a..c5f9cbe0ae21 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -342,7 +342,7 @@ config ACPI_DEBUG
=20
 	  Use the acpi.debug_layer and acpi.debug_level kernel command-line
 	  parameters documented in Documentation/acpi/debug.txt and
-	  Documentation/kernel-parameters.txt to control the type and
+	  Documentation/admin-guide/kernel-parameters.rst to control the type and
 	  amount of debug output.
=20
 config ACPI_PCI_SLOT
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 223a770f78f3..59ce0dd50701 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -129,7 +129,7 @@ static int ata_force_tbl_size;
 static char ata_force_param_buf[PAGE_SIZE] __initdata;
 /* param_buf is thrown away after initialization, disallow read */
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf=
), 0);
-MODULE_PARM_DESC(force, "Force ATA configurations including cable type, li=
nk speed and transfer mode (see Documentation/kernel-parameters.txt for det=
ails)");
+MODULE_PARM_DESC(force, "Force ATA configurations including cable type, li=
nk speed and transfer mode (see Documentation/admin-guide/kernel-parameters=
.rst for details)");
=20
 static int atapi_enabled =3D 1;
 module_param(atapi_enabled, int, 0444);
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_c=
s.c
index c115217c79ae..e051fc8aa7d7 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -14,7 +14,7 @@
   * (C) 2000,2001,2002,2003,2004 Omnikey AG
   *
   * (C) 2005-2006 Harald Welte <laforge@gnumonks.org>
-  * 	- Adhere to Kernel CodingStyle
+  * 	- Adhere to Kernel process/coding-style.rst
   * 	- Port to 2.6.13 "new" style PCMCIA
   * 	- Check for copy_{from,to}_user return values
   * 	- Use nonseekable_open()
@@ -151,7 +151,7 @@ static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
=20
 /* This table doesn't use spaces after the comma between fields and thus
- * violates CodingStyle.  However, I don't really think wrapping it around=
 will
+ * violates process/coding-style.rst.  However, I don't really think wrapp=
ing it around will
  * make it any clearer to read -HW */
 static unsigned char fi_di_table[10][14] =3D {
 /*FI     00   01   02   03   04   05   06   07   08   09   10   11   12   =
13 */
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index db9538d4b358..a7be12d9a139 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -15,7 +15,7 @@
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information o=
n the
  * sysfs interface.
  *
- * See "Documentation/kernel-parameters.txt" for information on the module
+ * See "Documentation/admin-guide/kernel-parameters.rst" for information o=
n the module
  * parameters.
  *
  * This program is free software; you can redistribute it and/or modify it
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 8b2b740d6679..b20ce7da1ee4 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -28,7 +28,7 @@ config BLK_DEV_PMEM
 	  non-standard OEM-specific E820 memory type (type-12, see
 	  CONFIG_X86_PMEM_LEGACY), or it is manually specified by the
 	  'memmap=3Dnn[KMG]!ss[KMG]' kernel command line (see
-	  Documentation/kernel-parameters.txt).  This driver converts
+	  Documentation/admin-guide/kernel-parameters.rst).  This driver converts
 	  these persistent memory ranges into block devices that are
 	  capable of DAX (direct-access) file system mappings.  See
 	  Documentation/nvdimm/nvdimm.txt for more details.
diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/d=
evices/vme_user.c
index 5dd430f8f921..d84dffb894f4 100644
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -47,7 +47,7 @@ static const char driver_name[] =3D "vme_user";
 static int bus[VME_USER_BUS_MAX];
 static unsigned int bus_num;
=20
-/* Currently Documentation/devices.txt defines the following for VME:
+/* Currently Documentation/admin-guide/devices.rst defines the following f=
or VME:
  *
  * 221 char	VME bus
  *		  0 =3D /dev/bus/vme/m0		First master image
diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeleto=
nfb.c
index f948baa16d82..e219a0a22077 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -836,7 +836,7 @@ static void xxxfb_remove(struct pci_dev *dev)
  *	@dev: PCI device
  *	@msg: the suspend event code.
  *
- *      See Documentation/power/devices.txt for more information
+ *      See Documentation/power/admin-guide/devices.rst for more informati=
on
  */
 static int xxxfb_suspend(struct pci_dev *dev, pm_message_t msg)
 {
@@ -851,7 +851,7 @@ static int xxxfb_suspend(struct pci_dev *dev, pm_messag=
e_t msg)
  *	xxxfb_resume - Optional but recommended function. Resume the device.
  *	@dev: PCI device
  *
- *      See Documentation/power/devices.txt for more information
+ *      See Documentation/power/admin-guide/devices.rst for more informati=
on
  */
 static int xxxfb_resume(struct pci_dev *dev)
 {
@@ -915,7 +915,7 @@ static void __exit xxxfb_exit(void)
  *	@dev: platform device
  *	@msg: the suspend event code.
  *
- *      See Documentation/power/devices.txt for more information
+ *      See Documentation/power/admin-guide/devices.rst for more informati=
on
  */
 static int xxxfb_suspend(struct platform_device *dev, pm_message_t msg)
 {
@@ -930,7 +930,7 @@ static int xxxfb_suspend(struct platform_device *dev, p=
m_message_t msg)
  *	xxxfb_resume - Optional but recommended function. Resume the device.
  *	@dev: platform device
  *
- *      See Documentation/power/devices.txt for more information
+ *      See Documentation/power/admin-guide/devices.rst for more informati=
on
  */
 static int xxxfb_resume(struct platform_dev *dev)
 {
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 77590320d44c..623f72334fa5 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -75,7 +75,7 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 	 Allow virtio-mmio devices instantiation via the kernel command line
 	 or module parameters. Be aware that using incorrect parameters (base
 	 address in particular) can crash your system - you have been warned.
-	 See Documentation/kernel-parameters.txt for details.
+	 See Documentation/admin-guide/kernel-parameters.rst for details.
=20
 	 If unsure, say 'N'.
=20
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 4c09d93d9569..b2f82cf6bf86 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -170,8 +170,8 @@ config BINFMT_MISC
=20
 	  You can do other nice things, too. Read the file
 	  <file:Documentation/binfmt_misc.txt> to learn how to use this
-	  feature, <file:Documentation/java.txt> for information about how
-	  to include Java support. and <file:Documentation/mono.txt> for
+	  feature, <file:Documentation/admin-guide/java.rst> for information abou=
t how
+	  to include Java support. and <file:Documentation/admin-guide/mono.rst> =
for
           information about how to include Mono-based .NET support.
=20
           To use binfmt_misc, you will need to mount it:
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index be40813eff52..b42e5bd6d8ff 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -86,4 +86,4 @@ config PSTORE_RAM
 	  Note that for historical reasons, the module will be named
 	  "ramoops.ko".
=20
-	  For more information, see Documentation/ramoops.txt.
+	  For more information, see Documentation/admin-guide/ramoops.rst.
diff --git a/include/linux/device.h b/include/linux/device.h
index bc41e87a969b..36d3a9867da9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -733,7 +733,7 @@ struct device_dma_parameters {
  * 		minimizes board-specific #ifdefs in drivers.
  * @driver_data: Private pointer for driver specific info.
  * @power:	For device power management.
- * 		See Documentation/power/devices.txt for details.
+ * 		See Documentation/power/admin-guide/devices.rst for details.
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06eb353182ab..efa67b2dfee9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -258,7 +258,7 @@ typedef struct pm_message {
  * example, if it detects that a child was unplugged while the system was
  * asleep).
  *
- * Refer to Documentation/power/devices.txt for more information about the=
 role
+ * Refer to Documentation/power/admin-guide/devices.rst for more informati=
on about the role
  * of the above callbacks in the system suspend process.
  *
  * There also are callbacks related to runtime power management of devices=
.
diff --git a/include/uapi/linux/major.h b/include/uapi/linux/major.h
index 620252e69b44..19e195bee990 100644
--- a/include/uapi/linux/major.h
+++ b/include/uapi/linux/major.h
@@ -3,7 +3,7 @@
=20
 /*
  * This file has definitions for major device numbers.
- * For the device number assignments, see Documentation/devices.txt.
+ * For the device number assignments, see Documentation/admin-guide/device=
s.rst.
  */
=20
 #define UNNAMED_MAJOR		0
diff --git a/init/Kconfig b/init/Kconfig
index 34407f15e6d3..172f80ea0d58 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1306,7 +1306,7 @@ config BLK_DEV_INITRD
 	  boot loader (loadlin or lilo) and that is mounted as root
 	  before the normal boot procedure. It is typically used to
 	  load modules needed to mount the "real" root file system,
-	  etc. See <file:Documentation/initrd.txt> for details.
+	  etc. See <file:Documentation/admin-guide/initrd.rst> for details.
=20
 	  If RAM disk support (BLK_DEV_RAM) is also included, this
 	  also enables initial RAM disk (initrd) support and adds
diff --git a/init/main.c b/init/main.c
index 2858be732f6d..691eb9351a83 100644
--- a/init/main.c
+++ b/init/main.c
@@ -980,7 +980,7 @@ static int __ref kernel_init(void *unused)
 		return 0;
=20
 	panic("No working init found.  Try passing init=3D option to kernel. "
-	      "See Linux Documentation/init.txt for guidance.");
+	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
=20
 static noinline void __init kernel_init_freeable(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 33bc56cf60d7..d2df3a93284b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -13,7 +13,7 @@ config PRINTK_TIME
 	  be included, not that the timestamp is recorded.
=20
 	  The behavior is also controlled by the kernel command line
-	  parameter printk.time=3D1. See Documentation/kernel-parameters.txt
+	  parameter printk.time=3D1. See Documentation/admin-guide/kernel-paramet=
ers.rst
=20
 config MESSAGE_LOGLEVEL_DEFAULT
 	int "Default message log level (1-7)"
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a8368d1c4348..d0c729ccec20 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2187,7 +2187,7 @@ sub process {
=20
 		if ($rawline=3D~/^\+\+\+\s+(\S+)/) {
 			$setup_docs =3D 0;
-			if ($1 =3D~ m@Documentation/kernel-parameters.txt$@) {
+			if ($1 =3D~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
 				$setup_docs =3D 1;
 			}
 			#next;
@@ -5102,7 +5102,7 @@ sub process {
 		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
 		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
 			WARN("VOLATILE",
-			     "Use of volatile is usually wrong: see Documentation/volatile-cons=
idered-harmful.txt\n" . $herecurr);
+			     "Use of volatile is usually wrong: see Documentation/process/volat=
ile-considered-harmful.rst\n" . $herecurr);
 		}
=20
 # Check for user-visible strings broken across lines, which breaks the abi=
lity
@@ -5817,7 +5817,7 @@ sub process {
=20
 			if (!grep(/$name/, @setup_docs)) {
 				CHK("UNDOCUMENTED_SETUP",
-				    "__setup appears un-documented -- check Documentation/kernel-param=
eters.txt\n" . $herecurr);
+				    "__setup appears un-documented -- check Documentation/admin-guide/=
kernel-parameters.rst\n" . $herecurr);
 			}
 		}
=20
diff --git a/tools/testing/selftests/futex/README b/tools/testing/selftests=
/futex/README
index 0558bb9ce0a6..f3926c33ed4c 100644
--- a/tools/testing/selftests/futex/README
+++ b/tools/testing/selftests/futex/README
@@ -59,4 +59,4 @@ o FIXME: decide on a sane test naming scheme.  Currently =
the tests are named
 Coding Style
 ------------
 o The Futex Test project adheres to the coding standards set forth by Linu=
x
-  kernel as defined in the Linux source Documentation/CodingStyle.
+  kernel as defined in the Linux source Documentation/process/coding-style=
.rst.
--=20
2.7.4


--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
