Return-Path: <rtc-linux+bncBCNNJWF7RUMRBBXVVK2AKGQE7LTHHQI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id p88si8636075pfi.0.2016.01.04.10.31.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 10:31:34 -0800 (PST)
Received: by mail-pa0-x241.google.com with SMTP id a20so10369311pag.3
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 10:31:34 -0800 (PST)
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
Subject: [rtc-linux] [PATCH v2 0/8] rtc: enable adjustment of clock offset
Date: Mon,  4 Jan 2016 10:31:18 -0800
Message-Id: <cover.1451928661.git.stillcompiling@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Alexandre,
this is the second version of apatch set to be able to adjust the
clock on a pcf2123, but with a big addition. I am also proposing
a couple of new rtc api functions and a new sysfs file.

Patches 1-5 are very much v2 patches that address All of the
concerns you had with v1. It is my hope to get them merged without
too much more trouble.

Patches 6-8 are attemping to add a new function to the rtc class
to adjust the clock rate. I hope I am going about this the right way,
But here goes.

A number of rtc devices, such as the NXP pcf2123 include a facility
to adjust the clock in order to compensate for temperature or a
crystal, capacitor, etc, that results in the rtc clock not running
at exactly 32.768 kHz.

This patchset adds kernel and sysfs hooks to access that ability.

One datasheet suggests it might be adjusted based on input from 
a temperature sensor. I could also potentially see it being set
as part of ntp calibration.

Data sheets I have seen refer to this as a clock offset, and measure it
in parts per million (ppm), however they often reference ppm to 2 digits
of precision, which makes integer ppm less than ideal. I use parts per
billion, which more than covers the precision needed and works nicely
within 32 bits

The name "offset" came from the pcf-2123 datasheet and is used by at
least some other data sheets. I would be happy to use a different term
if someone else comes up with something more concise.
    
Changes since v1:
- Use the BIT() macro for all register bits
- Remove unneeded range checks from read/write functions
- Merge patch 3 (replace magic numbers with defines) into patch 2
- Add a proper commit message to patch 5, now patch 4
- Fix a function alignment bug.
- Move OSC_HAS_STOPPED check into pcf2123_rtc_read_time, and get rid of
  pcf2123_time_valid()
- Drop patches refactoring pcf2123 sysfs.
- Add rtc interface and rtc sysfs file for clock offset

Joshua Clayton (8):
  rtc-pcf2123: define registers and bit macros
  rtc-pcf2123: clean up reads from the chip
  rtc-pcf2123: clean up writes to the rtc chip
  rtc-pcf2123: refactor chip reset into a function
  rtc-pcf2123: avoid resetting the clock if possible
  rtc: Add functions to set and read clock offset
  rtc: implement a sysfs interface for clock offset
  rtc-pcf2123: implement read_offset and set_offset

 drivers/rtc/interface.c   |  57 ++++++++++
 drivers/rtc/rtc-pcf2123.c | 271 +++++++++++++++++++++++++++++++++-------------
 drivers/rtc/rtc-sysfs.c   |  29 +++++
 include/linux/rtc.h       |   4 +
 4 files changed, 284 insertions(+), 77 deletions(-)

-- 
2.5.0

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
