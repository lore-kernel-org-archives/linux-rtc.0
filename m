Return-Path: <rtc-linux+bncBDI57DN47YOBBTMWQG6QKGQE5HIWAII@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com. [209.85.192.182])
        by gmr-mx.google.com with ESMTPS id z4si229184pam.0.2016.08.02.00.27.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 00:27:08 -0700 (PDT)
Received: by mail-pf0-f182.google.com with SMTP id x72so63743638pfd.2
        for <rtc-linux@googlegroups.com>; Tue, 02 Aug 2016 00:27:08 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	x86@kernel.org
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	dyoung@redhat.com,
	a.zummo@towertech.it,
	Pratyush Anand <panand@redhat.com>
Subject: [rtc-linux] [PATCH V2 0/2] rtc-cmos: Workaround unwanted interrupt generation
Date: Tue,  2 Aug 2016 12:56:58 +0530
Message-Id: <cover.1470122380.git.panand@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We have observed on few machines with rtc-cmos device that
hpet_rtc_interrupt() is called before cmos_do_probe() could call
hpet_rtc_timer_init(). It has not been observed during normal boot/reboot
of machines. It *sometime* happens when system is booted with kdump
secondary kernel. So, neither hpet_default_delta nor hpet_t1_cmp is
initialized by the time interrupt is raised in the given situation.
Therefore while loop of hpet_cnt_ahead() in hpet_rtc_timer_reinit() never
completes. This leads to "NMI watchdog: Watchdog detected hard LOCKUP on
cpu 0".

These patch set initializes hpet_default_delta and hpet_t1_cmp before
interrupt can be raised.

Changes since RFC:
  - Commit log of patches has been improved.
  - RFCs were here: https://lkml.org/lkml/2016/6/21/35

Pratyush Anand (2):
  rtc/hpet: Factorize hpet_rtc_timer_init()
  rtc/rtc-cmos: Initialize software counters before irq is registered

 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 41 +++++++++++++++++++++++++++++++++++------
 drivers/rtc/rtc-cmos.c      | 13 ++++++++++++-
 3 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
