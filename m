Return-Path: <rtc-linux+bncBCKMZDW5VIHBBSP6ZGUQKGQEQX4KUJQ@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id k3si223210igf.1.2015.04.18.08.59.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 18 Apr 2015 08:59:04 -0700 (PDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YjV95-002zdb-Qs
	for rtc-linux@googlegroups.com; Sat, 18 Apr 2015 15:59:04 +0000
Message-ID: <55327E21.304@roeck-us.net>
Date: Sat, 18 Apr 2015 08:54:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: S Twiss <stwiss.opensource@diasemi.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 DEVICETREE <devicetree@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 LINUXINPUT <linux-input@vger.kernel.org>,
 LINUXKERNEL <linux-kernel@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
 Lee Jones <lee.jones@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>,
 Rob Herring <robh+dt@kernel.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>
CC: David Dajun Chen <david.chen@diasemi.com>,
 Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1 0/6]  COVER LETTER
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1429280614.git.stwiss.opensource@diasemi.com>
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

On 04/17/2015 07:23 AM, S Twiss wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
>
> This patch set adds support for the Dialog DA9062 Power Management IC.
>
> In this patch set the following is provided:
>   - [PATCH V1 1/6]: MFD core support
>   - [PATCH V1 2/6]: BUCK and LDO regulator driver
>   - [PATCH V1 3/6]: RTC driver
>   - [PATCH V1 4/6]: OnKey driver
>   - [PATCH V1 5/6]: Watchdog driver
>   - [PATCH V1 6/6]: Add bindings for all DA9062 components
>
> This patch applies against linux-next and v4.0
>
> Thank you,
> Steve Twiss, Dialog Semiconductor Ltd.
>

Hi Steve,

It might make sense to use something better than "COVER LETTER" as subject line.

Thanks,
Guenter

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
