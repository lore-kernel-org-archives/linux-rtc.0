Return-Path: <rtc-linux+bncBC3ZPIWN3EFBBFPEWKWAKGQEK6ONSTY@googlegroups.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com. [2607:f8b0:4001:c03::236])
        by gmr-mx.google.com with ESMTPS id f17si9702igt.0.2015.06.25.18.59.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 18:59:48 -0700 (PDT)
Received: by mail-ie0-x236.google.com with SMTP id mu5so66523628ieb.1
        for <rtc-linux@googlegroups.com>; Thu, 25 Jun 2015 18:59:48 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150625191642.GA16184@piout.net>
References: <20150625191642.GA16184@piout.net>
Date: Thu, 25 Jun 2015 18:59:48 -0700
Message-ID: <CA+55aFzyTuindK63-jiYBdq-uB=_WWO0dgPciurgdFALz62iWQ@mail.gmail.com>
Subject: [rtc-linux] Re: [GIT PULL] RTC for 4.2
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jun 25, 2015 at 12:16 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
>
> Here is the pull-request for the RTC susbsystem for 4.2. This is my
> first pull-request to you, don't hesitate to tell me if I need to adjust
> something.

Looks fine, but:

> Conflicts:
>    drivers/rtc/Makefile
>
> Trivial add/add conflicts with the mfd tree, solved in linux-next
> Resolution: take both sides.

That's not the resolution I took - the re-sorting of the file made for
more complex.

Can you check my resolution?

                    Linus

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
