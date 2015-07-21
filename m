Return-Path: <rtc-linux+bncBAABBAOAXCWQKGQEYUCMUPQ@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.116])
        by gmr-mx.google.com with ESMTPS id t6si521584wiz.0.2015.07.21.03.33.36
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 03:33:36 -0700 (PDT)
Message-ID: <cover.1437474547.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 21 Jul 2015 11:29:07 +0100
Subject: [rtc-linux] [PATCH V3 0/3]  da9062: Add DA9062 RTC support using the
 existing DA9063 RTC driver
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, DEVICETREE
	<devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S
 Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
CC: David Dajun Chen <david.chen@diasemi.com>, Support Opensource
	<support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: S Twiss <stwiss.opensource@diasemi.com>

This patch set adds RTC support for the Dialog DA9062 Power Management IC.
Changes are made to the existing DA9063 RTC component so that functionality
in this device driver can be re-used to support the DA9062 RTC.

This following patch set is the proposed method for re-using existing kernel
RTC drivers for chips whose RTC blocks are functionally similar to the
DA9063 RTC.

There is already a precedence for reuse of this type in the kernel, see
linux-mainline/v4.1 drivers/rtc/rtc-pm8xxx.c +34
This patch set will follow that example.

The main points for the MFD core and device tree changes are as follows.

- Alteration of the DA9063 RTC Kconfig needs to be updated to depend on
  both MFD_DA9063 "or" MFD_DA9062. There is no explicit DA9062 RTC Kconfig.
- The DA9062 MFD core should add a new RTC resource as usual and an entry
  in the mfd_cell to support a component name and of_compatible for
  "da9062-rtc" and "dlg,da9062-rtc".
- The device tree binding support should include a compatible string for
  "dlg,da9062-rtc"

The main points for the RTC changes are as follows:

A generic structure is used (called da9063_compatible_rtc_regmap) to hold
all generic registers and bitmasks for use with this type of RTC component.

Functions in the DA9063 RTC will be refactored to use this compatibility
struct and all accesses to generic registers/masks will be made through
this table look-up instead of using defines from the register header files
directly

Linkage between the DA9062 MFD and the DA9063 RTC driver is created through
the use of an of_match_table entry in the platform_driver structure.
A re-work of da9063_rtc_probe() is necessary to use the of_match_node() and
dev_get_regmap() functions: this will provide initialisation of the generic
registers and masks and allow access to the regmap according to the correct
device tree specification.

The addition of a of_device_id table for DA9063 and DA9062 default data
is created. This method of initialisation for the DA9063 RTC component
works well for different chip types, and is only slightly complicated when
distinguishing the difference between support for DA9063-AD and DA9063-BB.

In this patch set the following is provided:
 - [PATCH V3 1/3]: MFD changes in DA9062 to support RTC
 - [PATCH V3 2/3]: Device tree bindings for DA9062 RTC component
 - [PATCH V3 3/3]: Update existing DA9063 RTC to add DA9062 support

This patch applies against linux-next and next-20150708 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

Changes in V2:
 - Reorder patches RFC PATCH 3/3 and 2/3 to remove the checkpatch warning
   > WARNING: DT compatible string "dlg,da9062-rtc" appears un-documented

S Twiss (3):
  mfd: da9062: Support for the DA9063 RTC in the DA9062 core
  devicetree: da9062: Add device tree bindings for DA9062 RTC
  rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver

 Documentation/devicetree/bindings/mfd/da9062.txt |   9 +
 drivers/mfd/da9062-core.c                        |  11 +
 drivers/rtc/Kconfig                              |   6 +-
 drivers/rtc/rtc-da9063.c                         | 391 ++++++++++++++++-------
 4 files changed, 302 insertions(+), 115 deletions(-)

-- 
end-of-patch for PATCH V3

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
