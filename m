Return-Path: <rtc-linux+bncBCAJFDXE4QGBBMH53KVQKGQES3QJVXY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com. [2607:f8b0:400e:c03::234])
        by gmr-mx.google.com with ESMTPS id xz5si625059pac.1.2015.06.09.03.23.43
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 03:23:43 -0700 (PDT)
Received: by mail-pa0-x234.google.com with SMTP id yx8so10965508pac.2
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 03:23:43 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Cc: Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Diego Ercolani <diego.ercolani@gmail.com>,
	Egbert Eich <eich@suse.com>,
	Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [rtc-linux] [RFC PATCH v2 0/2] rtc: Prevent the automatic reboot
 after powering off the system
Date: Tue,  9 Jun 2015 18:23:31 +0800
Message-Id: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") added the
alarm disable quirk to work around the broken BIOSes. The same symptom
is observed on Lenovo Thinkserver. Instead of adding the impacted
servers to the "alarm disable" quirk, this patchset aims at preventing
the issue so that the commit can be reverted. 

The brief description of the root cause is that: When configuring 
the RTC registers to setup a wake up event in the S5 handler (BIOS),
the handler does not clear the interrupt flag bits by reading 
Register C of CMOS RTC.

Changes from v1:
  * Change the order of [PATCH 1/2] and [PATCH 2/2] (per Borislav)
  * Drop the approach "RTC alarm timer restoration approach". Instead,
    [PATCH 1/2] makes sure that AF is cleared in cmos_do_shutdown()
    before powering off the machine. (Suggested by Alexandre)

Adrian Huang (2):
  rtc-cmos: Clear interrupt flag if alarm time is less equal to now+1
    seconds
  rtc-cmos: Revert "rtc-cmos: Add an alarm disable quirk"

 drivers/rtc/rtc-cmos.c | 113 ++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 54 deletions(-)

-- 
1.9.1

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
