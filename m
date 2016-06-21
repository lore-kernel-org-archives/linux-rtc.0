Return-Path: <rtc-linux+bncBDI57DN47YOBBW4RUO5QKGQEPZGDZJA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com. [209.85.220.181])
        by gmr-mx.google.com with ESMTPS id k133si54461ywc.3.2016.06.20.21.55.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 21:55:55 -0700 (PDT)
Received: by mail-qk0-f181.google.com with SMTP id c73so6422861qkg.2
        for <rtc-linux@googlegroups.com>; Mon, 20 Jun 2016 21:55:55 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	Pratyush Anand <panand@redhat.com>
Subject: [rtc-linux] [PATCH RFC 0/2] rtc-cmos: Workaround unwanted interrupt generation
Date: Tue, 21 Jun 2016 10:25:34 +0530
Message-Id: <cover.1466484019.git.panand@redhat.com>
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

I am still clueless, how can an interrupt be raised before RTC is enabled.
But i do not have any idea about this device, so I am putting this patch as
RFC to get feedback from hpet/rtc-cmos developer. I am sure there would be
some better solution than this.



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
