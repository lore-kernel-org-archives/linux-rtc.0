Return-Path: <rtc-linux+bncBAABB4OU73DQKGQEUCPBJ3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id m13si2247325itb.2.2017.04.25.12.58.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 12:58:41 -0700 (PDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AEA7820204
	for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 19:58:39 +0000 (UTC)
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D0D5B201B4
	for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 19:58:37 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id x188so83041979itb.0
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 12:58:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425165824.GA10024@roeck-us.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <5f8fac22-4037-9983-436a-da8ff87d4b17@roeck-us.net> <CAJYdmeP+XEBPpUECO1rWpRDs-RVihc_va970jtv6iau3OuWMWA@mail.gmail.com>
 <20170425161743.GA8443@roeck-us.net> <20170425163204.rj6on6phtbfuvcd7@piout.net>
 <20170425165824.GA10024@roeck-us.net>
From: Moritz Fischer <mdf@kernel.org>
Date: Tue, 25 Apr 2017 12:58:36 -0700
Message-ID: <CAJYdmePpHcYgjiCf=eWCkBBNBTTw4jW59_VNR6w44Yj_QDQqng@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/2] DS1374 Watchdog fixes
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>,
	linux-watchdog@vger.kernel.org, wim@iguana.be, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, alex.williams@ni.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Apr 25, 2017 at 09:58:24AM -0700, Guenter Roeck wrote:

> Ah, I missed the "n" in various #ifndef statements.
>
> I can't really comment on how to solve that; I simply don't know.
> Also, even with a dt property, it still would be necessary to have
> a non-DT means to configure one or the other. Making whatever solution
> backward compatible also seems tricky; I don't have a solution for that
> problem either.

How does one do these things in a non-dt context? Platform data? I'd let
the MFD select the 'mode'. Maybe being backwards compatible isn't
possible in any case. Is there a rule somewhere that we guarantee you'll
never have to change your CONFIG_FOO options?

>
> > > > The idea was to fix what's broken currently (this patchset) and then refactor.
> > > > But if you prefer I can do all in one go instead.
> > > >
> > >
> > > It just seemed a waste to me to change/fix a function which is going to
> > > be removed in a subsequent patch (I seem to recall that there was a fix
> > > to the ioctl function).
> > >
> >
> > I'd say that it depends on whether you want to backport the fixes to the
> > stable kernels. Backporting the full rework is probably riskier.

I suck at communicating these days. But yeah. That was basically my
concern when I split it up into 'Fixes' and 'Rework'.

Mostly since the rework might take a couple of rounds of review, while the
fix can unbrick stuff (might still need review of course)

Cheers,

Moritz

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
