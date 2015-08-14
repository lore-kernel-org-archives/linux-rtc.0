Return-Path: <rtc-linux+bncBDS7HNEFSALRBIWVW2XAKGQE3HB7IKA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt6si50780wib.1.2015.08.14.01.45.22
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Aug 2015 01:45:22 -0700 (PDT)
Date: Fri, 14 Aug 2015 10:45:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Felix Janda <felix.janda@posteo.de>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: as3772: Fix off-by-one error in month value
Message-ID: <20150814084515.GH22269@piout.net>
References: <20150801175924.GA5371@nyan>
 <20150812132759.GI3411@piout.net>
 <20150813193327.GA7843@nyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150813193327.GA7843@nyan>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/08/2015 at 21:33:27 +0200, Felix Janda wrote :
> So I should better not rewrite the commit message? At least the
> "CHROMIUM: " prefix of the title seems inappropriate.
> 

Indeed, you can adjust it, it should be:
rtc: as3722: correct month value

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
