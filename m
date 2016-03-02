Return-Path: <rtc-linux+bncBDEKVJM7XAHRBV6Z3K3AKGQEJNUCB7I@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id w128si112740wmd.0.2016.03.02.01.05.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2016 01:05:26 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kyle McMartin <kyle@mcmartin.ca>, RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 1/6] rtc: generic: allow building on all architectures
Date: Wed, 02 Mar 2016 10:05:18 +0100
Message-ID: <1620536.OtjnSSLgCT@wuerfel>
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de> <1456851608-3374907-2-git-send-email-arnd@arndb.de> <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday 02 March 2016 09:57:27 Geert Uytterhoeven wrote:
> > @@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
> >         .read_time = generic_get_time,
> >         .set_time = generic_set_time,
> >  };
> > +#else
> > +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
> > +#endif
> >
> >  static int __init generic_rtc_probe(struct platform_device *dev)
> >  {
> >         struct rtc_device *rtc;
> > +       const struct rtc_class_ops *ops;
> > +
> > +       ops = dev_get_platdata(&dev->dev);
> > +       if (!ops)
> > +               ops = &generic_rtc_ops;
> 
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

It's a bit odd, but I think it's syntactically correct C, and not
much too different from 

#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)

is it? My last patch gets rid of it again.

	Arnd

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
