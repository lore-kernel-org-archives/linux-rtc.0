Return-Path: <rtc-linux+bncBDE6RCFOWIARB7XSZCYAKGQEPHPA6JQ@googlegroups.com>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com. [209.85.214.178])
        by gmr-mx.google.com with ESMTPS id o1si317896igp.1.2015.10.05.01.49.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 01:49:01 -0700 (PDT)
Received: by obcgx8 with SMTP id gx8so123197296obc.3
        for <rtc-linux@googlegroups.com>; Mon, 05 Oct 2015 01:49:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <560E603E.8080603@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	<1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
	<CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
	<560E603E.8080603@arm.com>
Date: Mon, 5 Oct 2015 10:49:01 +0200
Message-ID: <CACRpkdYURqgeh9kzED7yvwgR29qUPd9KgxrTAXZkAUdXazoJLA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 01/17] rtc: pl031: remove misuse of
 IRQF_NO_SUSPEND flag
From: Linus Walleij <linus.walleij@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
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

On Fri, Oct 2, 2015 at 12:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>> Looks correct to me.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks, while you are at it, do you know what interrupt stv2_pl031
> shares so that I can fix the TODO in the comment or the code(whichever
> applicable).

This is shared with a hardware called RTT (real-time timer) that has
no upstream driver as of now.

Yours,
Linus Walleij

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
