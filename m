Return-Path: <rtc-linux+bncBDDNDZNP7UOBBO5ZSTAQKGQEEGVLV6Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl. [79.96.170.134])
        by gmr-mx.google.com with ESMTPS id o62si2431992wmg.3.2016.11.10.17.19.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Nov 2016 17:19:54 -0800 (PST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: John Stultz <john.stultz@linaro.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>
Subject: [rtc-linux] Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep
 time if pm_trace is enabled
Date: Fri, 11 Nov 2016 02:27:13 +0100
Message-ID: <2641376.PTl7Fxfrgz@vostro.rjw.lan>
In-Reply-To: <CALAqxLXVaVWBTNs2w-4t6wNsPukQu40wgVcM9B9zudv2KL682Q@mail.gmail.com>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com> <CALAqxLXVaVWBTNs2w-4t6wNsPukQu40wgVcM9B9zudv2KL682Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thursday, November 10, 2016 10:26:09 AM John Stultz wrote:
> On Wed, Nov 9, 2016 at 8:55 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> > Previously we encountered some memory overflow issues due to
> > the bogus sleep time brought by inconsistent rtc, which is
> > triggered when pm_trace is enabled, and we have fixed it
> > in recent kernel. However it's improper in the first place
> > to call __timekeeping_inject_sleeptime() in case that pm_trace
> > is enabled simply because that "hash" time value will wreckage
> > the timekeeping subsystem.
> >
> > This patch is originally written by Thomas, which would bypass
> > the bogus rtc interval when pm_trace is enabled.
> > Meanwhile, if system succeed to resume back with pm_trace set, the
> > users are warned to adjust the bogus rtc either by ntp-date or rdate,
> > by resetting pm_trace_rtc_abused to false, otherwise above tools might
> > not work as expected.
> >
> > Originally-from: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Xunlei Pang <xlpang@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> 
> Looks ok to me. I'm queueing it up for testing.  If no one objects
> (and I don't see any issues) I'll merge it to my tree and push it to
> -tip through Thomas.

No objections here, thanks John!

Cheers,
Rafael

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
