Return-Path: <rtc-linux+bncBDI57DN47YOBBDXNXO6AKGQE53CYD4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com. [209.85.192.170])
        by gmr-mx.google.com with ESMTPS id a133si77389pfa.0.2016.07.19.20.57.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2016 20:57:02 -0700 (PDT)
Received: by mail-pf0-f170.google.com with SMTP id h186so14238834pfg.3
        for <rtc-linux@googlegroups.com>; Tue, 19 Jul 2016 20:57:02 -0700 (PDT)
Date: Wed, 20 Jul 2016 09:26:59 +0530
From: Pratyush Anand <panand@redhat.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org,
	hpa@zytor.com, x86@kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	open list <linux-kernel@vger.kernel.org>,
	Prarit Bhargava <prarit@redhat.com>,
	RuiRui Yang <dyoung@redhat.com>
Subject: [rtc-linux] Re: [PATCH RFC 0/2] rtc-cmos: Workaround unwanted
 interrupt generation
Message-ID: <20160720035659.GA4797@localhost.localdomain>
References: <cover.1466484019.git.panand@redhat.com>
 <20160627044907.GA29870@dhcppc9>
 <20160704161948.GB11075@dhcppc9>
 <CAHB_Gup0uaOrr9R5qaydc2057o-L290Jwqd2iC0-+tsEwzKbQQ@mail.gmail.com>
 <20160719142907.GG7132@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160719142907.GG7132@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/07/2016:04:29:07 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 18/07/2016 at 17:17:44 +0530, Pratyush Anand wrote :
> > Hi RTC-Maintainers,
> > 
> > 
> > On Mon, Jul 4, 2016 at 9:49 PM, Pratyush Anand <panand@redhat.com> wrote:
> > > On 27/06/2016:10:19:07 AM, Pratyush Anand wrote:
> > >> On 21/06/2016:10:25:34 AM, Pratyush Anand wrote:
> > >> > We have observed on few machines with rtc-cmos device that
> > >> > hpet_rtc_interrupt() is called before cmos_do_probe() could call
> > >> > hpet_rtc_timer_init(). It has not been observed during normal boot/reboot
> > >> > of machines. It *sometime* happens when system is booted with kdump
> > >> > secondary kernel. So, neither hpet_default_delta nor hpet_t1_cmp is
> > >> > initialized by the time interrupt is raised in the given situation.
> > >> > Therefore while loop of hpet_cnt_ahead() in hpet_rtc_timer_reinit() never
> > >> > completes. This leads to "NMI watchdog: Watchdog detected hard LOCKUP on
> > >> > cpu 0".
> > >> >
> > >> > I am still clueless, how can an interrupt be raised before RTC is enabled.
> > >> > But i do not have any idea about this device, so I am putting this patch as
> > >> > RFC to get feedback from hpet/rtc-cmos developer. I am sure there would be
> > >> > some better solution than this.
> > >>
> > >> Do you think that if I improve commit log of patches as pointed by Thomas and
> > >> send a formal version of these patches, then they should acceptable to upstream?
> > >
> > > A gentle reminder for your comment/feedback :-)
> > 
> > Please let me know how to make progress on this. If you think, there
> > could be some better way to handle this issue then please let me know.
> > If you need any more data then also please let me know.
> > 
> 
> Well, the change is x86 specific and I don't know much about HPET so
> until you get an ack from the x86 maintainers, I guess I can't help
> much.

Thanks Alexandre for your reply.

Thomas, Ingo, Peter, Your comment/feedback will be very helpful to make progress
on this.

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
