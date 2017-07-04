Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBG5Q5XFAKGQERNMKHJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id t129si3929808wmt.2.2017.07.04.01.55.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 01:55:55 -0700 (PDT)
Message-ID: <1499158552.6885.1.camel@collabora.co.uk>
Subject: [rtc-linux] Re: [PATCH 1/2] RTC: s35390a: handle invalid RTC time
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Date: Tue, 04 Jul 2017 10:55:52 +0200
In-Reply-To: <20170629075651.jqa3jvxfer56dvh5@piout.net>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
	 <1484217818-27845-2-git-send-email-fabien.lahoudere@collabora.co.uk>
	 <20170116175018.z74inrcapwqqtbcz@piout.net>
	 <1484641457.20968.6.camel@collabora.co.uk>
	 <20170117110016.ids6xheti242lxhe@piout.net>
	 <1498470673.9477.3.camel@collabora.co.uk>
	 <20170629075651.jqa3jvxfer56dvh5@piout.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 2017-06-29 at 09:56 +0200, Alexandre Belloni wrote:
> On 26/06/2017 at 11:51:13 +0200, Fabien Lahoudere wrote:
> > > Actually, after reading the datasheet, I realize it is only POC that is
> > > reset to 0 after reading so isinvalid is not needed. Just read status1
> > > and look for BLD instead of caching it.
> > > 
> > 
> > isinvalid is also used in s35390a_set_datetime. So if I remove it how can I detect that time
> > setting
> > failed?
> > 
> 
> If it fails, simply don't reset BLD so it is still set when reading the
> time.
> 

In BLD section, datasheet says "When this flag is "1", be sure to initialize."
So I think we need those flags.

> > > I think it is probably worth separating s35390a_reset() into two
> > > functions. One that does the initialization and another one that reads
> > > status1 and immediately doest the initialization when POC is set. If BLD
> > > is set, then we can wait for set_time to happen before initializing.
> > > 
> 
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
