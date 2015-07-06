Return-Path: <rtc-linux+bncBCAJFDXE4QGBBC4E5CWAKGQEI3US4ZQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com. [2607:f8b0:400e:c02::22d])
        by gmr-mx.google.com with ESMTPS id tq2si1725347pbc.0.2015.07.05.21.20.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2015 21:20:27 -0700 (PDT)
Received: by mail-pd0-x22d.google.com with SMTP id ep18so98208868pdb.1
        for <rtc-linux@googlegroups.com>; Sun, 05 Jul 2015 21:20:27 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Egbert Eich <eich@suse.com>,
	Diego Ercolani <diego.ercolani@gmail.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Max Asbock <amax@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [rtc-linux] [RFC PATCH v4 0/2] rtc: Prevent the automatic reboot
 after powering off the system
Date: Mon,  6 Jul 2015 12:19:11 +0800
Message-Id: <1436156353-3599-1-git-send-email-adrianhuang0701@gmail.com>
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

Changes from v3:
  * Add Tested-by tags

Changes from v2:
  * Drop the approach "Clear interrupt flag if alarm time is less
    equal to now+1". Instead, cancel the alarm if the configured 
    alarm time is equal to now+1 seconds. (Suggested by Alexandre)

Changes from v1:
  * Change the order of [PATCH 1/2] and [PATCH 2/2] (per Borislav)
  * Drop the approach "RTC alarm timer restoration approach". Instead,
    [PATCH 1/2] makes sure that AF is cleared in cmos_do_shutdown()
    before powering off the machine. (Suggested by Alexandre)

Adrian Huang (2):
  rtc-cmos: Cancel alarm timer if alarm time is equal to now+1 seconds
  rtc-cmos: Revert "rtc-cmos: Add an alarm disable quirk"

 drivers/rtc/rtc-cmos.c | 113 ++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 53 deletions(-)

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
