Return-Path: <rtc-linux+bncBDI57DN47YOBBLUZ5K5QKGQEQH3UF6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com. [209.85.220.174])
        by gmr-mx.google.com with ESMTPS id x204si217493ywb.1.2016.07.04.09.19.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 09:19:58 -0700 (PDT)
Received: by mail-qk0-f174.google.com with SMTP id t127so269228802qkf.1
        for <rtc-linux@googlegroups.com>; Mon, 04 Jul 2016 09:19:58 -0700 (PDT)
Date: Mon, 4 Jul 2016 21:49:48 +0530
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org, alexandre.belloni@free-electrons.com,
	Thomas Gleixner <tglx@linutronix.de>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	prarit@redhat.com
Subject: [rtc-linux] Re: [PATCH RFC 0/2] rtc-cmos: Workaround unwanted
 interrupt generation
Message-ID: <20160704161948.GB11075@dhcppc9>
References: <cover.1466484019.git.panand@redhat.com>
 <20160627044907.GA29870@dhcppc9>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160627044907.GA29870@dhcppc9>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 27/06/2016:10:19:07 AM, Pratyush Anand wrote:
> On 21/06/2016:10:25:34 AM, Pratyush Anand wrote:
> > We have observed on few machines with rtc-cmos device that
> > hpet_rtc_interrupt() is called before cmos_do_probe() could call
> > hpet_rtc_timer_init(). It has not been observed during normal boot/reboot
> > of machines. It *sometime* happens when system is booted with kdump
> > secondary kernel. So, neither hpet_default_delta nor hpet_t1_cmp is
> > initialized by the time interrupt is raised in the given situation.
> > Therefore while loop of hpet_cnt_ahead() in hpet_rtc_timer_reinit() never
> > completes. This leads to "NMI watchdog: Watchdog detected hard LOCKUP on
> > cpu 0".
> > 
> > I am still clueless, how can an interrupt be raised before RTC is enabled.
> > But i do not have any idea about this device, so I am putting this patch as
> > RFC to get feedback from hpet/rtc-cmos developer. I am sure there would be
> > some better solution than this.
> 
> Do you think that if I improve commit log of patches as pointed by Thomas and
> send a formal version of these patches, then they should acceptable to upstream?

A gentle reminder for your comment/feedback :-)

~Pratyush

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
