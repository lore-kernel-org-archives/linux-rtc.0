Return-Path: <rtc-linux+bncBD7ZDTFR7QFRBQWAXGYAKGQEFRMPBGQ@googlegroups.com>
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id el2si1575624pbb.0.2015.10.02.03.45.22
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Oct 2015 03:45:22 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 01/17] rtc: pl031: remove misuse of
 IRQF_NO_SUSPEND flag
To: Linus Walleij <linus.walleij@linaro.org>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <560E603E.8080603@arm.com>
Date: Fri, 2 Oct 2015 11:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On 02/10/15 11:40, Linus Walleij wrote:
> On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>> be left enabled so as to allow them to work as expected during the
>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>> from a suspended state, enable_irq_wake is recommended to be used for
>> the wakeup.
>>
>> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
>> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: rtc-linux@googlegroups.com
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Looks correct to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks, while you are at it, do you know what interrupt stv2_pl031
shares so that I can fix the TODO in the comment or the code(whichever
applicable).

Regards,
Sudeep

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
