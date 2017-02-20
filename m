Return-Path: <rtc-linux+bncBDXMLNOH5ANRBTNYVLCQKGQEMOXHLPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id 23si2293721pfw.4.2017.02.19.23.35.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 23:35:41 -0800 (PST)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 0/1] Motorola CPCAP PMIC RTC
Date: Mon, 20 Feb 2017 08:35:34 +0100
Message-Id: <20170220073535.27393-1-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Here is a driver for the RTC found inside of the
Motorola Droid 4 based on linux-next 2017021.
I tried to set & get the time using hwclock and
used ./tools/testing/selftests/timers/rtctest.c:

$ ./rtctest 

			RTC Driver Test Example.

Counting 5 update (1/sec) interrupts from reading /dev/rtc0: 1 2 3 4 5
Again, from using select(2) on /dev/rtc: 1 2 3 4 5

Current RTC date/time is 20-2-2017, 07:11:22.
Alarm time now set to 07:11:27.
Waiting 5 seconds for alarm... okay. Alarm rang.

Periodic IRQ rate is 1Hz.
Counting 20 interrupts at:
2Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

			 *** Test complete ***

I did not include a patch for omap4-droid4-xt894.dts,
since the CPCAP DT entry has not yet been added. The
following DT snippet can be used for testing on droid4:

&cpcap {
	cpcap_rtc: rtc {
		compatible = "motorola,cpcap-rtc";

		interrupt-parent = <&cpcap>;
		interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
	};
};

-- Sebastian

Sebastian Reichel (1):
  rtc: cpcap: new rtc driver

 .../devicetree/bindings/rtc/cpcap-rtc.txt          |  13 +
 drivers/rtc/Kconfig                                |   7 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cpcap.c                            | 318 +++++++++++++++++++++
 4 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 create mode 100644 drivers/rtc/rtc-cpcap.c

-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
