Return-Path: <rtc-linux+bncBDI57DN47YOBBXEPZK6QKGQEX3OSWQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com. [209.85.161.173])
        by gmr-mx.google.com with ESMTPS id f206si1541067ywb.6.2016.08.15.20.26.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 20:26:19 -0700 (PDT)
Received: by mail-yw0-f173.google.com with SMTP id j12so36758061ywb.2
        for <rtc-linux@googlegroups.com>; Mon, 15 Aug 2016 20:26:19 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	x86@kernel.org
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	dzickus@redhat.com,
	dyoung@redhat.com,
	a.zummo@towertech.it,
	Pratyush Anand <panand@redhat.com>
Subject: [rtc-linux] [PATCH V3 0/2] rtc-cmos: Workaround unwanted interrupt generation
Date: Tue, 16 Aug 2016 08:55:42 +0530
Message-Id: <cover.1470985727.git.panand@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We have observed on few machines with rtc-cmos devices that it generates
an interrupt before the hpet_rtc_timer_init() call is finished. This leads
to hpet_rtc_interrupt() being called before it is fully initialized.

Therefore the while-loop of hpet_cnt_ahead() in hpet_rtc_timer_reinit()
never completes. This leads to "NMI watchdog: Watchdog detected hard LOCKUP
on cpu 0".

This patch set initializes hpet_default_delta and hpet_t1_cmp before
interrupt can be raised.

Changes since V2:
  - Improved commit log further
Changes since RFC:
  - Commit log of patches has been improved.

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
