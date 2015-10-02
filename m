Return-Path: <rtc-linux+bncBDE6RCFOWIARBYV6XGYAKGQETHJ2A6Y@googlegroups.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com. [209.85.214.179])
        by gmr-mx.google.com with ESMTPS id a11si624190igv.3.2015.10.02.03.41.37
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2015 03:41:37 -0700 (PDT)
Received: by mail-ob0-f179.google.com with SMTP id bh8so78753128obb.0
        for <rtc-linux@googlegroups.com>; Fri, 02 Oct 2015 03:41:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	<1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
Date: Fri, 2 Oct 2015 03:41:37 -0700
Message-ID: <CACRpkdZO2nPex=aKCXEw_Cpq7GMvJBAwiRq471mL-iwUVGZJMA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 02/17] rtc: ab8500: remove misuse of
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

On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
>
> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

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
