Return-Path: <rtc-linux+bncBCAJFDXE4QGBBIHSTOVQKGQEVKNACCQ@googlegroups.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com. [2a00:1450:400c:c05::22f])
        by gmr-mx.google.com with ESMTPS id p9si845376wiz.3.2015.05.28.04.16.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 04:16:47 -0700 (PDT)
Received: by mail-wi0-x22f.google.com with SMTP id mc15so120022553wic.1
        for <rtc-linux@googlegroups.com>; Thu, 28 May 2015 04:16:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150522100433.GK3244@piout.net>
References: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518220542.GW3338@piout.net>
	<CAHKZfL2+PKCzYcmL-XHC-33aXQ0hjZqOYLbbgN8O0sTvOFTj0A@mail.gmail.com>
	<20150522100433.GK3244@piout.net>
Date: Thu, 28 May 2015 19:16:47 +0800
Message-ID: <CAHKZfL1Mdq44J=pxbd8jXfhoBsy4wEpkrCMy4BAeHH_SPukCwA@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 2/2] rtc: Restore the RTC alarm time to
 the configured alarm time in BIOS Setup
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>,
	Borislav Petkov <bp@suse.de>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
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

Hi

On Fri, May 22, 2015 at 6:04 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> That's what I understood. How I see it is the following: your patch is
> reading and setting the alarm then clearing AF at a later point in the
> shutdown. This may as well be before that one second has elapsed so I
> don't feel this is a proper fix. Also, other RTCs don't suffer from that
> issue and this may actually break some of them.
>
> What I would do is ensure that AF gets cleared in cmos_do_shutdown()
> after setting the alarm to now or now - 1 when it is not used for
> wakeup/restart.
>

Good suggestion. I've prepared a patch based on your suggestion. It's
still under my local test. I'll submit the patch later after testing.

Thanks for the suggestion!

-- Adrian

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
