Return-Path: <rtc-linux+bncBCAJFDXE4QGBBPMGWKVAKGQEQHGTC7Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com. [2607:f8b0:400e:c02::232])
        by gmr-mx.google.com with ESMTPS id jr5si558417pbb.1.2015.05.08.02.34.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 02:34:52 -0700 (PDT)
Received: by mail-pd0-x232.google.com with SMTP id qd1so73718353pdb.2
        for <rtc-linux@googlegroups.com>; Fri, 08 May 2015 02:34:52 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Brecht Machiels <brecht@mos6581.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Borislav Petkov <bp@suse.de>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [rtc-linux] [RFC PATCH 0/2] rtc: Prevent the automatic reboot after
 powering off the system
Date: Fri,  8 May 2015 17:33:38 +0800
Message-Id: <1431077618-3435-1-git-send-email-adrianhuang0701@gmail.com>
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

Can someone help verify the patchset if he/she has the failed
machine? Thanks in advance.

Adrian Huang (2):
  Revert "rtc-cmos: Add an alarm disable quirk"
  rtc: restore the rtc alarm time to the configured alarm time in BIOS
    setup

 drivers/rtc/interface.c | 21 ++++++++++++++++++++
 drivers/rtc/rtc-cmos.c  | 52 -------------------------------------------------
 drivers/rtc/rtc-dev.c   |  1 +
 include/linux/rtc.h     |  1 +
 4 files changed, 23 insertions(+), 52 deletions(-)

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
